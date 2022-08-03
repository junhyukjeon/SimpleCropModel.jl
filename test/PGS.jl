using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: PGS

@system PGSController(PGS, Controller) begin
    SWFAC1 ~ preserve(parameter)
    SWFAC2 ~ preserve(parameter)
    PD ~ preserve(parameter, u"m^-2")
    SRAD ~ preserve(parameter, u"MJ/m^2/d")
    LAI ~ preserve(parameter)
    PT ~ preserve(parameter)
    
    time(context.clock.time) ~ track(u"d")
end

config = @config(
    PGSController => (;
        SWFAC1 = 1,
        SWFAC2 = 1,
        PD = 5u"m^-2",
        SRAD = 0.5u"MJ/m^2/d",
        LAI = 1,
        PT = 1,
    ),
)

@testset "PGS" begin
    r = simulate(PGSController; config, stop = 5u"d")
end