module HeatPlot

using StatsBase: mean

using ..Nucleus

function make(yc_, xc_, N; co = Nucleus.Plotly.make_colorscale(Nucleus.ColorScheme.BR_))

    nu_ = filter(!isnan, N)

    mi, ma = extrema(nu_)

    Dict(
        "type" => "heatmap",
        "y" => yc_,
        "x" => xc_,
        "z" => collect(eachrow(N)),
        "colorscale" => co,
        "colorbar" => Dict("tickvals" => (mi, mean(nu_), ma)),
    )

end

function make(an_)

    "title" => Dict("text" => lastindex(an_))

end

function writ(ht, yc_, xc_, N, la = Dict{String, Any}(); ke_...)

    Nucleus.Plotly.writ(
        ht,
        (make(yc_, xc_, N; ke_...),),
        Nucleus.Dictionary.make(
            Dict(
                "yaxis" => Dict("autorange" => "reversed", make(yc_)),
                "xaxis" => Dict(make(xc_)),
            ),
            la,
        ),
    )

end

end
