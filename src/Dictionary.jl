module Dictionary

using JSON: parsefile, print

using TOML: parsefile as parsefil

using ..Nucleus

function update!(di, st, an)

    id = 1

    while haskey(di, st)

        st = "$(isone(id) ? st : Nucleus.Strin.get_not_end(st, '.')).$(id += 1)"

    end

    di[st] = an

end

function make(d1::AbstractDict, d2::AbstractDict)

    d3 = Dict{
        Union{eltype(keys(d1)), eltype(keys(d2))},
        Union{eltype(values(d1)), eltype(values(d2))},
    }()

    for a3 in union(keys(d1), keys(d2))

        d3[a3] = if haskey(d1, a3) && haskey(d2, a3)

            make(d1[a3], d2[a3])

        elseif haskey(d1, a3)

            d1[a3]

        else

            d2[a3]

        end

    end

    d3

end

function make(::Any, an)

    an

end

function rea(fi)

    endswith(fi, "toml") ? parsefil(fi) : parsefile(fi)

end

function writ(js, di, um = 2)

    open(js, "w") do io

        print(io, di, um)

    end

end

end
