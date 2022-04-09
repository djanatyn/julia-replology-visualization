module RepologyVisualization

using JSON
using Logging

packages()::Dict{String, Any} = JSON.parse(open("packages.json"))

base_api_url = "https://repology.org/api/v1"

api_url()::String = "$(base_api_url)/projects/?repos=5-&newest=True"
api_url(start::String)::String = "$(base_api_url)/projects/$(start)?repos=5-&newest=True"

end # module
