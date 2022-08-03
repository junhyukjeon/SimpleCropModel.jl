@system LAIS begin
    PD ~ hold
    EMP1 ~ hold
    EMP2 ~ hold
    nb ~ hold
    p1 ~ hold
    sla ~ hold
    SWFAC1 ~ hold
    SWFAC2 ~ hold
    di ~ hold
    PT ~ hold
     n ~ hold
    dn ~ hold
    VP ~ hold
    lai0 ~ hold

    SWFAC(SWFAC1, SWFAC2): swfac => min(SWFAC1, SWFAC2) ~ track
    
    dLAI(SWFAC, PD, EMP1, EMP2, n, nb, PT, dn, di, p1, sla, VP) => begin
        if VP
            a = exp(EMP2 * (n - nb))  
            SWFAC * PD * EMP1 * PT * (a / (1 + a)) * dn 
        else
            - PD * di * p1 * sla
        end
    end ~ track(u"m^2/m^2/d")

    LAI(dLAI): leaf_area_index ~ accumulate(u"m^2/m^2", init=lai0)
end