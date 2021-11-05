"""
...
"""
struct ML{C<:AbstractCycle, S<:AbstractSolver, T}
    cycle::C
    numcycle::Int
    branch::Bool
    solver::S
    initial::T
end

(ml::ML)(solution, hierarchy, level) = solve!(solution, hierarchy, ml, level)

"""
"""
abstract type AbstractCycle end

cycle!(solution, hierarchy,::AbstractCycle, ml) = error("Undefined cycle type")

dosolveinitial(ml, hierarchy, fine, finelevel) = doterminate(ml.solver, hierarchy, fine, finelevel) || !can_coarsen(hierarchy, finelevel)

"""
"""
solve!(solution, hierarchy, ml) = solve!(solution, hierarchy, ml, 1)
function solve!(solution, hierarchy, ml, level)
    solution = preprocessing!(solution, ml, hierarchy, level)
    solution = cycle!(solution, hierarchy, ml, level)
    solution = postprocessing!(solution, ml, hierarchy, level)
    return solution
end

function cycle!(solution, hierarchy, ml, level)
    for i in 1:solver.numcycle
        solution = precycle!(solution, hierarchy, ml.solver)
        solution = _cycle!(solution, hierarchy, ml.cycle, ml)
        solution = postcycle!(solution, hierarchy, ml.solver)
    end
    return solution
end 

