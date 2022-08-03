@system STRESS begin
    WP ~ hold
    FC ~ hold
    SWC ~ hold
    ST ~ hold
    DP ~ hold
    STRESS_DEPTH=> 250 ~ preserve(u"mm", parameter)

    THE(WP, FC): drought_stress_threshold => WP + 0.75 * (FC - WP) ~ preserve(u"mm")
    
    SWFAC1(SWC, WP, THE): drought_stress_factor => begin
        if SWC < WP
            0.0
        elseif SWC > THE
            1.0
        else
            max(min((SWC - WP) / (THE - WP), 1.0), 0.0)
        end
    end ~ track
    
    WTABLE(SWC, FC, ST, DP) => begin
        SWC <= FC ? 0.0 : (SWC - FC) / (ST - FC) * DP
    end ~ track(u"mm")

    DWT(FC, SWC, DP, WTABLE) => begin
        SWC <= FC ? DP : DP - WTABLE
    end ~ track(u"mm")

    SWFAC2(SWC, FC, DWT, STRESS_DEPTH) => begin
        SWC <= FC ? 1.0 : DWT / STRESS_DEPTH 
    end ~ track(min=0, max=1)
end