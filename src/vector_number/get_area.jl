function get_area(ve::Vector{Float64})::Float64

    return sum(ve) / convert(Float64, length(ve))

end

export get_area
