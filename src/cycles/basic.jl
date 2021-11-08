""
@inline function _initiallevel(hierarchy, ml, level)
    ml.initial(hierarchy, finelevel)
    process_initial!(hierarchy, ml.solver, level)
end

""
@inline function _coarselevel(hierarchy, cycletype, ml, finelevel)
    coarselevel = coarsen!(hierarchy, finelevel, ml.branch)
    _cycle!(hierarchy, cycletype, ml, coarselevel)
    uncoarsen!(hierarchy, coarselevel)
end

""
@inline function _nextlevel!(hierarchy, cycletype, ml, level)
    if dosolveinitial(ml, hierarchy, level)
        _initiallevel(hierarchy, ml, level)
    else
        _coarselevel(hierarchy, cycletype, ml, level)
    end

    process_coarse!(coarse, ml.solver, hierarchy, level)
end

"""
"""
struct VCycle <: AbstractCycle end

""
function _cycle!(hierarchy, ::VCycle, ml, level)
    process_fine!(hierarchy, ml.solver, level)
    _nextlevel!(hierarchy, VCycle(), ml, level)
end

"""
"""
struct FCycle <: AbstractCycle end

""
function _cycle!(hierarchy, ::FCycle, ml, level)
    process_fine!(hierarchy, ml.solver, level)
    _nextlevel!(hierarchy, FCycle(), ml.solver, level)
    process_uncoarse!(hierarchy, ml.solver, level)
    _nextlevel!(hierarchy, VCycle(), ml.solver, level)
end

"""
"""
struct WCycle <: AbstractCycle end

""
function cycle!(hierarchy, ::WCycle, ml, level)
    process_fine!(hierarchy, ml.solver, level)
    _cycle!(hierarchy, WCycle(), ml.solver, level)
    process_uncoarse!(hierarchy, ml.solver, level)
    _cycle!(hierarchy, WCycle(), ml.solver, hierarchy, level)
end

