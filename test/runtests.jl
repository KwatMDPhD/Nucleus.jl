using Test: @test

using Nucleus

# ----------------------------------------------------------------------------------------------- #

for st in (
    "Animation",
    "BubblePlot",
    "Collection",
    "Color",
    "ColorScheme",
    "Confidence",
    "Dictionary",
    "Extreme",
    "HTM",
    "HeatPlot",
    "Information",
    "Normalization",
    "Numbe",
    "PairMap",
    "PairMetric",
    "Path",
    "Plotly",
    "RangeNormalization",
    "RankNormalization",
    "Rename",
    "Significance",
    "Strin",
    "Table",
    "Tex",
    "Time",
)

    @info "🎬 Testing $st"

    run(`julia --project $st.jl`)

end
