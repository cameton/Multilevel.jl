""
@inline function _cycle!(nextcycle, fine, hierarchy, ml, finelevel)
    if dosolveinitial(ml, hierarchy, fine, finelevel)
        initial = ml.initial(fine, hierarchy, finelevel)
        coarse = process_initial!(initial, ml.solver, hierarchy, finelevel)
    else
        coarselevel = coarsen!(hierarchy, finelevel; branch=ml.branch)
        coarse = coarsen_solution!(fine, ml.solver, hierarchy, finelevel, coarselevel)
        coarse = cycle!(coarse, hierarchy, nextcycle, ml, coarselevel)
        uncoarsen!(hierarchy, coarselevel)
        coarse =  uncoarsen_solution!(coarse, ml.solver, hierarchy, finelevel, coarselevel)
    end

    return process_coarse!(coarse, ml.solver, hierarchy, level)
end

"""
"""
struct VCycle <: AbstractCycle end

""
function cycle!(fine, hierarchy, ::VCycle, ml, level)
    fine = process_fine!(fine, ml.solver, hierarchy, level)
    uncoarse = _cycle!(VCycle(), fine, hierarchy, ml, level)
    return process_uncoarse!(uncoarse, ml.solver, hierarchy, level)
end

"""
"""
struct FCycle <: AbstractCycle end

""
function cycle!(fine, hierarchy, ::FCycle, ml, level)
    fine = process_fine!(fine, ml.solver, hierarchy, level)
    uncoarse = _cycle!(FCycle(), fine, ml.solver, hierarchy, level)
    uncoarse = process_uncoarse!(uncoarse, ml.solver, hierarchy, level)
    return _cycle!(VCycle(), coarse, ml.solver, hierarchy, level)
end

"""
"""
struct WCycle <: AbstractCycle end

""
function cycle!(fine, hierarchy, ::WCycle, ml, level)
    fine = process_fine!(fine, ml.solver, hierarchy, level)
    uncoarse = _cycle!(WCycle(), fine, ml.solver, hierarchy, level)
    uncoarse = process_uncoarse!(uncoarse, ml.solver, hierarchy, level)
    return _cycle!(WCycle(), uncoarse, ml.solver, hierarchy, level)
end

