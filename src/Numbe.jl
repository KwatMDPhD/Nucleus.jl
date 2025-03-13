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

function text_2(nu)

    @sprintf "%.2g" nu

end

function text_4(nu)

    @sprintf "%.4g" nu

end

end
