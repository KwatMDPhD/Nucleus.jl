module ReceiverOperatingCharacteristic

using ..Omics

function line(la_, p1_, p2_ = Omics.Grid.make(p1_, 10); pl = true)

    um = lastindex(p2_)

    fp_ = Vector{Float64}(undef, um)

    tp_ = Vector{Float64}(undef, um)

    E = Matrix{Int}(undef, 2, 2)

    su = lastindex(la_)

    for id in 1:um

        p2 = p2_[id]

        fill!(E, 0)

        Omics.ErrorMatrix.fil!(E, la_, p1_, p2)

        tn, fn, fp, tp, np, pp, f1, ac = Omics.ErrorMatrix.summarize(E, su)

        if pl

            Omics.ErrorMatrix.plot(
                "",
                E,
                tn,
                fn,
                fp,
                tp,
                np,
                pp,
                f1,
                ac;
                la = Dict("title" => Dict("text" => "◑ $(Omics.Numbe.shorten(p2))")),
            )

        end

        fp_[id] = fp

        tp_[id] = tp

    end

    fp_, tp_

end

function plot(ht, fp_, tp_)

    io_ = sortperm(fp_)

    wi = 2

    co = Omics.Color.VI

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
                "name" => "Area = $(Omics.Numbe.shorten(sum(tp_) / lastindex(tp_)))",
                "y" => vcat(0.0, tp_[io_]),
                "x" => vcat(0.0, fp_[io_]),
                "mode" => "markers+lines",
                "marker" => Dict("size" => wi * 2.8, "color" => co),
                "line" => Dict("width" => wi, "color" => co),
                "fill" => "tozeroy",
                "fillcolor" => Omics.Color.hexify(co, 0.56),
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
