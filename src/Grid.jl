module Grid

function make(nu_, um)

    mi, ma = extrema(nu_)

    range(mi, ma, um)

end

# TODO: Test.
function make(nu_, fr, um)

    mi, ma = extrema(nu_)

    fr *= (ma - mi)

    range(mi - fr, ma + fr, um)

end

function find(gr_, nu)

    id = findfirst(>=(nu), gr_)

    isnothing(id) ? lastindex(gr_) : id

end

end
