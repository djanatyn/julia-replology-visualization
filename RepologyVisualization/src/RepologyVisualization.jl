module RepologyVisualization

using JSON
using Test
using DataFrames

packages() = PackageList(JSON.parse(open("packages.json")))

base_api_url = "https://repology.org/api/v1"

api_url()::String =
    "$(base_api_url)/projects/?repos=5-&newest=True"
api_url(start::String)::String =
    "$(base_api_url)/projects/$(start)?repos=5-&newest=True"

download_page() =
    JSON.parse(read(`curl $(api_url())`, String))
download_page(start::String) =
    JSON.parse(read(`curl $(api_url(start))`, String))

next_page(packages) =
   sort(collect(keys(packages)))[end]

last_page(start, packages) =
    next_page(packages) == start

find_licenses(page) = unique(reduce(vcat, [
    [Dict(:package => package, :license => definition["licenses"])
     for definition in repos if haskey(definition, "licenses")]
    for (package, repos) in page]))

@testset "generate urls" begin
    @test api_url() == "https://repology.org/api/v1/projects/?repos=5-&newest=True"
    @test api_url("package") == "https://repology.org/api/v1/projects/package?repos=5-&newest=True"
end

end # module

