module Pai

function make(an, c1_, c2)

    di = Dict{String, String}()

    K = Matrix(an[!, c1_])

    va_ = an[!, c2]

    for i1 in eachindex(va_)

        va = va_[i1]

        if ismissing(va)

            continue

        end

        for i2 in eachindex(c1_)

            ke = K[i1, i2]

            if ismissing(ke)

                continue

            end

            # TODO: Generalize.
            for st in eachsplit(ke, '|')

                di[st] = va

            end

        end

    end

    di

end

function ge(di, ke)

    haskey(di, ke) ? di[ke] : "_$ke"

end

function text(va_)

    u1 = lastindex(va_)

    u2 = count(!startswith('_'), va_)

    @info "📛 $u2 / $u1 ($(u2 / u1 * 100)%)."

end

end
