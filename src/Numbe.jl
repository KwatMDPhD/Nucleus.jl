module Numbe

using Printf: @sprintf

function make_exponential(nu, ex)

    ab = abs(nu)

    isone(ex) ? ab : ab^ex

end

function text(nu)

    @sprintf "%.2g" nu

end

end
