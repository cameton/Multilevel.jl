
"""
"""
struct WCycle <: AbstractCycle end

"""
"""
struct WkCycle <: AbstractCycle 
    k::Int
end

""
function _cycle!(problem, level, ::WCycle)
    process_fine!(problem, level)
    _descend!(problem, level, WCycle())
    process_coarse!(problem, level)

    process_uncoarse!(problem, level)
    _descend!(problem, level, WCycle())
    process_coarse!(problem, level)
    return nothing
end

""
@inline function _repeatcycle!(problem, level, cycle_t::WkCycle)
    for i in 1:(cycle_t.k)
        process_uncoarse!(problem, level)
        _descend!(problem, level, cycle_t)
        process_coarse!(problem, level)
    end
    return nothing
end

""
function _cycle!(problem, level, cycle_t::WkCycle)
    process_fine!(problem, level)
    _descend!(problem, level, cycle_t)
    process_coarse!(problem, level)

    _repeatcycle!(problem, level, cycle_t)
    return nothing
end

