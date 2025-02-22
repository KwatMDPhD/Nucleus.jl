using Nucleus

# ---- #

const DI = pkgdir(Nucleus, "data", "Animation")

for (gi, pn_) in ((joinpath(tempdir(), "_.gif"), (joinpath(DI, "$id.png") for id in 1:2)),)

    Nucleus.Animation.writ(gi, pn_)

end
