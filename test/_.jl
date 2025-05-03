const TE = joinpath(tempdir(), "Nucleus")

rm(TE; recursive = true, force = true)

mkdir(TE)

function text(ch)

    "$ch$(lowercase(ch))"

end

function is_egal(a1, a2)

    typeof(a1) === typeof(a2) && a1 == a2

end
