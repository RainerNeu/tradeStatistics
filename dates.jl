"""
    getDaysBetweenDates_includeLast
calculates the days between two Dates (inluding the last day)
"""
function getDaysBetweenDates_includeLast(beginDate::Date, endDate::Date)::Float64
    endDate = endDate + Dates.Day(1)    
    return Dates.value(endDate - beginDate)
end
