"""
    getNominalReturn
calculates the return of a "profit and loss"-series as absolute value
per definition: the net profit or loss of an investment defined by the change in value
over a stated period including all costs and incomes
Formula is:     return = (endValue - initialValue)/initialValue
"""
function getNominalReturn(arr::Array{Float64,1})::Float64
    return Base.sum(arr)
end
