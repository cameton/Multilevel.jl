
abstract type AbstractSolver end

"""
...
"""
doterminate(::AbstractSolver, hierarchy, solution, level) = false

"""
...
"""
process_coarse!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
process_fine!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
process_uncoarse!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
coarsen_solution!(solution, ::AbstractSolver, hierarchy, finelevel, coarselevel) = solution

"""
...
"""
uncoarsen_solution!(solution, ::AbstractSolver, hierarchy, finelevel, coarselevel) = solution

"""
...
"""
process_initial!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
precycle!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
postcycle!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
preprocessing!(solution, ::AbstractSolver, hierarchy, level) = solution

"""
...
"""
postprocessing!(solution, ::AbstractSolver, hierarchy, level) = solution

