using Random: randstring

using Test: @test

using Nucleus

# ---- #

const RE = "#ff0000"

const GR = "#00ff00"

const BL = "#0000ff"

for (st_, re) in (
    ((RE,), ((0, RE), (1, RE))),
    ((RE, GR), ((0.0, RE), (1.0, GR))),
    ((RE, GR, BL), ((0.0, RE), (0.5, GR), (1.0, BL))),
)

    @test Nucleus.Plotly.make_colorscale(st_) === re

end

# ---- #

const LA = Dict(
    "paper_bgcolor" => "#ffff00",
    "plot_bgcolor" => "#00ffff",
    "title" => Dict("text" => "🤠"),
)

const H1 = 800

const H2 = 1000

const RA = -1, 1

const AX = Dict(
    "title" => Dict("text" => "Title"),
    "range" => RA,
    "tickvals" => RA,
    "ticktext" => (randstring(20), randstring(40)),
)

for (tr_, la) in (
    ((), LA),
    ((), merge(LA, Dict("height" => H1, "width" => H1))),
    ((), merge(LA, Dict("height" => H2, "width" => H2))),
    (
        (Dict("y" => RA, "x" => RA, "marker" => Dict("size" => 80)),),
        Dict(
            "height" => H2,
            "width" => H2,
            "title" => Dict("text" => "Title"),
            "yaxis" => merge(AX),
            "xaxis" => merge(AX, Dict("tickangle" => 90)),
        ),
    ),
)

    Nucleus.Plotly.writ("", tr_, la, Dict("editable" => true))

end
