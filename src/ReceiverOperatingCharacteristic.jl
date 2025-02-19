module ReceiverOperatingCharacteristic

using Printf: @sprintf

using ..Omics

function line!(bo_, p1_, p2_ = Omics.Grid.make(p1_, 10); E_ = nothing)

    fp_ = Vector{Float64}(undef, lastindex(p2_))

    tp_ = similar(fp_)

    E = Matrix{Int}(undef, 2, 2)

    for id in eachindex(p2_)

        fill!(E, 0)

        p2 = p2_[id]

        Omics.ErrorMatrix.fil!(E, bo_, p1_, p2)

        _, _, fp_[id], tp_[id], _, _, _, _ = Omics.ErrorMatrix.summarize(E, lastindex(bo_))

        if !isnothing(E_)

            E_[id] = copy(E)

        end

    end

    fp_, tp_

end

function plot(ht, pr_, fp_, tp_; si = 8)

    ra = -0.008, 1.008

    Omics.Plot.plot(
        ht,
        (
            Dict("y" => (0, 1), "x" => (0, 1), "line" => Dict("color" => Omics.Color.LI)),
            Dict(
                "y" => tp_,
                "x" => fp_,
                "text" => pr_,
                "mode" => "markers+lines+text",
                "cliponaxis" => false,
                "marker" => Dict("size" => si, "color" => Omics.Color.A2),
                "line" => Dict("width" => si * 0.32),
                "fill" => "tozeroy",
                "textposition" => "top",
            ),
        ),
        Dict(
            "showlegend" => false,
            "title" => Dict(
                "text" => "Area = $(@sprintf "%.4g" -Omics.Geometry.get_area(fp_, tp_))",
            ),
            "yaxis" => Dict("range" => ra, "title" => Dict("text" => "True Positive Rate")),
            "xaxis" =>
                Dict("range" => ra, "title" => Dict("text" => "False Positive Rate")),
        ),
    )

end

end
