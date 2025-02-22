module Strin

function is_bad(st)

    isempty(st) || contains(st, r"^[^0-9A-Za-z]+$")

end

function ge(st, id, de = ' ')

    split(st, de; limit = id + 1)[id]

end

function get_1(st, de = ' ')

    ge(st, 1, de)

end

function get_not_1(st, de = ' ')

    split(st, de; limit = 2)[2]

end

function get_end(st, de = ' ')

    rsplit(st, de; limit = 2)[2]

end

function get_not_end(st, de = ' ')

    rsplit(st, de; limit = 2)[1]

end

function make_short(st, ma)

    lastindex(st) <= ma ? st : "$(st[1:ma])..."

end

end
