module Dictionary

using JSON: parsefile, print

using OrderedCollections: OrderedDict

using TOML: parsefile as parsefil

using ..Nucleus

function update!(di, ke, va)

    id = 1

    while haskey(di, ke)

        ke = "$(isone(id) ? ke : Nucleus.Strin.get_not_end(ke, '.')).$(id += 1)"

    end

    di[ke] = va

end

function make(d1, d2)

    d3 = Dict{
        Union{eltype(keys(d1)), eltype(keys(d2))},
        Union{eltype(values(d1)), eltype(values(d2))},
    }()

    for ke in union(keys(d1), keys(d2))

        d3[ke] = if haskey(d1, ke) && haskey(d2, ke)

            v1 = d1[ke]

            v2 = d2[ke]

            v1 isa AbstractDict && v2 isa AbstractDict ? make(v1, v2) : v2

        elseif haskey(d1, ke)

            d1[ke]

        else

            d2[ke]

        end

    end

    d3

end

function rea(js, dicttype = OrderedDict)

    endswith(js, "toml") ? parsefil(js) : parsefile(js; dicttype)

end

function writ(js, di, um = 2)

    open(js, "w") do io

        print(io, di, um)

    end

end

end
