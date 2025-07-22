module BoxPlot

using StatsBase: mean

using ..Nucleus

function writ(ht, s1_, N, na, nu_, s2_, he_, la = Dict{String, Any}())

    in_ = sortperm(map(mean, eachrow(N)))

    s1_ = s1_[in_]

    N = N[in_, :]

    nu_ = nu_[in_]

    tr_ = Dict{String, Any}[]

    un_ = unique(s2_)

    for id in eachindex(un_)

        un = un_[id]

        in_ = findall(==(un), s2_)

        push!(
            tr_,
            Dict(
                "name" => un,
                "type" => "box",
                "boxpoints" => "all",
                "pointpos" => 0,
                "jitter" => 1,
                "y" => vec(N[:, in_]),
                "x" => repeat(s1_, lastindex(in_)),
                "marker" => Dict("color" => he_[id]),
            ),
        )

    end

    push!(
        tr_,
        Dict(
            "name" => na,
            "y" => map(nu_ -> maximum(nu_) + 0.024, eachrow(N)),
            "x" => s1_,
            "mode" => "text",
            "text" => map(Nucleus.Numbe.text_2, nu_),
            "textfont" => Dict("size" => 16),
        ),
    )

    Nucleus.Plotly.writ(ht, tr_, Nucleus.Dictionary.make(Dict("boxmode" => "group"), la))

end

end
