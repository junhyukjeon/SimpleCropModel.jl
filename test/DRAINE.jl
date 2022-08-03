using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: DRAINE

@system DRAINEController(DRAINE, Controller) begin
    SWC ~ preserve(parameter, u"mm")
    FC ~ preserve(parameter, u"mm")
    DRNp ~ preserve(parameter, u"cm^3/cm^3/d")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config (
    :DRAINE => (;
        SWC = 1u"mm",
        FC = 1u"mm",
        DRNp = 1u"cm^3/cm^3/d",
    ),
)

@testset "DRAINE" begin
    r = simulate(DRAINEController; config, stop = 5u"d")
end