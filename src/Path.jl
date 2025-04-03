module Path

function is_path(st, u2)

    u1 = 0

    while !(bo = ispath(st)) && u1 < u2

        sleep(1)

        @info "Waited for $st ($(u1 += 1) / $u2)"

    end

    bo

end

function text(pa, di)

    pa[(lastindex(di) + 2):end]

end

function rea(pa)

    try

        run(`open --background $pa`)

    catch

        @warn pa

    end

end

end
