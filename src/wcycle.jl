
"""
"""
struct WCycle <: AbstractCycle 
    repeats::UInt
    depth::Vector{Uint}
end

WCycle() = WCycle(1, UInt[])
function WCycle(repeats, hint)
    depth = UInt[]
    sizehint!(depth, hint)
    return WCycle(repeats, depth)
end

function _wcycle_descend!(problem, levels, depth)
    while !is_lowest(problem, levels) 
        push!(depth, 0)
        pre_descent!(problem, levels)
        descend!(problem, levels) 
    end 
    lowest!(problem, levels)
    return nothing
end

function _wcycle_ascend!(problem, levels, depth, repeats)
    while len(depth) > 0
        ascend!(problem, levels)
        post_ascent!(problem, levels)
        if depth[end] >= repeats
            pop!(depth)
        else
            depth[end] += 1 
            pre_redescent!(problem, levels)
            descend!(problem, levels)
            _wcycle_descend!(problem, levels, depth)
        end
    end
    return nothing
end

""
function _cycle!(problem, levels, cycle_T::WCycle)
    empty!(cycle_T.depth)
    _wcycle_descend!(problem, levels, cycle_T.depth)
    _wcycle_ascend!(problem, levels, cycle_T.depth, cycle_T.repeats)
end
