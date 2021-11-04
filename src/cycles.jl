abstract type AbstractMultilevelSolver end

struct InitialSolver
    solver::Function
end

struct MultilevelSolver
    refinement
    cycle::Cycle
    numcycle::Int
    initial::AbstractMultilevelSolver
end

struct VCycle end
struct WCycle end
struct FCycle end

const Cycle = Union{VCycle,WCycle,FCycle}

function optimize!(solver::InitialSolver, solution, hierarchy)
    return solver.solver(solution, hierarchy)
end

function optimize!(solver::MultilevelSolver, solution, hierarchy)
    return optimize!(solver, solution, hierarchy; cycle=solver.cycle)
end

function optimize!(solver, solution, hierarchy; cycle::VCycle)
    
end
