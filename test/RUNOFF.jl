using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: RUNOFF

@system RUNOFFController(RUNOFF, Controller) begin
    CN ~ preserve(parameter)
    POTINF ~ preserve(parameter, u"mm/d")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config(
    :RUNOFF => (;
        CN = 1,
        POTINF = 1u"mm/d",
    ),
)

@testset "RUNOFF" begin
    r = simulate(RUNOFFController; config, stop = 5u"d")
end