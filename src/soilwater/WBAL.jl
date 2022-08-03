@system WBAL begin
    TRAIN ~ hold
    TIRR ~ hold
    TESa ~ hold
    TEPa ~ hold
    TROF ~ hold
    TDRN ~ hold
    SWC0 ~ hold
    SWC ~ hold

    ΔSWC(SWC0, SWC) => SWC0 - SWC ~ track(u"mm")

    inflow(TRAIN, TIRR) => TRAIN + TIRR ~ track(u"mm")

    outflow(TESa, TEPa, TROF, TDRN) => TESa + TEPa + TROF + TDRN ~ track(u"mm")

    WATBAL(ΔSWC, inflow, outflow) => ΔSWC + inflow - outflow ~ track(u"mm")
end