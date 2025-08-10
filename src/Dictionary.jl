module Dictionary

using JSON: parsefile, print

using TOML: parsefile as parsefil

using ..Nucleus

function update!(di, st, an)

    nd = 1

    while haskey(di, st)

        st = "$(isone(nd) ? st : Nucleus.Strin.get_not_end(st, '.')).$(nd += 1)"

    end

    di[st] = an

end

function make(un)

    un == Union{Dict{String, Int64}, Dict{String, String}} ? Dict{String, Any} : un

end

function make(d1::AbstractDict, d2::AbstractDict)

    d3 = Dict{
        make(Union{eltype(keys(d1)), eltype(keys(d2))}),
        make(Union{eltype(values(d1)), eltype(values(d2))}),
    }()

    for an in union(keys(d1), keys(d2))

        d3[an] = if haskey(d1, an) && haskey(d2, an)

            make(d1[an], d2[an])

        elseif haskey(d1, an)

            d1[an]

        else

            d2[an]

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
