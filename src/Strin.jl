module Strin

function is_bad(st)

    isempty(st) || contains(st, r"^[^0-9A-Za-z]+$")

end

function ge(st, nd, de = isspace)

    split(st, de; limit = nd + 1)[nd]

end

function get_1(st, de = isspace)

    ge(st, 1, de)

end

function get_not_1(st, de = isspace)

    split(st, de; limit = 2)[2]

end

function get_end(st, de = isspace)

    rsplit(st, de; limit = 2)[2]

end

function get_not_end(st, de = isspace)

    rsplit(st, de; limit = 2)[1]

end

function text_letter(st)

    join(ch for ch in st if isletter(ch))

end

function text_limit(st, um)

    if lastindex(st) <= um

        return st

    end

    st = st[1:um]

    "$st..."

end

end
