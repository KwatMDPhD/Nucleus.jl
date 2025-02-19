module GeneralizedLinearModel

using GLM: @formula, Binomial, glm, predict

using ..Omics

function fit(n1_, n2_)

    glm((@formula n1 ~ n2), (n1 = n1_, n2 = n2_), Binomial())

end

function predic(gl, n2_)

    predict(gl, (n2 = n2_,); interval = :confidence)

end

function predic(gl, n2::Real)

    p1_, p2_, p3_ = predic(gl, [n2])

    p1_[], p2_[], p3_[]

end

function rang(mi, ma, fr)

    fr *= (ma - mi)

    mi - fr, ma + fr

end

function plot(
    ht,
    xa,
    xc_,
    y1,
    n1_,
    y2,
    n2_,
    p1_,
    p2_,
    p3_;
    si = 4,
    wi = 4,
    la = Dict{String, Any}(),
)

    c1 = Omics.Color.VI

    c2 = Omics.Color.TU

    tr = Dict("yaxis" => "y3", "x" => xc_, "mode" => "lines", "line" => Dict("width" => 0))

    om = 0.96

    fr = 0.032

    Omics.Plot.plot(
        ht,
        (
            Dict(
                "type" => "heatmap",
                "y" => (y1,),
                "x" => xc_,
                "z" => (n1_,),
                "colorscale" =>
                    Omics.Coloring.fractionate((Omics.Color.LI, Omics.Color.DA)),
                "showscale" => false,
            ),
            Dict(
                "yaxis" => "y2",
                "y" => n2_,
                "x" => xc_,
                "mode" => "markers",
                "marker" => Dict("size" => si, "color" => c1),
            ),
            Dict(
                "yaxis" => "y3",
                "y" => (0.5, 0.5),
                "x" => (xc_[1], xc_[end]),
                "mode" => "lines",
                "line" => Dict("width" => wi * 0.5, "color" => "#000000"),
            ),
            merge(tr, Dict("y" => p2_)),
            merge(
                tr,
                Dict(
                    "y" => p3_,
                    "fill" => "tonexty",
                    "fillcolor" => Omics.Color.hexify(c2, 0.16),
                ),
            ),
            merge(tr, Dict("y" => p1_, "line" => Dict("width" => wi, "color" => c2))),
        ),
        Omics.Dic.merg(
            Dict(
                "showlegend" => false,
                "yaxis" => Dict("domain" => (om, 1), "ticks" => ""),
                "yaxis2" => Dict(
                    "domain" => (0, om),
                    "position" => 0,
                    "title" => Dict("text" => y2, "font" => Dict("color" => c1)),
                    "range" => rang(extrema(n2_)..., fr),
                    "tickvals" => map(Omics.Numbe.shorten, Omics.Plot.tick(n2_)),
                ),
                "yaxis3" => Dict(
                    "overlaying" => "y2",
                    "position" => 0.112,
                    "title" => Dict(
                        "text" => "Probability of $y1",
                        "font" => Dict("color" => c2),
                    ),
                    "range" => rang(0, 1, fr),
                    "tickvals" =>
                        (0, map(Omics.Numbe.shorten, Omics.Plot.tick(p1_))..., 1),
                ),
                "xaxis" => Dict(
                    "anchor" => "y2",
                    "domain" => (0.08, 1),
                    "title" => Dict("text" => "$xa ($(lastindex(n1_)))"),
                    "ticks" => "",
                ),
            ),
            la,
        ),
    )

end

end
