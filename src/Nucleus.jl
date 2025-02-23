module Nucleus

# ----------------------------------------------------------------------------------------------- #

for na in (
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

    include("$na.jl")

end

end
