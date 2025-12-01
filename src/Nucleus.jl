module Nucleus

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
    "Rename",
    "Significance",
    "Strin",
    "Table",
    "Tex",
    "Time",
    "TimelinePlot",
)

    include("$st.jl")

end

end
