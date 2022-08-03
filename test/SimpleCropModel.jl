using Cropbox
using SimpleCropModel
using Test

using CSV
using DataFrames
using TimeZones

config = @config (
    :Clock => :step => 1u"d",
    :Calendar => :init => ZonedDateTime(1986, 1, 1, tz"UTC"),
    :Weather => :weather_data => CSV.File(joinpath(@__DIR__, "data", "weather.csv")) |> DataFrame,
    :SW => :irrigation_data => CSV.File(joinpath(@__DIR__, "data", "irrigation.csv")) |> DataFrame, 
)

@testset "SimpleCropModel" begin
    r = simulate(Model;
    config,
    stop = 729u"d",
    target = ["dLAI", "LAI", "TDRN", "TRAIN"],
)
end