"""
    getNominalReturn
calculates the return of a "profit and loss"-series as absolute value
per definition: the net profit or loss of an investment defined by 
the change in value over a stated period including all costs and incomes
Formula is:     return = (endValue - initialValue)/initialValue
"""
function getNominalReturn(arr::Array{Float64,1})::Float64
    return Base.sum(arr)
end

"""
    getReturnRate
calculate the return of a tradeSeries as a rate
formula: returnRate = p(t)/p(0)-1 = (p(t) - p(0))/p(0)
"""
function getReturnRate(profitAndLossArray::Array{Float64,1}, initialValue::Float64)::Float64
    # if the initial value is 0 or less abort the programm and inform user
    if initialValue <= 0
        Error("Initial Value is 0 or less: See function getReturnRate");
        exit(0);
    end
    endValue = getVectorSum(profitAndLossArray)+initialValue;
    return ((endValue - initialValue) / initialValue)
end

"""
    getReturnRatePercentage
calculate the return of a tradeSeries as percentage
"""
function getReturnRatePercentage(profitAndLossArray::Array{Float64,1}, initialValue::Float64)::Float64
    return getReturnRate(profitAndLossArray,initialValue)*100
end

"""
    convertReturnToAnnulizedReturn
convert the return Rate to annulized Return with periods
"""
function convertReturnToAnnulizedReturn(returnRate::Float64, amountOfPeriods::Float64)::Float64
    return round(((1+returnRate)^(1/amountOfPeriods))-1,digits=3)
end
