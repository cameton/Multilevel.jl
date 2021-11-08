
abstract type AbstractMLSolver end

"""
...
"""
atbottomlevel(::AbstractMLSolver, hierarchy, level) = false

"""
...
"""
process_coarse!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
process_fine!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
process_uncoarse!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
coarsen_solution!(hierarchy, ::AbstractMLSolver, finelevel, coarselevel) = nothing

"""
...
"""
uncoarsen_solution!(hierarchy, ::AbstractMLSolver, finelevel, coarselevel) = nothing

"""
...
"""
process_initial!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
precycle!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
postcycle!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
preprocessing!(hierarchy, ::AbstractMLSolver, level) = nothing

"""
...
"""
postprocessing!(hierarchy, ::AbstractMLSolver, level) = nothing

