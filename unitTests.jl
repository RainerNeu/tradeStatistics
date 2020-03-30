#=
Simple unit Tests
to test formulas
=#

using Test

include("maxDD.jl")
include("return.jl")
include("tradeSeries.jl")

println("#### Test Starting")

initialCapital = 100.00                                                         #The initial capital as float
profit_loss_series_one=[10.0,10.0,10.0,10.0,10.0];                              #Create an Array
profit_loss_series_two=[-5.0,-5,0,10.0,10,10,10,-5,-5,-5,10.0];

@testset "getNominalReturn" begin
    @test 50 == getVectorSum(profit_loss_series_one)
    @test 25 == getVectorSum(profit_loss_series_two)
end

@testset "getAccumulatedProfitLossSeries" begin
    @test [10.0,20.0,30.0,40.0,50.0] == getAccumulatedProfitLossSeries(profit_loss_series_one)
    @test [-5,-10,-10,0,10,20,30,25,20,15,25] == getAccumulatedProfitLossSeries(profit_loss_series_two)
end

@testset "getMaxDD" begin
    @test 0 == getMaxDD(profit_loss_series_one)
    @test 15 == getMaxDD(profit_loss_series_two)
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
    @test 0.5004166315911229 == getAnnulizedReturnRateBetweenDatesYearly(profit_loss_series_one,initialCapital,Date(2018,1,1),Date(2018,12,31))                 #For full year
    @test 0.224914948717307 == getAnnulizedReturnRateBetweenDatesYearly(profit_loss_series_one,initialCapital,Date(2018,1,1),Date(2019,12,31))                  #For 2 years
    @test 2.7022969825829207e6 == getAnnulizedReturnRateBetweenDatesYearly(profit_loss_series_one,initialCapital,Date(2018,1,1),Date(2018,1,10))               #For 10 days
end


println("#### Test Ended")
