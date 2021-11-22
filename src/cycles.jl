
"""
"""
struct VCycle end

"""
"""
struct FCycle end

"""
"""
struct WCycle
    numrepeats::Int
end

const Cycle = Union{VCycle, WCycle, FCycle}

"""
"""
function cycle!(hierarchy, problem, cycle_t = VCycle(), numcycle = 1)
    preprocessing!(hierarchy, problem)
    _cycle!(hierarchy, problem, cycle_t, numcycle)
    postprocessing!(hierarchy, problem)
    return nothing
end

function _cycle!(hierarchy, problem, cycle_t, numcycle)
    for i in 1:numcycle
        precycle!(hierarchy, problem)
        _cycle!(hierarchy, problem, cycle_t)
        postcycle!(hierarchy, problem)
    end
    return nothing
end

""
@inline function _nextlevel!(hierarchy, cycle_t, problem)
    if doinitial(problem, hierarchy)
        initial!(hierarchy, problem)
        process_initial!(hierarchy, problem)
    else
        coarsen!(hierarchy, problem)
        _cycle!(hierarchy, cycletype, problem)
        uncoarsen!(hierarchy, problem)
    end

    process_coarse!(hierarchy, problem)
    return nothing
end

""
function _cycle!(hierarchy, ::VCycle, problem)
    process_fine!(hierarchy, problem)
    _nextlevel!(hierarchy, VCycle(), problem)
    return nothing
end

""
function _cycle!(hierarchy, ::FCycle, problem)
    process_fine!(hierarchy, problem)
    _nextlevel!(hierarchy, FCycle(), problem)
    process_uncoarse!(hierarchy, problem)
    _nextlevel!(hierarchy, VCycle(), problem)
    return nothing
end

""
@inline function _subcycle!(hierarchy, cycle_t, problem)
    for i in 1:(wcycle.numrepeats)
        process_uncoarse!(hierarchy, problem)
        _nextlevel!(hierarchy, cycle_t, problem)
    end
    return nothing
end

""
function _cycle!(hierarchy, cycle_t::WCycle, problem)
    process_fine!(hierarchy, problem)
    _nextlevel!(hierarchy, cycle_t, problem)
    _subcycle!(hierarchy, cycle_t, problem)
    return nothing
end

