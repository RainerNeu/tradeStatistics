"""
    getMaxDDfromProfitAndLoss(arr)
calculates the maximum Drawdown of profit and loss series
(not the aggregated profit and loss series)
be aware: data must be sorted by date upfront!
"""
function getMaxDD(arr::Array{Float64,1})::Float64
    maxDD=0.0                                                       # initialize maxDD with Type FLOAT
    aggregatedSeries = getProfitAndLossAggregatedSeries(arr);       # create aggregatedSeries
    for n in eachindex(arr)                                         # iterate through trades
        max::Float64 = maximum(aggregatedSeries[1:n])               # Calculate max of equity-curve
        if (max-aggregatedSeries[n])>maxDD                          # if difference of actual equity curve to max greater
            maxDD = (max-aggregatedSeries[n])                       # this will be new maxDD
        end
    end
    return maxDD
end
