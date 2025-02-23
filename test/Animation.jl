using Nucleus

# ---- #

for (gi, pn_) in ((
    joinpath(tempdir(), "_.gif"),
    (pkgdir(Nucleus, "data", "Animation", "$id.png") for id in 1:2),
),)

    Nucleus.Animation.writ(gi, pn_)

end
