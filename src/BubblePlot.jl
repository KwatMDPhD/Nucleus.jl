module BubblePlot

using ..Nucleus

function writ(ht, yc_, xc_, S, C, la = Dict{String, Any}())

    id__ = vec(CartesianIndices(S))

    Nucleus.Plotly.writ(
        ht,
        (
            Dict(
                "y" => map(id_ -> yc_[id_[1]], id__),
                "x" => map(id_ -> xc_[id_[2]], id__),
                "mode" => "markers",
                "marker" => Dict(
                    "size" => vec(S),
                    "color" => vec(C),
                    "colorscale" =>
                        Nucleus.Plotly.make_colorscale(Nucleus.ColorScheme.BR_),
                ),
            ),
        ),
        Nucleus.Dictionary.make(Dict("yaxis" => Dict("autorange" => "reversed")), la),
    )

end

end
