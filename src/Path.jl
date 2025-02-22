module Path

function is_path(pa, u1)

    u2 = 0

    while !(bo = ispath(pa)) && u2 < u1

        sleep(1)

        @info "Waited for $pa ($(u2 += 1) / $u1)"

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
