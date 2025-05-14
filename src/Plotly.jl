module Plotly

using JSON: json

using ..Nucleus

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

    Nucleus.HTM.writ(
        ht,
        ("https://cdn.plot.ly/plotly-3.0.1.min.js",),
        """
        Plotly.newPlot("nu", $(json(tr_)), $(json(la)), $(json(co)))""",
    )

end

end
