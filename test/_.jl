const TE = joinpath(tempdir(), "Nucleus")

rmtree(TE; recursive = true, force = true)

mkdir(TE)

function is_egal(a1_, a2_)

    eltype(a1_) === eltype(a2_) && a1_ == a2_

end
