abstract type AbstractCycle end

function _cycle!(problem, levels, cycle_t, numcycle)
    for i in 1:(numcycle - 1)
        _cycle!(problem, levels, cycle_t)
        highest!(problem, levels)
    end
    _cycle!(problem, level, cycle_t)
    return nothing
end

"""
"""
function cycle!(problem, levels; cycle_t = VCycle(), numcycle = 1)
    preprocessing!(problem, levels)
    _cycle!(problem, levels, cycle_t, numcycle)
    postprocessing!(problem, levels)
    return nothing
end

"""
"""
function cycle(problem; cycle_t = VCycle(), numcycle = 1)
    levels = initialize(problem)
    return cycle!(problem, levels; cycle_t = cycle_t, numcycle = numcycle)
end


