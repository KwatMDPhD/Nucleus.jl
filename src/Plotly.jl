module Plotly

using JSON: json

using ..Nucleus

function make_title(t1, t2 = "")

    "title" => Dict("text" => t1, "subtitle" => Dict("text" => t2))

end

function make_colorscale(st_)

    um = lastindex(st_)

    if isone(um)

        st = st_[1]

        (0, st), (1, st)

    else

        Tuple(zip(range(0, 1, um), st_))

    end

end

function writ(ht, tr_, la = Dict{String, Any}(), co = Dict{String, Any}())

    ax = Dict(
        "automargin" => true,
        "title" => Dict("font" => Dict("size" => 24)),
        "zeroline" => false,
        "showgrid" => false,
    )

    la = merge(
        Dict(
            "template" => Dict(
                "data" => Dict(
                    "scatter" => [Dict("cliponaxis" => false)],
                    "heatmap" => [
                        Dict(
                            "colorbar" => Dict(
                                "len" => 0.56,
                                "thickness" => 16,
                                "outlinewidth" => 0,
                            ),
                        ),
                    ],
                ),
                "layout" => Dict(
                    "title" => Dict("font" => Dict("size" => 32)),
                    "yaxis" => ax,
                    "xaxis" => ax,
                ),
            ),
        ),
        la,
    )

    j1 = json(tr_)

    j2 = json(la)

    j3 = json(co)

    Nucleus.HTM.writ(
        ht,
        ("https://cdn.plot.ly/plotly-3.0.1.min.js",),
        """
        Plotly.newPlot("nu", $j1, $j2, $j3)""",
    )

end

end
