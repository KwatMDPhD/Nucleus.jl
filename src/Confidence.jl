module Confidence

using Distributions: Normal, quantile

using StatsBase: std

function make(nu_, fr = 0.95)

    quantile(Normal(), 0.5 + fr * 0.5) * std(nu_) / sqrt(lastindex(nu_))

end

end
