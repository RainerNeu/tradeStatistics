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

"""
    getMaxDDRate_relativeToLastPeak(arr)
calculates maximum Drawdown rate (not percentage!)
relative to the last Peak before DD (not relative to initial Capital)
parameter arr is the profit and loss series (not the aggregated profit and loss series)
be aware: data must be sorted by date upfront!
be aware: returns inf if there is no DD *only positiv trades*
          returns -inf if there are no positive trades
"""
function getMaxDDRate_relativeToLastPeak(arr::Array{Float64,1}, )::Float64
    equity = 0.0
    peak=0.0
    last_peak_before_maxDD=0.0
    last_peak_before_maxDD_position = 0
    maxDD=0.0                                                                   # initialize maxDD with Type FLOAT
    maxDDRate=0.0
    aggregatedSeries = getAccumulatedProfitLossSeries(arr);                     # create aggregatedSeries

    for n in eachindex(aggregatedSeries)
        equity = aggregatedSeries[n]
        #Check if new peak is available
        if equity>peak
            peak = equity
        elseif abs(peak-equity) > maxDD
            maxDD = abs(peak - equity)
            last_peak_before_maxDD_position = n
        end
    end

    #if no dd don´t search for last peak!
    if maxDD > 0
        if maximum(aggregatedSeries[1:last_peak_before_maxDD_position]) > 0
            last_peak_before_maxDD = maximum(aggregatedSeries[1:last_peak_before_maxDD_position])
        else
            last_peak_before_maxDD = 0.0
        end
    else
        last_peak_before_maxDD = 0.0
    end

    println("LastPeak:", last_peak_before_maxDD)

    if maxDD == 0.0 && last_peak_before_maxDD== 0.0                             #Assume there are only positiv trades
        return Inf
    elseif maxDD > 0 && last_peak_before_maxDD == 0.0                           #Assume there are only negativ trades
        return -Inf
    else
        return maxDD/last_peak_before_maxDD
    end
end

"""
    getMaxDD_Rate
sets the maximum Drawdown in relation to invested capital
returns 0.01 for 1%
"""
function getMaxDD_Rate(profitLossSeriesArray::Array{Float64,1}, initialCapital::Float64):: Float64
    maxDD = getMaxDD(profitLossSeriesArray)
    return (maxDD/initialCapital)
end


