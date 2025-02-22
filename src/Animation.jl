module Animation

using ..Nucleus

function writ(gi, pn_)

    run(`magick -delay 32 $pn_ $gi`)

    Nucleus.Path.rea(gi)

end

end
