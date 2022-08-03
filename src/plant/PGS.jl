@system PGS begin
    SWFAC1 ~ hold
    SWFAC2 ~ hold
    PD ~ hold
    SRAD ~ hold
    LAI ~ hold
    PT ~ hold
    
    ROWSPC: row_spacing => 60.0 ~ preserve(parameter, u"cm")
    SWFAC(SWFAC1, SWFAC2): swfac => min(SWFAC1, SWFAC2) ~ track
    
    Y1(ROWSPC, PD): canopy_light_extinction_coefficient => begin
        1.5 - 0.768*((ROWSPC*0.01)^2*PD)^0.1
    end ~ track
    
    PG(SRAD, PD, Y1, LAI, PT): potential_daily_dry_matter_increase => begin
        PT * 2.1u"g/MJ"*SRAD/PD*(1.0 - exp(-Y1*LAI))
    end ~ track(u"g/d")
end