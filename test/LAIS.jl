using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: LAIS

@system LAISController(LAIS, Controller) begin
    EMP1 ~ preserve(parameter, u"m^2")
    EMP2 ~ preserve(parameter)
    sla ~ preserve(parameter, u"m^2/g")
    nb ~ preserve(parameter)
    p1 ~ preserve(parameter, u"g/K") 
    PD ~ preserve(parameter, u"m^-2")
    lai0 ~ preserve(parameter, u"m^2/m^2")
    
    n ~ preserve(parameter)
    SWFAC1 ~ preserve(parameter)
    SWFAC2 ~ preserve(parameter)
    di ~ preserve(parameter, u"K")
    PT ~ preserve(parameter)
    dn ~ preserve(parameter, u"d^-1")
    VP ~ preserve::Bool(parameter)
    
    time(context.clock.time) ~ track(u"d")
end

config = @config(
    LAISController => (;
        PD = 5u"m^-2",
        EMP1 = 1u"m^2",
        EMP2 = 1,
        nb = 3,
        p1 = 1u"g/K",
        sla = 1u"m^2/g",
        SWFAC1 = 1,
        SWFAC2 = 1,
        di = 1u"K",
        PT = 1,
        n = 1,
        dn = 1u"d^-1",
        VP = true,
        lai0 = 0.013u"m^2/m^2",
    ),
)

@testset "LAIS" begin
    r = simulate(LAISController; config, stop = 5u"d")
    visualize(r, :time, :LAI; kind = :line) |> println
end