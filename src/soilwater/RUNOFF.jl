@system RUNOFF begin
    CN ~ hold
    POTINF ~ hold

    S(CN) => 254 * (100/CN - 1) ~ preserve(u"mm/d")

    ROF(POTINF, S) => begin
        if POTINF > 0.2 * S
            (POTINF - 0.2 * S)^2 / (POTINF + 0.8 * S)
        else
            0
        end
    end ~ track(u"mm/d")
end