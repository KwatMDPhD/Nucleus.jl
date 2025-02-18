module MatchPlot

using Distances: CorrDist, Euclidean

using StatsBase: mean

using ..Omics

function layout(u1, te, u2)

    Dict(
        "height" => max(832, u1 * 40),
        "width" => 1280,
        "margin" => Dict("r" => 232),
        "xaxis" => Dict("side" => "top", "title" => Dict("text" => "$te ($u2)")),
    )

end

function pus!(an_, an, yc, id, te)

    push!(
        an_,
        merge(
            an,
            Dict(
                "y" => yc,
                "x" => isone(id) ? 1.016 : 1.128,
                "xanchor" => "left",
                "text" => te,
            ),
        ),
    )

end

function strin(n1, n2)

    "$(Omics.Numbe.shorten(n1)) ($(Omics.Numbe.shorten(n2)))"

end

function annotate(y1, he, te, bo, R)

    an = Dict(
        "yref" => "paper",
        "xref" => "paper",
        "yanchor" => "middle",
        "showarrow" => false,
    )

    y2 = y1 + he * 0.392

    an_ =
        [merge(an, Dict("y" => y2, "x" => 0.5, "text" => te, "font" => Dict("size" => 16)))]

    if bo

        pus!(an_, an, y2, 1, "Score (⧱)")

        pus!(an_, an, y2, 2, "P Value (𝐪)")

    end

    y2 = y1 - he * 0.5

    for (re, ma, pv, qv) in eachrow(R)

        pus!(an_, an, y2, 1, strin(re, ma))

        pus!(an_, an, y2, 2, strin(pv, qv))

        y2 -= he

    end

    an_

end

function color(fl_::AbstractArray{<:AbstractFloat}, st::Real)

    Omics.Plot.CO, -st, st, (-st, mean(fl_), st)

end

function color(it_, ::Real)

    un_ = sort!(unique(it_))

    Omics.Coloring.fractionate(
        lastindex(un_) == 2 ? (Omics.Color.A1, Omics.Color.A2) : Omics.Coloring.I2_,
    ),
    un_[1],
    un_[end],
    eachindex(un_)

end

const CO = Dict(
    "x" => 0.5,
    "orientation" => "h",
    "len" => 0.56,
    "thickness" => 16,
    "outlinewidth" => 0,
)

function trace(nu_, st, yc, te, xc_, he)

    co_ = copy(nu_)

    Omics.Normalization.do_0_clamp!(co_, st)

    ol, mi, ma, ti_ = color(co_, st)

    om = 1.0 - he

    [
        Dict(
            "type" => "heatmap",
            "y" => (yc,),
            "x" => xc_,
            "z" => (co_,),
            "text" => (nu_,),
            "zmin" => mi,
            "zmax" => ma,
            "colorscale" => ol,
            "colorbar" => merge(CO, Dict("y" => -0.32, "tickvals" => ti_)),
        ),
    ],
    Dict("domain" => (om, 1), "tickfont" => Dict("size" => 16)),
    om

end

function trace(N, st, te, yc_, xc_, R, id, o1, he)

    C = copy(N)

    foreach(nu_ -> Omics.Normalization.do_0_clamp!(nu_, st), eachrow(C))

    ol, mi, ma, ti_ = color(C, st)

    bo = id == 2

    o2 = o1 - he

    o1 = o2 - he * lastindex(yc_)

    Dict(
        "yaxis" => "y$id",
        "type" => "heatmap",
        "y" => map(yc -> Omics.Strin.limit(yc, 40), yc_),
        "x" => xc_,
        "z" => collect(eachrow(C)),
        "text" => collect(eachrow(N)),
        "zmin" => mi,
        "zmax" => ma,
        "colorscale" => ol,
        bo ? "colorbar" => merge(CO, Dict("y" => -0.456, "tickvals" => ti_)) :
        "showscale" => false,
    ),
    Dict("domain" => (o1, o2), "autorange" => "reversed"),
    annotate(o2, he, te, bo, R),
    o1

end

function order(fl_::AbstractVector{<:AbstractFloat}, ::AbstractMatrix)

    sortperm(fl_)

end

function order(it_, N)

    Omics.Clustering.order(isone(size(N, 1)) ? Euclidean() : CorrDist(), it_, eachcol(N))

end

function writ(
    pr,
    xa,
    xc_,
    y1,
    nu_,
    y2,
    yc_,
    N,
    R;
    u1 = 8,
    st = 3.0,
    la = Dict{String, Any}(),
)

    Omics.Table.writ(
        "$pr.tsv",
        Omics.Table.make(
            y2,
            yc_,
            ["Score", "95% Margin of Error", "P-Value", "Q-Value"],
            R,
        ),
    )

    re_ = R[:, 1]

    i1_ = findall(!isnan, re_)

    i1_ = i1_[reverse!(Omics.Extreme.ge(re_[i1_], u1))]

    yc_ = yc_[i1_]

    N = N[i1_, :]

    R = R[i1_, :]

    i2_ = order(nu_, N)

    xc_ = xc_[i2_]

    u2 = 2 + lastindex(yc_)

    he = inv(u2)

    la = layout(u2, xa, lastindex(xc_))

    tr_, la["yaxis"], om = trace(nu_[i2_], st, y1, xa, xc_, he)

    tr, la["yaxis2"], la["annotations"], _ =
        trace(N[:, i2_], st, y2, yc_, xc_, R, 2, om, he)

    push!(tr_, tr)

    Omics.Plot.plot("$pr.html", tr_, la)

end

function writ(ht, xa, xc_, y1, nu_, b1_, b2_; st = 3.0, la = Dict{String, Any}())

    i1_ = sortperm(nu_)

    xc_ = xc_[i1_]

    um = 1 + sum(bu -> 1 + lastindex(bu[2]), b2_)

    he = inv(um)

    la = layout(um, xa, lastindex(xc_))

    la["annotations"] = Dict{String, Any}[]

    tr_, la["yaxis"], om = trace(nu_[i1_], st, y1, xa, xc_, he)

    for i2 in eachindex(b2_)

        y2, yc_ = b2_[i2]

        bu = b1_[findall(bu -> bu[1] == (y2), b1_)[]]

        i3_ = indexin(yc_, bu[2])

        i4 = 1 + i2

        tr, la["yaxis$i4"], an_, om =
            trace(bu[3][i3_, i1_], st, y2, yc_, xc_, bu[4][i3_, :], i4, om, he)

        push!(tr_, tr)

        append!(la["annotations"], an_)

    end

    Omics.Plot.plot(ht, tr_, la)

end

end
