module Path

function clean(na)

    if contains(na, '/')

        error("\"$na\" contains '/'.")

    end

    replace(lowercase(na), r"[^.0-9_a-z]" => '_')

end

function get_extension(pa)

    splitext(pa)[2][2:end]

end

function wait(pa, ma = 4; sl = 1)

    su = 0

    while su < ma && !ispath(pa)

        sleep(sl)

        @info "Waiting for $pa ($(su += sl) / $ma)"

    end

end

function read(di; ig_ = (), ke_ = (), ke_ar...)

    pa_ = Vector{String}()

    for pa in readdir(di; ke_ar...)

        na = basename(pa)

        if !any(occursin(na), ig_) && (isempty(ke_) || any(occursin(na), ke_))

            push!(pa_, pa)

        end

    end

    pa_

end

function open(pa)

    try

        run(`open --background $pa`)

        nothing

    catch

        @warn "Could not open $pa."

    end

end

function remove(pa; ke_ar...)

    rm(pa; ke_ar...)

    @info "Removed $pa."

end

function remake_directory(di)

    if isdir(di)

        remove(di; recursive = true)

    elseif ispath(di)

        error("$di is not a directory.")

    end

    mkdir(di)

    nothing

end

end
