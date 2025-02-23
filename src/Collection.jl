module Collection

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

end
