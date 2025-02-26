module Path

function is_path(pa, ma)

    um = 0

    while !(bo = ispath(pa)) && um < ma

        sleep(1)

        @info "Waited for $pa ($(um += 1) / $ma)"

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
