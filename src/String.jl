module String

using Random: randstring

function is_bad(st)

    isempty(st) || contains(st, r"^[^0-9A-Za-z]+$")

end

function clean(st)

    replace(st, r"[^._0-9A-Za-z]" => '_')

end

function make(ar_...)

    randstring(ar_...)

end

function limit(st, n)

    n < lastindex(st) ? "$(view(st, 1:n))..." : st

end

function count(n, st)

    n_ch = lastindex(st)

    if iszero(n) || isone(abs(n))

        pl = st

    elseif n_ch == 3 && view(st, 2:3) == "ex"

        pl = "$(st)es"

    elseif endswith(st, "ex")

        pl = "$(view(st, 1:(n_ch - 2)))ices"

    elseif endswith(st, "ry")

        pl = "$(view(st, 1:(n_ch - 2)))ries"

    elseif endswith(st, "o")

        pl = "$(view(st, 1:(n_ch - 1)))oes"

    else

        pl = "$(st)s"

    end

    "$n $pl"

end

end
