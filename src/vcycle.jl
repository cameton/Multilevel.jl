
"""
"""
struct VCycle <: AbstractCycle end

""
function _core_cycle!(problem, level, ::VCycle)
    process_fine!(problem, level)
    _descend!(problem, level, VCycle())
    process_coarse!(problem, level)
    return nothing
end
