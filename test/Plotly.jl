using Test: @test

using Nucleus

# ---- #

const LA = Dict(
    "paper_bgcolor" => "#ff0000",
    "plot_bgcolor" => "#00ff00",
    "title" => Dict("text" => "🤠"),
)

const HE = 800

for (tr_, la) in (
    ((), LA),
    ((), merge(LA, Dict("height" => HE, "width" => HE))),
    ((), merge(LA, Dict("height" => HE * 2, "width" => HE * 2))),
    (
        (
            Dict("y" => (-1, 2), "x" => (-1, 2), "marker" => Dict("size" => 64)),
            Dict("y" => (-1, 3), "x" => (0, 2), "marker" => Dict("size" => 80)),
        ),
        Dict(
            "title" => Dict("text" => "Title"),
            "yaxis" => Dict("range" => (-1, 3), "title" => Dict("text" => "Y-Axis Title")),
            "xaxis" => Dict(
                "range" => (-1, 2),
                "title" => Dict("text" => "X-Axis Title"),
                "tickvals" => (-1, 2),
                "ticktext" => (join('a':'z'), join('a':'z')),
                "tickangle" => 90,
            ),
        ),
    ),
)

    Nucleus.Plotly.writ("", tr_, la, Dict("editable" => true))

end
