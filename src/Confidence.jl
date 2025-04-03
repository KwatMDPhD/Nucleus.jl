module Confidence

using Distributions: Normal, quantile

using StatsBase: std

function make(nu_, pr = 0.95)

    quantile(Normal(), 0.5 + pr * 0.5) * std(nu_) / sqrt(lastindex(nu_))

end

end
