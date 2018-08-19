mutable struct CounterFunction <: AbstractCounterFunction
    f::Function
    count::Int
end

CounterFunction(f::Function) = CounterFunction(f, 0)

function (cur_counter_function::CounterFunction)(vargs...; kwargs...)
    cur_output = cur_counter_function.f(vargs...; kwargs...)
    cur_counter_function.count += 1

    cur_output
end
