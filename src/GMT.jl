module GMT

using ..Nucleus

function read(gm)

    se_ge_ = Dict{String, Vector{String}}()

    for li in eachline(gm)

        sp_ = split(li, '\t')

        se = sp_[1]

        Nucleus.Error.error_has_key(se_ge_, se)

        se_ge_[se] = filter!(!isempty, view(sp_, 3:lastindex(sp_)))

    end

    se_ge_

end

end
