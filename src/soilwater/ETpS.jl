@system ETpS begin
    LAI ~ hold
    TMAX ~ hold
    TMIN ~ hold
    SRAD ~ hold

    ALB(LAI) =>  0.1 * exp(-0.7 * LAI) + 0.2 * (1 - exp(-0.7 * LAI)) ~ track

    Tmed(nounit(TMAX), nounit(TMIN)) => 0.6 * TMAX + 0.4 * TMIN ~ track

    EEQ(SRAD, ALB, Tmed) => SRAD * (4.88e-03 - 4.37e-03 * ALB)u"mm^3/J" * (Tmed + 29) ~ track(u"mm/d")

    f(nounit(TMAX)) => begin
        if TMAX < 5
            0.01 * exp(0.18(TMAX + 20))
        elseif TMAX > 35
            1.1 + 0.05 * (TMAX - 35)
        else
            1.1
        end
    end ~ track

    ETp(f, EEQ) => f * EEQ ~ track(u"mm/d")
end