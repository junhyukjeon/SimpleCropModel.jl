@system ESaS begin
    SWC ~ hold
    WP ~ hold
    FC ~ hold
    ESp ~ hold

    ESa(SWC, WP, FC, ESp): daily_soil_evaporation => begin
        ESp * (SWC - WP)/(FC - WP)
    end ~ track(min = 0, max = 1, u"mm/d")
end