module BubblePlot

using ..Nucleus

function writ(ht, yc_, xc_, S, C, la = Dict{String, Any}())

    id_ = vec(CartesianIndices(S))

    Nucleus.Plotly.writ(
        ht,
        (
            Dict(
                "y" => map(id -> yc_[id[1]], id_),
                "x" => map(id -> xc_[id[2]], id_),
                "mode" => "markers",
                "marker" => Dict(
                    "size" => vec(S),
                    "color" => vec(C),
                    "colorscale" => Nucleus.Plotly.make(Nucleus.ColorScheme.BR_),
                ),
            ),
        ),
        Nucleus.Dictionary.make(Dict("yaxis" => Dict("autorange" => "reversed")), la),
    )

end

end
