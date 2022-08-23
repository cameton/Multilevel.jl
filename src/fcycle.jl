
"""
"""
struct FCycle <: AbstractCycle 
    repeats::UInt
end

FCycle() = FCycle(1)

function _fcycle_repeat!(problem, levels, repeats)
    for i in 1:repeats
        pre_redescent!(problem, levels)
        descend!(problem, levels)
        _cycle!(problem, levels, VCycle())
        ascend!(problem, levels)
        post_ascent!(problem, levels)
    end
    return nothing
end

function _fcycle_ascend!(problem, levels, depth, repeats)
    for _ in 1:depth
        ascend!(problem, levels)
        post_ascent!(problem, levels)
        _fcycle_repeat!(problem, levels, repeats)
    end
    return nothing
end

function _cycle!(problem, levels, cycle_T::FCycle)
    depth = _vcycle_descend!(problem, levels)
    _fcycle_ascend!(problem, levels, depth, cycle_T.repeats)
    return nothing
end
