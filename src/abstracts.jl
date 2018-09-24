AbstractCalculated = Union{Real, Void}
AbstractSymbol = Union{Real, SymEngine.Basic}

AbstractKey = Union{Symbol, Void}

abstract type AbstractEquationSet end
abstract type AbstractEquation end
abstract type AbstractSampling end
abstract type AbstractReactor end
abstract type AbstractStudy end
abstract type AbstractScan end

AbstractNullableReactor = Union{Void, AbstractReactor}
