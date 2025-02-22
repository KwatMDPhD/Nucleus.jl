module Strin

function is_bad(st)

    isempty(st) || contains(st, r"^[^0-9A-Za-z]+$")

end

function update_slash(st)

    replace(st, '/' => '_')

end

function update_space(st)

    replace(strip(st), r" +" => ' ')

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

end
