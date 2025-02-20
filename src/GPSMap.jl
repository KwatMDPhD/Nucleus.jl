module GPSMap

using KernelDensity: default_bandwidth, kde

using ..Omics

function get_density(nu__; di...)

    kd = kde(nu__; di...)

    kd.x, kd.y, kd.density

end

function color(co, nu_)

    map(
        fr -> Omics.Color.hexify(co[fr]),
        Omics.RangeNormalization.do_01!(convert(Vector{Float64}, nu_)),
    )

end

function plot(ht, t1_, C1, t2_, C2; um = 64, po = 1, si = 16, op = 0.8, nu_ = nothing)

    h1 = 832

    ma = h1 * 0.04

    tr_ = [
        Dict(
            "showlegend" => false,
            "y" => (0,),
            "x" => (0,),
            "mode" => "markers",
            "marker" => Dict(
                "size" => h1 - ma * 2.0,
                "color" => Omics.Color.hexify("#ffffff", 0),
                "line" => Dict("width" => 4, "color" => "#000000"),
            ),
            "hoverinfo" => "skip",
        ),
    ]

    push!(
        tr_,
        Dict(
            "name" => "Node",
            "y" => C1[2, :],
            "x" => C1[1, :],
            "text" => t1_,
            "mode" => "markers+text",
            "marker" => Dict("size" => 56, "color" => "#000000"),
            "textfont" => Dict("size" => 24, "color" => "#ffffff"),
            "cliponaxis" => false,
            "hoverinfo" => "text",
        ),
    )

    xc_, yc_ = eachrow(C2)

    ke_ = (
        boundary = ((-2, 2), (-2, 2)),
        npoints = (um, um),
        bandwidth = (default_bandwidth(xc_) * po, default_bandwidth(yc_) * po),
    )

    g1_, g2_, D = get_density((xc_, yc_); ke_...)

    B = [1.0 < xc^2 + yc^2 for xc in g1_, yc in g2_]

    D[B] .= NaN

    push!(
        tr_,
        Dict(
            "showlegend" => false,
            "type" => "contour",
            "y" => g2_,
            "x" => g1_,
            "z" => D,
            "ncontours" => 56,
            "contours" => Dict("coloring" => "none"),
            "hoverinfo" => "skip",
        ),
    )

    tr = Dict(
        "name" => "Point",
        "y" => yc_,
        "x" => xc_,
        "text" => t2_,
        "mode" => "markers",
        "marker" => Dict(
            "size" => si,
            "opacity" => op,
            "color" => Omics.Color.IN,
            "line" => Dict("width" => 1, "color" => "#000000"),
        ),
    )

    if isnothing(nu_)

        push!(tr_, tr)

    elseif nu_ isa AbstractVector{<:AbstractFloat}

        push!(
            tr_,
            Omics.Dic.merg(
                tr,
                Dict(
                    "marker" => Dict(
                        "color" => color(
                            Omics.Coloring.make(["#0000ff", "#ffffff", "#ff0000"]),
                            nu_,
                        ),
                    ),
                ),
            ),
        )

    else

        un_ = unique(nu_)

        D_ = Vector{Matrix{Float64}}(undef, lastindex(un_))

        for i1 in eachindex(un_)

            i2_ = findall(==(un_[i1]), nu_)

            _, _, D = get_density((xc_[i2_], yc_[i2_]); ke_...)

            D[B] .= NaN

            D_[i1] = D

        end

        for i2 in 1:um, i1 in 1:um

            de_ = map(D -> D[i1, i2], D_)

            if all(isnan, de_)

                continue

            end

            i3 = argmax(de_)

            for i4 in eachindex(un_)

                if i4 != i3

                    D_[i4][i1, i2] = NaN

                end

            end

        end

        co_ = color(Omics.Coloring.make(collect(Omics.Coloring.I2_)), un_)

        for i1 in eachindex(un_)

            push!(
                tr_,
                Dict(
                    "legendgroup" => un_[i1],
                    "name" => un_[i1],
                    "type" => "heatmap",
                    "y" => g2_,
                    "x" => g1_,
                    "z" => D_[i1],
                    "colorscale" => Omics.Coloring.fractionate(("#ffffff", co_[i1])),
                    "showscale" => false,
                    "hoverinfo" => "skip",
                ),
            )

            i2_ = findall(==(un_[i1]), nu_)

            push!(
                tr_,
                Omics.Dic.merg(
                    tr,
                    Dict(
                        "legendgroup" => un_[i1],
                        "name" => un_[i1],
                        "y" => yc_[i2_],
                        "x" => xc_[i2_],
                        "text" => t2_[i2_],
                        "marker" => Dict("color" => co_[i1]),
                        "hoverinfo" => "name+text",
                    ),
                ),
            )

        end

    end

    ax = Dict("range" => (-1, 1), "showticklabels" => false, "ticks" => "")

    h2 = h1 * 0.48

    Omics.Plot.plot(
        ht,
        tr_,
        Dict(
            "height" => h1,
            "width" => h1 + h2,
            "margin" => Dict(
                "autoexpand" => false,
                "t" => ma,
                "b" => ma,
                "l" => ma,
                "r" => ma + h2,
            ),
            "yaxis" => ax,
            "xaxis" => ax,
            "legend" => Dict("xanchor" => "right", "x" => 1.56),
        ),
    )

end

end
