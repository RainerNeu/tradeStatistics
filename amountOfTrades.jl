"""
    getAmountOfTrades
calculates amount of trades from a given array of trades
"""
function getAmountOfTrades(arr::Array{Float64})::Real
    amountOfTrades=length(arr)
    return amountOfTrades
end
