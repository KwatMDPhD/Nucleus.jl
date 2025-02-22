module Extreme

function index(u1::Integer, u2)

    u1 * 0.5 <= u2 ? (1:u1) : vcat(1:u2, (u1 - u2 + 1):u1)

end

function index(an_, um)

    sortperm(an_)[index(lastindex(an_), um)]

end

end
