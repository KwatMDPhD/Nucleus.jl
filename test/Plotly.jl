using Random: randstring

using Test: @test

using Nucleus

# ---- #
# TODO

Nucleus.Plotly.make_title

# ---- #

const H1 = "#ff0000"

const H2 = "#00ff00"

const H3 = "#0000ff"

for (st_, re) in (
    ((H1,), ((0, H1), (1, H1))),
    ((H1, H2), ((0.0, H1), (1.0, H2))),
    ((H1, H2, H3), ((0.0, H1), (0.5, H2), (1.0, H3))),
)

    @test Nucleus.Plotly.make_colorscale(st_) === re

end

# ---- #

const LA = Dict(
    "paper_bgcolor" => "#ffff00",
    "plot_bgcolor" => "#00ffff",
    "title" => Dict("text" => "🤠"),
)

const E1 = 800

const E2 = 1000

const AN_ = randstring(8), randstring(32)

const TI = "title" => Dict("text" => "Title")

for (tr_, la) in (
    ((), LA),
    ((), merge(LA, Dict("height" => E1, "width" => E1))),
    ((), merge(LA, Dict("height" => E2, "width" => E2))),
    (
        (Dict("y" => AN_, "x" => AN_, "marker" => Dict("size" => 80)),),
        Dict(
            "height" => E2,
            "width" => E2,
            TI,
            "yaxis" => Dict(TI),
            "xaxis" => Dict(TI, "tickangle" => 90),
        ),
    ),
)

    Nucleus.Plotly.writ("", tr_, la, Dict("editable" => true))

end
