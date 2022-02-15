abstract type AbstractCycle end

""
@inline function _descend!(problem, level, cycle_t)
    coarsen!(problem, level)
    if doinitial(problem, level)
        initial!(problem, level)
        process_initial!(problem, level)
    else
        _cycle!(problem, level, cycle_t)
    end
    uncoarsen!(problem, level)
    return nothing
end

"""
"""
struct VCycle <: AbstractCycle end

""
function _cycle!(problem, level, ::VCycle)
    process_fine!(problem, level)
    _descend!(problem, level, VCycle())
    process_coarse!(problem, level)
    return nothing
end

include("./fcycle.jl")
include("./wcycle.jl")

function _cycle!(problem, level, cycle_t, numcycle)
    for i in 1:numcycle
        precycle!(problem, level)
        _cycle!(problem, level, cycle_t)
        postcycle!(problem, level)
    end
    return nothing
end

"""
"""
function cycle!(problem, level, cycle_t = VCycle(), numcycle = 1)
    preprocessing!(problem, level)
    _cycle!(problem, level, cycle_t, numcycle)
    postprocessing!(problem, level)
    return nothing
end

