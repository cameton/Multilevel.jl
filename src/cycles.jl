abstract type AbstractCycle end

""
@inline function _descend!(problem, level, cycle_t)
    coarsen!(problem, level)
    _cycle!(problem, level, cycle_t)
    uncoarsen!(problem, level)
    return nothing
end

@inline function _cycle!(problem, level, cycle_t)
    if doinitial(problem, level)
        initial!(problem, level)
        process_initial!(problem, level)
    else
        _core_cycle!(problem, level, cycle_t)
    end
    return nothing
end

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

