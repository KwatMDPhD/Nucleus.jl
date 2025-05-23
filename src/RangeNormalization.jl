module RangeNormalization

using StatsBase: mean, std

function update_shift!(nu_)

    mi = minimum(nu_)

    map!(nu -> nu - mi, nu_, nu_)

end

function update_log2!(nu_)

    mi = minimum(nu_)

    map!(nu -> log2(nu - mi + 1), nu_, nu_)

end

function update_0!(nu_)

    me = mean(nu_)

    iv = inv(std(nu_))

    map!(nu -> (nu - me) * iv, nu_, nu_)

end

function update_01!(nu_)

    mi, ma = extrema(nu_)

    iv = inv(ma - mi)

    map!(nu -> (nu - mi) * iv, nu_, nu_)

end

function update_sum!(po_)

    iv = inv(sum(po_))

    map!(po -> po * iv, po_, po_)

end

end
