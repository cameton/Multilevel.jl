
"""
"""
struct FCycle <: AbstractCycle end

"""
"""
struct FkCycle <: AbstractCycle 
    k::Int
end

""
function _cycle!(problem, level, ::FCycle)
    process_fine!(problem, level)
    _descend!(problem, level, FCycle())
    process_coarse!(problem, level)

    process_uncoarse!(problem, level)
    _descend!(problem, level, VCycle())
    process_coarse!(problem, level)
    return nothing
end

""
@inline function _repeatcycle!(problem, level, cycle_t::FkCycle)
    for i in 1:(cycle_t.k)
        process_uncoarse!(problem, level)
        _descend!(problem, level, VCycle())
        process_coarse!(problem, level)
    end
    return nothing
end

""
function _cycle!(problem, level, cycle_t::FkCycle)
    process_fine!(problem, level)
    _descend!(problem, level, cycle_t)
    process_coarse!(problem, level)

    _repeatcycle!(problem, level, cycle_t)
    return nothing
end

