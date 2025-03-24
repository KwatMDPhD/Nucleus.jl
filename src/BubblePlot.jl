module BubblePlot

using ..Nucleus

function writ(ht, yc_, xc_, S, C, la = Dict{String, Any}())

    in__ = vec(CartesianIndices(S))

    Nucleus.Plotly.writ(
        ht,
        (
            Dict(
                "y" => map(in_ -> yc_[in_[1]], in__),
                "x" => map(in_ -> xc_[in_[2]], in__),
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
