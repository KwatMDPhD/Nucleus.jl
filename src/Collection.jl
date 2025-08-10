module Collection

function is_in(a1_, a2_)

    map(in(Set(a2_)), a1_)

end

function is_in!(bo_, di, an_)

    for an in an_

        nd = get(di, an, nothing)

        if !isnothing(nd)

            bo_[nd] = true

        end

    end

end

function index(an_)

    di = Dict{eltype(an_), Vector{Int}}()

    for nd in eachindex(an_)

        an = an_[nd]

        if !haskey(di, an)

            di[an] = Int[]

        end

        push!(di[an], nd)

    end

    di

end

function get_extreme(nu_)

    mi, ma = extrema(nu_)

    a1 = abs(mi)

    a2 = abs(ma)

    if isapprox(a1, a2)

        mi, ma

    elseif a2 < a1

        (mi,)

    else

        (ma,)

    end

end

function make(an_)

    d1 = Dict{String, Int}()

    d2 = Dict{Int, String}()

    un_ = unique(an_)

    for nd in eachindex(un_)

        un = un_[nd]

        d1[un] = nd

        d2[nd] = un

    end

    d1, d2

end

end
