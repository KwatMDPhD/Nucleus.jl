module GeneralizedLinearModel

using GLM: @formula, glm, predict

using ..Omics

function fit(xc_, di, yc_)

    glm((@formula Y ~ X), (X = xc_, Y = yc_), di)

end

function predic(gl, xc_)

    predict(gl, (X = xc_,); interval = :confidence)

end

function predic(gl, xc::Real)

    e1_, e2_, e3_ = predic(gl, [xc])

    e1_[], e2_[], e3_[]

end

function plot(ht, xc_, yc_, gr_, e1_, e2_, e3_; si = 4, la = Dict{String, Any}())

    c1 = Omics.Color.VI

    c2 = Omics.Color.TU

    tr = Dict("x" => gr_, "mode" => "lines", "line" => Dict("width" => 0))

    Omics.Plot.plot(
        ht,
        (
            Dict(
                "name" => 'Y',
                "y" => yc_,
                "x" => xc_,
                "mode" => "markers",
                "marker" => Dict("size" => si, "color" => c1),
            ),
            merge(tr, Dict("showlegend" => false, "y" => e2_)),
            merge(
                tr,
                Dict(
                    "showlegend" => false,
                    "y" => e3_,
                    "fill" => "tonexty",
                    "fillcolor" => Omics.Color.hexify(c2, 0.16),
                ),
            ),
            merge(
                tr,
                Dict(
                    "name" => "Prediction",
                    "y" => e1_,
                    "line" => Dict("width" => si * 0.64, "color" => c2),
                ),
            ),
        ),
        Omics.Dic.merg(
            Dict(
                "yaxis" => Dict("title" => Dict("text" => 'Y')),
                "xaxis" => Dict("title" => Dict("text" => 'X')),
            ),
            la,
        ),
    )

end

end
