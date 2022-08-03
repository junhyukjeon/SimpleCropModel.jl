module SimpleCropModel

using Cropbox

include("plant/plant.jl")
include("soilwater/soilwater.jl")
include("weather/weather.jl")

@system Model(Plant, SW, Weather, Controller) 

export Model

end
