include("DRAINE.jl")
include("ESaS.jl")
include("ETpS.jl")
include("RUNOFF.jl")
include("STRESS.jl")
include("WBAL.jl")

@system SW(DRAINE, ESaS, ETpS, RUNOFF, STRESS, WBAL) begin
    DRN ~ hold
    ESa ~ hold
    ETp ~ hold
    ROF ~ hold
    LAI ~ hold
    SWFAC1 ~ hold
    SWFAC2 ~ hold

    t(context.clock.time) ~ preserve(u"hr")

    WPp => 0.06 ~ preserve(u"cm^3/cm^3", parameter)
    FCp => 0.17 ~ preserve(u"cm^3/cm^3", parameter)
    STp => 0.28 ~ preserve(u"cm^3/cm^3", parameter)
    DP  => 145 ~ preserve(u"cm", parameter)
    DRNp => 0.1 ~ preserve(u"cm^3/cm^3/d", parameter)
    CN => 55 ~ preserve(parameter)
    SWC0 => 246.5 ~ preserve(u"mm", parameter)

    calendar ~ hold
    i: irrigation_data ~ provide(index=:DATE, init=calendar.date, parameter)
    IRR ~ drive(from=i, u"mm/d")
    
    WP(DP, WPp) => DP * WPp ~ preserve(u"mm")
    FC(DP, FCp) => DP * FCp ~ preserve(u"mm")
    ST(DP, STp) => DP * STp ~ preserve(u"mm")

    POTINF(RAIN, IRR) => RAIN + IRR ~ track(u"mm/d")
    INF(POTINF, ROF) => POTINF - ROF ~ track(u"mm/d")

    ESp(ETp, LAI) => ETp * exp(-0.7 * LAI) ~ track(u"mm/d")
    EPp(ETp, LAI) => ETp * (1 - exp(-0.7 * LAI)) ~ track(u"mm/d")
    EPa(EPp, SWFAC1, SWFAC2) => EPp * min(SWFAC1, SWFAC2) ~ track(u"mm/d")

    dSWC(INF, ESa, EPa, DRN) => INF - ESa - EPa - DRN ~ track(u"mm/d")
    SWC(dSWC) ~ accumulate(u"mm", init=SWC0)

    TIRR(IRR) ~ accumulate(u"mm")
    TRAIN(RAIN) ~ accumulate(u"mm")
    TINF(INF) ~ accumulate(u"mm")
    TESa(ESa) ~ accumulate(u"mm")
    TEPa(EPa) ~ accumulate(u"mm")
    TDRN(DRN) ~ accumulate(u"mm")
    TROF(ROF) ~ accumulate(u"mm")
end