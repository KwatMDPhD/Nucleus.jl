module Plotly

using JSON: json

using ..Nucleus

function writ(ht, tr_, l1 = Dict{String, Any}(), co = Dict{String, Any}())

    ax = Dict(
        "automargin" => true,
        "title" => Dict("font" => Dict("size" => 24)),
        "zeroline" => false,
        "showgrid" => false,
    )

    l2 = merge(
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
        l1,
    )

    id = "pl"

    Nucleus.HTM.writ(
        ht,
        ("https://cdn.plot.ly/plotly-3.0.1.min.js",),
        id,
        """
        Plotly.newPlot("$id", $(json(tr_)), $(json(l2)), $(json(co)))""",
    )

end

function make(co_)

    um = lastindex(co_)

    if isone(um)

        co = co_[1]

        ((0.0, co), (1.0, co))

    else

        Tuple(zip(range(0, 1, um), co_))

    end

end

end
