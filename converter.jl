"""
    convertRateToPercent
calculates the annulized Return between twoDates for yearly scale
"""
function convertRateToPercent(rate::Float64)::Float64
    return rate*100
end
