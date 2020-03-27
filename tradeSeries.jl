"""
    getAccumulatedTradeSeries(arr)
generates the profit and loss series by a given array containing profit and losses
be aware: data must be sorted by date upfront!
@todo: generalize type definition
"""
function getAccumulatedProfitLossSeries(profitLossSeriesArray::Array{Float64,1})
    accumulatedProfitAndLossSeries=accumulate(+, profitLossArray);
    return accumulatedProfitAndLossSeries
end
