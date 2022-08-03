using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: ETpS

@system ETpSController(ETpS, Controller) begin
    LAI ~ preserve(parameter)
    TMAX ~ preserve(parameter, u"°C")
    TMIN ~ preserve(parameter, u"°C")
    SRAD ~ preserve(parameter, u"MJ/m^2/d")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config (
    :ETpS => (;
        LAI = 1,
        TMAX = 25u"°C",
        TMIN = 1u"°C",
        SRAD = 1u"MJ/m^2/d",
    ),
)

@testset "ETpS" begin
    r = simulate(ETpSController; config, stop = 5u"d")
end