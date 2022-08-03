@system DRAINE begin
    SWC ~ hold
    FC ~ hold
    DRNp ~ hold

    DRN(SWC, FC, DRNp): vertical_drainage => begin
        (SWC - FC) * DRNp
    end ~ track(min = 0, u"mm/d")
end 