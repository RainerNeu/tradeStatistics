"""
    getMaxDD(arr)
calculates the maximum Drawdown of profit and loss series
(not the aggregated profit and loss series)
be aware: data must be sorted by date upfront!
"""
function getMaxDD(arr::Array{Float64,1})::Float64
    peak=0.0
    maxDD=0.0                                                                   # initialize maxDD with Type FLOAT
    equity = 0.0
    aggregatedSeries = getAccumulatedProfitLossSeries(arr);                     # create aggregatedSeries

    for n in eachindex(aggregatedSeries)
        equity = aggregatedSeries[n]
        #Check if new peak is available
        if equity>peak
            peak = equity
        else
            if abs(peak-equity) > maxDD
                maxDD = abs(peak - equity)
            end
        end
    end
    return maxDD
end
