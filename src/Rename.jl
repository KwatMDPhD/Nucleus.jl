module Rename

function ge(di, st)

    haskey(di, st) ? di[st] : "_$st"

end

function lo(st_)

    u1 = lastindex(st_)

    u2 = count(!startswith('_'), st_)

    @info "📛 $u2 / $u1 ($(u2 / u1 * 100)%)."

end

end
