using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: STRESS

@system STRESSController(STRESS, Controller) begin
    WP ~ preserve(parameter, u"mm")
    FC ~ preserve(parameter, u"mm")
    SWC ~ preserve(parameter, u"mm")
    ST ~ preserve(parameter, u"mm")
    DP ~ preserve(parameter, u"cm")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config(
    :STRESSController => (;
        WP = 1u"mm",
        FC = 1u"mm",
        SWC = 1u"mm",
        ST = 1u"mm",
        DP = 145u"cm"
    ),
)

@testset "STRESS" begin
    r = simulate(STRESSController; config, stop = 5u"d")
end