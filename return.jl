"""
    getNominalReturn
calculates the return of a "profit and loss"-series as absolute value
per definition: the net profit or loss of an investment defined by the change
in value over a stated period including all costs and incomes
Formula is:     return = (endValue - initialValue)/initialValue
"""
function getNominalReturn(arr::Array{Float64,1})::Float64
    return Base.sum(arr)
end

"""
    getReturn_rate
calculate the return of a tradeSeries as a rate
formula: returnRate = p(t)/p(0)-1 = (p(t) - p(0))/p(0)
"""
function getReturn_rate(profitAndLossArray::Array{Float64,1}, initialValue::Float64)::Float64
    # if the initial value is 0 or less abort the programm and inform user
    if initialValue <= 0
        Error("Initial Value is 0 or less: See function getReturnRate");
        exit(0);
    end
    endValue = getNominalReturn(profitAndLossArray)+initialValue;
    return ((endValue - initialValue) / initialValue)
end


"""
    getReturn_percentage
calculate the return of a tradeSeries as percentage
"""
function getReturn_percentage(profitAndLossArray::Array{Float64,1}, initialValue::Float64)::Float64
    return getReturn_rate(profitAndLossArray,initialValue)*100
end


"""
    convertReturnToAnnulizedReturn
convert the return Rate to annulized Return with periods
"""
function convertReturnToAnnulizedReturn(returnRate::Float64, amountOfPeriods::Float64)::Float64
    return round(((1+returnRate)^(1/amountOfPeriods))-1,digits=3)
end

"""
    getAnnulizedReturnRateBetweenDates
calculates the annulized Return between twoDates for yearly scale
"""
function getAnnulizedReturnRateBetweenDatesYearly(profitAndLossArray::Array{Float64,1}, capitalAtBeginn::Float64, beginDate::Date, endDate::Date)::Float64
    averageAmountOfDaysPerYear::Float64 = 365.25                                #Average amount of days per year taking in account leap years
    returnRate::Float64 = getReturnRate(profitAndLossArray,capitalAtBeginn)
    amountOfDays = Dates.days((endDate + Dates.Day(1)) - beginDate)             # +1 to set the end-day to a closed-interval: 01.01.2018 to 31.12.2018 includes the 31.12.2018
    return ((1+returnRate)^(365.25/amountOfDays))-1                             # 365.25 amount of days per year taking in account leap years
end

"""
    getYearlyAverageProfit_betweenDates
calculates the average yearly return for a given array of profits and losses
between two given Dates
"""

function getYearlyAverageProfit_betweenDates(profitAndLossArray::Array{Float64,1},beginDate::Date, endDate::Date)::Float64
    nominalReturn = getNominalReturn(profitAndLossArray);
    amountOfDaysBetween = getDaysBetweenDates_includeLast(beginDate, endDate);
    amountOfYearsBetween = getDaysBetweenDates_includeLast(beginDate,endDate)/365.25
    return nominalReturn / amountOfYearsBetween
end

"""
    getYearlyAverageProfit_percentage
calculates the average yearly return for a given array of profits and losses
and returns the percentage values
"""

function getYearlyAverageProfit_percentage(profitAndLossArray::Array{Float64,1},beginDate::Date, endDate::Date, initialCapital::Float64)::Float64
    yearlyAverageProfit::Float64 = getYearlyAverageProfit(profitAndLossArray, beginDate,endDate)
    return (yearlyAverageProfit/initialCapital)*100
end
