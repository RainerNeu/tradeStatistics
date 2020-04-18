"""
    getCalmarRatio_percentage
calculates the calmarRatio for a given "profit and loss- series
Calmar Ratio = Average Annual Rate of Return / Maximum Drawdown
"""
function getCalmarRatio_percentage(profitAndLossArray::Array{Float64,1}, capitalAtBeginn::Float64, beginDate::Date, endDate::Date)::Float64
    averageAnnualReturnRate::Float64 = getAnnulizedReturnRateBetweenDatesYearly(profitAndLossArray,capitalAtBeginn,beginDate,endDate)
    maxDD_absolute::Float64 = getMaxDD(profitAndLossArray)
    maxDD_percentage = getMaxDDPercentage(maxDD_absolute,capitalAtBeginn)
    averageAnnualReturnRate_percentage = convertRateToPercent(averageAnnualReturnRate)
    return averageAnnualReturnRate_percentage/maxDD_percentage
end
