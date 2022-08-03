using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: ESaS

@system ESaSController(ESaS, Controller) begin
    SWC ~ preserve(parameter, u"mm")
    FC ~ preserve(parameter, u"mm")
    ESp ~ preserve(parameter, u"mm/d")
    WP ~ preserve(parameter, u"mm")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config (
    :ESaS => (;
        SWC = 1u"mm",
        FC = 1u"mm",
        ESp = 1u"mm/d",
        WP = 1u"mm",
    ),
)

@testset "ESaS" begin
    r = simulate(ESaSController; config, stop = 5u"d")
end