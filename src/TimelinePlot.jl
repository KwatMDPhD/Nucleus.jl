module TimelinePlot

using ..Nucleus

function writ(ht, pa_, la = Dict{String, Any}(); c1 = "#000000", c2 = "#ffffff")

    wi = 2.8

    yc = 0

    fo = Dict("size" => 32, "color" => c1)

    Nucleus.Plotly.writ(
        ht,
        (),
        Nucleus.Dictionary.make(
            Dict(
                "yaxis" => Dict("range" => (yc, yc + 1), "tickvals" => ()),
                "xaxis" => Dict(
                    "range" => extrema(pa[1] for pa in pa_),
                    "linewidth" => wi,
                    "linecolor" => c1,
                    "tickfont" => fo,
                ),
                "annotations" => map(
                    pa -> Dict(
                        "y" => yc,
                        "x" => pa[1],
                        "text" => pa[2],
                        "font" => fo,
                        "borderpad" => wi * 2.8,
                        "bgcolor" => c2,
                        "borderwidth" => wi,
                        "bordercolor" => c1,
                        "arrowside" => "none",
                        "arrowwidth" => wi * 0.64,
                        "arrowcolor" => c1,
                    ),
                    pa_,
                ),
            ),
            la,
        ),
        Dict("editable" => true),
    )

end

end
