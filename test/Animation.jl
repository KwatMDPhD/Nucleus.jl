using Nucleus

include("_.jl")

# ---- #

for (gi, pn_) in ((
    joinpath(TE, "_.gif"),
    (pkgdir(Nucleus, "data", "Animation", "$id.png") for id in 1:2),
),)

    Nucleus.Animation.writ(gi, pn_)

end
