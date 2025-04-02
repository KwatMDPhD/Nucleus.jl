module Rename

function ge(di, st)

    haskey(di, st) ? di[st] : "_$st"

end

function lo(na_)

    u1 = lastindex(na_)

    u2 = count(!startswith('_'), na_)

    @info "📛 $u2 / $u1 ($(u2 / u1 * 100)%)."

end

end
