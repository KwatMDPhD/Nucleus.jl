module HeatPlot

using StatsBase: mean

using ..Nucleus

function make(yc_, xc_, N)

    nu_ = filter(!isnan, N)

    Dict(
        "type" => "heatmap",
        "y" => yc_,
        "x" => xc_,
        "z" => collect(eachrow(N)),
        "colorscale" => Nucleus.Plotly.make_colorscale(Nucleus.ColorScheme.BR_),
        "colorbar" => Dict("tickvals" => (extrema(nu_)..., mean(nu_))),
    )

end

function writ(ht, yc_, xc_, N, la = Dict{String, Any}())

    Nucleus.Plotly.writ(
        ht,
        (make(yc_, xc_, N),),
        Nucleus.Dictionary.make(Dict("yaxis" => Dict("autorange" => "reversed")), la),
    )

end

end
