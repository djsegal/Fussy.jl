AbstractCalculated = Union{Real, Void}
AbstractSymbol = Union{Real, SymEngine.Basic}

AbstractKey = Union{Symbol, Void}

abstract type AbstractCounterFunction end
abstract type AbstractSampling end
abstract type AbstractReactor end
abstract type AbstractStudy end
abstract type AbstractScan end
