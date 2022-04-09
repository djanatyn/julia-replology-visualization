module RepologyVisualization

using JSON
using Logging
using Test

struct PackageList
    page::Dict{String, Any}
end

packages()::PackageList = PackageList(JSON.parse(open("packages.json")))

base_api_url = "https://repology.org/api/v1"

api_url()::String =
    "$(base_api_url)/projects/?repos=5-&newest=True"

api_url(start::String)::String =
    "$(base_api_url)/projects/$(start)?repos=5-&newest=True"

download_page()::PackageList =
    PackageList(JSON.parse(read(`curl $(api_url())`, String)))
download_page(start::String)::Dict{String, Any} =
    PackageList(JSON.parse(read(`curl $(api_url(start))`, String)))

@testset "generate urls" begin
    @test api_url() == "https://repology.org/api/v1/projects/?repos=5-&newest=True"
    @test api_url("package") == "https://repology.org/api/v1/projects/package?repos=5-&newest=True"
end

end # module
