module Geometry

function get_area(xc_, yc_)

    ar = 0

    for id in 2:lastindex(xc_)

        ar += (xc_[id] - xc_[id - 1]) * (yc_[id] + yc_[id - 1]) * 0.5
    end

    ar

end

end
