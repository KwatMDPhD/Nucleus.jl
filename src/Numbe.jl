module Numbe

using Printf: @sprintf

function ge(nu_)

    ne_ = similar(nu_, 0)

    po_ = similar(nu_, 0)

    for nu in nu_

        push!(nu < 0 ? ne_ : po_, nu)

    end

    ne_, po_

end

function text(nu)

    @sprintf "%.2g" nu

end

end
