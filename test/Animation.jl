using Nucleus

include("_.jl")

# ---- #

const DA = pkgdir(Nucleus, "da", "Animation")

for (gi, pn_) in ((joinpath(TE, "_.gif"), (joinpath(DA, "1.png"), joinpath(DA, "2.png"))),)

    Nucleus.Animation.writ(gi, pn_)

end
