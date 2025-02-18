module ErrorMatrix

using ..Omics

function fil!(E, bo_, p1_, p2)

    for id in eachindex(bo_)

        E[bo_[id] ? 2 : 1, p1_[id] < p2 ? 1 : 2] += 1

    end

end

function summarize(E, su = sum(E))

    tn, fn, fp, tp = E

    s0 = inv(tn + fp)

    s1 = inv(fn + tp)

    pr = tp * s1

    pp = tp / (tp + fp)

    tn * s0,
    fn * s1,
    fp * s0,
    pr,
    tn / (tn + fn),
    pp,
    2.0 * pr * pp / (pr + pp),
    (tn + tp) / su

end

function make_axis(te)

    Dict("title" => Dict("text" => te), "tickfont" => Dict("size" => 40))

end

function make_annotation(yc, xc, te, nu)

    Dict(
        "y" => yc,
        "x" => xc,
        "text" => "$te $(Omics.Numbe.shorten(nu))",
        "font" => Dict("size" => 24),
        "showarrow" => false,
    )

end

function plot(ht, E, tn, fn, fp, tp, np, pp, f1, ac; la = Dict{String, Any}())

    yc_ = "❌", "✅"

    xc_ = "👎 ", "👍"

    Omics.Plot.plot_heat_map(
        ht,
        E;
        yc_,
        xc_,
        co = Omics.Coloring.fractionate(("#ffffff", Omics.Color.A2)),
        la = Omics.Dic.merge(
            Dict(
                "title" => Dict("text" => "Error Matrix"),
                "yaxis" => make_axis("Actual"),
                "xaxis" => make_axis("Predicted"),
                "annotations" => (
                    make_annotation(yc_[1], xc_[1], "$(E[1, 1])<br>TNR (specificity)", tn),
                    make_annotation(yc_[2], xc_[1], "$(E[2, 1])<br>FNR (type-2 error)", fn),
                    make_annotation(yc_[1], xc_[2], "$(E[1, 2])<br>FPR (type-1 error)", fp),
                    make_annotation(
                        yc_[2],
                        xc_[2],
                        "$(E[2, 2])<br>TPR (sensitivity or recall)",
                        tp,
                    ),
                    make_annotation(0.5, 0, "NPV", np),
                    make_annotation(0.5, 1, "PPV (precision)", pp),
                    make_annotation(0.75, 1, "F1", f1),
                    make_annotation(0.5, 0.5, "Accuracy", ac),
                ),
            ),
            la,
        ),
    )

end

end
