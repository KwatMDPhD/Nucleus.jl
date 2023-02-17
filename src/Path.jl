module Path

function list(di; jo = false, ig_ = (r"^\.",), ke_ = ())

    pa_ = Vector{String}()

    for pa in readdir(di; join = jo)

        na = basename(pa)

        if !any(contains(na, ig) for ig in ig_) &&
           (isempty(ke_) || any(contains(na, ke) for ke in ke_))

            push!(pa_, pa)

        end

    end

    return pa_

end

function make_temporary(pa)

    pat = joinpath(tempdir(), pa)

    if ispath(pat)

        rm(pat; recursive = true)

    end

    return mkdir(pat)

end

end
