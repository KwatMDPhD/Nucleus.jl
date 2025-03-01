module Collection

function is_in(a1_, a2_)

    map(in(Set(a2_)), a1_)

end

function is_in!(bo_, di, an_)

    for an in an_

        id = get(di, an, nothing)

        if !isnothing(id)

            bo_[id] = true

        end

    end

end

function index(an_)

    di = Dict{eltype(an_), Vector{Int}}()

    for id in eachindex(an_)

        an = an_[id]

        if !haskey(di, an)

            di[an] = Int[]

        end

        push!(di[an], id)

    end

    di

end

function get_extreme(nu_)

    mi, ma = extrema(nu_)

    a1 = abs(mi)

    a2 = abs(ma)

    if isapprox(a1, a2)

        (mi, ma)

    elseif a2 < a1

        (mi,)

    else

        (ma,)

    end

end

end
