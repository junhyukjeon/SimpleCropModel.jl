@system PTS begin
    TMIN ~ hold
    TMAX ~ hold
    
    PT(nounit(TMIN), nounit(TMAX)): growth_rate_reduction_factor => begin
        1 - 0.0025*((0.25*TMIN - 0.75*TMAX) - 26)^2
    end ~ track
end 