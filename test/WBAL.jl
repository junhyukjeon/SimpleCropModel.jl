using Cropbox
using SimpleCropModel
using Test

using SimpleCropModel: WBAL

@system WBALController(WBAL, Controller) begin
    TRAIN ~ preserve(parameter, u"mm")
    TIRR ~ preserve(parameter, u"mm")
    TESa ~ preserve(parameter, u"mm")
    TEPa ~ preserve(parameter, u"mm")
    TROF ~ preserve(parameter, u"mm")
    TDRN ~ preserve(parameter, u"mm")
    SWC0 ~ preserve(parameter, u"mm")
    SWC ~ preserve(parameter, u"mm")
    
    time(context.clock.time) ~ track(u"d")
end

config = @config(
    :WBAL => (;
        TRAIN = 1u"mm",
        TIRR = 1u"mm",
        TESa = 1u"mm",
        TEPa = 1u"mm",
        TROF = 1u"mm",
        TDRN = 1u"mm",
        SWC0 = 1u"mm",
        SWC =  1u"mm",
    ),
)

@testset "WBAL" begin
    r = simulate(WBALController; config, stop = 5u"d")
end