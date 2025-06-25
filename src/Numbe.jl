module Numbe

using Printf: @sprintf

function make(nu)

    sign(nu) * sqrt(abs(nu))

end

function ge(nu_)

    ty = eltype(nu_)

    ne_ = ty[]

    po_ = ty[]

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
