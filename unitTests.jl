#=
Simple unit Tests
to test formulas
=#

using Test
using Dates


include("financeHelper.jl");

println("#### Test Starting")

initialCapital = 100.00                                                         #The initial capital as float
profit_loss_series_one = [10.0, 10.0, 10.0, 10.0, 10.0];                        #Scenario "No Drawdown"
profit_loss_series_two = [-5.0, -5, 0, 10.0, 10, 10, 10, -5, -5, -5, 10.0];     #Scenario "Drawdown somewhere"
profit_loss_series_three = [-5,-5.0];                                           #Scenario "only negativ trades"
profit_loss_series_four =
    [5.5, -5.5, -5, 15, -5, -5, -5, +15, +5, +5, +5, +5, +5, -10, 5, 5, 5,-5];           #Scenario "two times same DD"


@testset "getNominalReturn" begin
    @test 50 == getNominalReturn(profit_loss_series_one)
    @test 25 == getNominalReturn(profit_loss_series_two)
    @test -10 == getNominalReturn(profit_loss_series_three)
    @test 35 == getNominalReturn(profit_loss_series_four)
end

@testset "getAccumulatedProfitLossSeries" begin
    @test [10.0, 20.0, 30.0, 40.0, 50.0] ==
          getAccumulatedProfitLossSeries(profit_loss_series_one)
    @test [-5, -10, -10, 0, 10, 20, 30, 25, 20, 15, 25] ==
          getAccumulatedProfitLossSeries(profit_loss_series_two)
    @test [-5,-10.0] ==
          getAccumulatedProfitLossSeries(profit_loss_series_three)
    @test [5.5,0,-5,10,5,0,-5,10,15,20,25,30,35,25,30,35,40,35] ==
          getAccumulatedProfitLossSeries(profit_loss_series_four)
end

@testset "getMaxDD" begin
    @test 0 == getMaxDD(profit_loss_series_one)
    @test 15 == getMaxDD(profit_loss_series_two)
    @test 10 == getMaxDD(profit_loss_series_three)
    @test 15 == getMaxDD(profit_loss_series_four)
end

@testset "getMaxDDRate_relativeToLastPeak" begin
    @test Inf == getMaxDDRate_relativeToLastPeak(profit_loss_series_one)
    @test 0.5 == getMaxDDRate_relativeToLastPeak(profit_loss_series_two)
    @test -Inf == getMaxDDRate_relativeToLastPeak(profit_loss_series_three)
    @test 1.5 == getMaxDDRate_relativeToLastPeak(profit_loss_series_four)
end


@testset "getReturnRate" begin
    @test 0.5 == getReturnRate(profit_loss_series_one, initialCapital)
    @test 0.25 == getReturnRate(profit_loss_series_two, initialCapital)
end

@testset "getReturnRatePercentage" begin
    @test 50 == getReturnRatePercentage(profit_loss_series_one, initialCapital)
    @test 25 == getReturnRatePercentage(profit_loss_series_two, initialCapital)
end

@testset "getAnnulizedReturnRateBetweenDatesYearly" begin
    #For full year
    @test 0.5004166315911229 == getAnnulizedReturnRateBetweenDatesYearly(
        profit_loss_series_one,
        initialCapital,
        Date(2018, 1, 1),
        Date(2018, 12, 31),
    )
     #For 2 years
    @test 0.224914948717307 == getAnnulizedReturnRateBetweenDatesYearly(
        profit_loss_series_one,
        initialCapital,
        Date(2018, 1, 1),
        Date(2019, 12, 31),
    )
    #For 10 days
    @test 2.7022969825829207e6 == getAnnulizedReturnRateBetweenDatesYearly(
        profit_loss_series_one,
        initialCapital,
        Date(2018, 1, 1),
        Date(2018, 1, 10),
    )
end

@testset "getDaysBetweenDates_includeLast" begin
    @test 2 == getDaysBetweenDates_includeLast(
        Dates.Date(2018, 01, 01),
        Dates.Date(2018, 01, 02),
    )
    @test 365 == getDaysBetweenDates_includeLast(
        Dates.Date(2018, 01, 01),
        Dates.Date(2018, 12, 31),
    )
    @test 365 == getDaysBetweenDates_includeLast(
        Dates.Date(2019, 01, 01),
        Dates.Date(2019, 12, 31),
    )
    @test 366 == getDaysBetweenDates_includeLast(
        Dates.Date(2020, 01, 01),
        Dates.Date(2020, 12, 31),
    )
    @test 1096 == getDaysBetweenDates_includeLast(
        Dates.Date(2018, 01, 01),
        Dates.Date(2020, 12, 31),
    )
end

println("#### Test Ended")
