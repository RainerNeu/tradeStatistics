"""
    convertRateToPercent
converts a rate (e.g. 0.081) to percentage (e.g. 8,1)
"""
function convertRateToPercent(rate::Float64)::Float64
    return rate*100
end
