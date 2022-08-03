using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: PTS

@system PTSController(PTS, Controller) begin
    TMIN ~ preserve(parameter, u"°C")
    TMAX ~ preserve(parameter, u"°C")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config (
    :PTSController => (;
        TMIN = 0u"°C",
        TMAX = 25u"°C",
    ),
)

@testset "PTS" begin
    r = simulate(PTSController; config, stop = 5u"d")
end