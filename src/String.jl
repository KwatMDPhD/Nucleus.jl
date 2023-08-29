module String

using Printf: @sprintf

using ..BioLab

function format(nu)

    if isequal(nu, -0.0)

        nu = 0.0

    end

    @sprintf "%.4g" nu

end

function try_parse(st)

    try

        return convert(Int, parse(Float64, st))

    catch

    end

    try

        return parse(Float64, st)

    catch

    end

    st

end

function limit(st, n)

    if n < length(st)

        su = view(st, 1:n)

        return "$su..."

    end

    st

end

function split_get(st, de, id)

    split(st, de; limit = id + 1)[id]

end

function dice(st)

    split.(eachsplit(st, '\n'), '\t')

end

function count(n, st)

    if n <= 1

        return "$n $st"

    end

    if length(st) == 3 && view(st, 2:3) == "ex"

        return "$n $(st)es"

    end

    for (si, pl) in (("ex", "ices"), ("ry", "ries"), ("o", "oes"))

        if endswith(st, si)

            su = view(st, 1:(length(st) - length(si)))

            return "$n $su$pl"

        end

    end

    "$n $(st)s"

end

end
