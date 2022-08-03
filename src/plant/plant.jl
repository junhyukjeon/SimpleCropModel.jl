include("LAIS.jl")
include("PGS.jl")
include("PTS.jl")

@system Plant(LAIS, PGS, PTS) begin
    TMIN ~ hold
    TMAX ~ hold
    DATE ~ hold
    SWFAC ~ hold
    dLAI ~ hold
    LAI ~ hold
    Y1 ~ hold
    PG ~ hold
    PT ~ hold

    DOY(DATE) => Cropbox.Dates.dayofyear(DATE) ~ track::int(u"d")
    
    EMP1: empirical_coefficient_1       => 0.104 ~ preserve(parameter, u"m^2")
    EMP2: empirical_coefficient_2       => 0.64 ~ preserve(parameter)
    fc: fraction_to_canopy              => 0.85 ~ preserve(parameter)
    sla: specific_leaf_area             => 0.028 ~ preserve(parameter, u"m^2/g")
    intot: reproductive_stage_duration  => 300.0 ~ preserve(parameter, u"K*d")
    lai0: init_leaf_area_Index          => 0.013 ~ preserve(parameter, u"m^2/m^2")
    Lfmax: maximum_leaves               => 12.0 ~ preserve(parameter)
    n0: init_leaf_number                => 2.0 ~ preserve(parameter)
    nb: empirical_coefficient_3         => 5.3 ~ preserve(parameter)
    p1: dry_matter_removed              => 0.03 ~ preserve(parameter, u"g/K") 
    PD: plant_density                   => 5.0 ~ preserve(parameter, u"m^-2")
    rm: maximum_rate_leaves             => 0.100 ~ preserve(parameter, u"d^-1")
    tb: base_temperature                => 10.0 ~ preserve(parameter, u"°C")
    w0: init_total_dry_weight           => 0.3 ~ preserve(parameter, u"g/m^2")
    wc0: init_canopy_dry_weight         => 0.045 ~ preserve(parameter, u"g/m^2")
    wr0: init_root_dry_weight           => 0.255 ~ preserve(parameter, u"g/m^2")
    E: CH2O_plant_conversion_efficiency => 1.0 ~ preserve(parameter, u"g/g")

    VP(n, Lfmax): vegetative_phase => (n < Lfmax) ~ flag
    RP(n, Lfmax): reproductive_phase => (n >= Lfmax) ~ flag

    TMN(TMAX, TMIN) => 0.5(u"K"(TMAX) + u"K"(TMIN)) ~ track(u"°C")
    dn(rm, PT) => rm * PT ~ track(u"d^-1", when = VP)
    n(dn) ~ accumulate(init=n0, when = VP)

    di(TMN, tb) => begin
        tb <= TMN <= 25u"°C" ? TMN - tb : 0
    end ~ track(u"K", when = RP)
    int(di) ~ accumulate(u"K*d", when = RP)

    dw(E, PG, PD) => E * PG * PD ~ track(u"g/m^2/d")
    w(dw) ~ accumulate(u"g/m^2", init=w0)
    wc(fc, dw) => fc * dw ~ accumulate(u"g/m^2", init=wc0, when=VP)
    wr(fc, dw) => (1-fc) * dw ~ accumulate(u"g/m^2", init=wc0, when=VP)
    wf(dw) ~ accumulate(u"g/m^2", init=wc0, when=RP)

    endsim(int, intot) => (int > intot) ~ flag
end