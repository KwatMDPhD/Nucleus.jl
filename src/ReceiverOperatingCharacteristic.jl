module ReceiverOperatingCharacteristic

using ..Omics

function get_area(xc_, yc_)

    ar = 0

    for id in 2:lastindex(xc_)

        ar += (xc_[id] - xc_[id - 1]) * (yc_[id] + yc_[id - 1]) * 0.5

    end

    ar

end

function line(bo_, p1_, p2_ = Omics.Grid.make(p1_, 10); pr = "")

    fp_ = Vector{Float64}(undef, lastindex(p2_))

    tp_ = similar(fp_)

    E = Matrix{Int}(undef, 2, 2)

    for id in eachindex(p2_)

        fill!(E, 0)

        p2 = p2_[id]

        Omics.ErrorMatrix.fil!(E, bo_, p1_, p2)

        tn, fn, fp, tp, np, pp, f1, ac = Omics.ErrorMatrix.summarize(E, lastindex(bo_))

        fp_[id] = fp

        tp_[id] = tp

        if !isempty(pr)

            te = Omics.Numbe.shorten(p2)

            Omics.ErrorMatrix.plot(
                "$pr.$te.html",
                E,
                tn,
                fn,
                fp,
                tp,
                np,
                pp,
                f1,
                ac;
                la = Dict("title" => Dict("text" => "◑ $te")),
            )

        end

    end

    fp_, tp_

end

function plot(ht, pr_, fp_, tp_)

    id_ = sortperm(collect(zip(fp_, tp_)))

    pr_ = pr_[id_]

    fp_ = fp_[id_]

    tp_ = tp_[id_]

    si = 8

    co = Omics.Color.A2

    ra = -0.016, 1.016

    Omics.Plot.plot(
        ht,
        (
            Dict(
                "name" => "Random",
                "y" => (0, 1),
                "x" => (0, 1),
                "mode" => "lines",
                "line" => Dict("color" => "#000000"),
            ),
            Dict(
                "name" => "Area = $(Omics.Numbe.shorten(get_area(fp_, tp_)))",
                "y" => tp_,
                "x" => fp_,
                "text" => pr_,
                "marker" => Dict("size" => si, "color" => co),
                "line" => Dict("width" => si * 0.32, "color" => co),
                "fill" => "tozeroy",
            ),
        ),
        Dict(
            "title" => Dict("text" => "Receiver Operating Characteristic"),
            "yaxis" => Dict("range" => ra, "title" => Dict("text" => "True-Positive Rate")),
            "xaxis" =>
                Dict("range" => ra, "title" => Dict("text" => "False-Positive Rate")),
            "legend" =>
                Dict("y" => 0.08, "x" => 0.96, "yanchor" => "bottom", "xanchor" => "right"),
        ),
    )

end

end
