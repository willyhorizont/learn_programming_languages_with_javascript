using Printf
using Statistics
using JSON

country_capitals_in_asia = Dict(
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
)

country_capitals_in_asia_new = Dict(country_capitals_in_asia..., "Japan" => "Hiroshima")
println("country_capitals_in_asia_new: ", JSON.json(country_capitals_in_asia_new, 4))
