const TE = joinpath(tempdir(), "Nucleus")

rm(TE; recursive = true, force = true)

mkdir(TE)

function text(ch)

    "$ch$(lowercase(ch))"

end

function is_egal(a1_, a2_)

    eltype(a1_) === eltype(a2_) && a1_ == a2_

end
