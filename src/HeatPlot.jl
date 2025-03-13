module HeatPlot

using StatsBase: mean

using ..Nucleus

function make(yc_, xc_, N; co = Nucleus.Plotly.make_colorscale(Nucleus.ColorScheme.BR_))

    nu_ = filter(!isnan, N)

    Dict(
        "type" => "heatmap",
        "y" => yc_,
        "x" => xc_,
        "z" => collect(eachrow(N)),
        "colorscale" => co,
        "colorbar" => Dict("tickvals" => (extrema(nu_)..., mean(nu_))),
    )

end

function writ(ht, yc_, xc_, N, la = Dict{String, Any}(); ke_...)

    Nucleus.Plotly.writ(
        ht,
        (make(yc_, xc_, N; ke_...),),
        Nucleus.Dictionary.make(Dict("yaxis" => Dict("autorange" => "reversed")), la),
    )

end

end
