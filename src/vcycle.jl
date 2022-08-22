
"""
"""
struct VCycle <: AbstractCycle end

""
function _vcycle_descend!(problem, levels)
    depth = 0
    while !doinitial(problem, levels) 
        depth += 1
        pre_descent!(problem, levels)
        descend!(problem, levels) 
    end
    lowest!(problem, levels)
    return depth
end

""
function _vcycle_ascend!(problem, levels, depth)
    for _ in 1:depth
        ascend!(problem, levels)
        post_ascent!(problem, levels)
    end
    return nothing
end

""
function _cycle!(problem, levels, ::VCycle)
    depth = _vcycle_descend!(problem, levels)
    _vcycle_ascend!(problem, levels, depth)
    return nothing
end

