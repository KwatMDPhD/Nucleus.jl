module RankNormalization

using StatsBase: competerank, denserank, quantile, tiedrank

function update!(nu_, fr_)

    ma_ = quantile(nu_, fr_)

    map!(nu -> findfirst(>=(nu), ma_), nu_, nu_)

end

function make_1223(nu_)

    denserank(nu_)

end

function make_1224(nu_)

    competerank(nu_)

end

function make_125254(nu_)

    tiedrank(nu_)

end

end
