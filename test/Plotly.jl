using Test: @test

using Nucleus

# ---- #

const C1 = "#ff0000"

const C2 = "#00ff00"

const C3 = "#0000ff"

# ---- #

for (co_, re) in (
    ((C1,), ((0, C1), (1, C1))),
    ((C1, C2), ((0.0, C1), (1.0, C2))),
    ((C1, C2, C3), ((0.0, C1), (0.5, C2), (1.0, C3))),
)

    @test Nucleus.Plotly.make_colorscale(co_) === re

end

# ---- #

const LA = Dict("paper_bgcolor" => C1, "plot_bgcolor" => C3, "title" => Dict("text" => "🤠"))

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
