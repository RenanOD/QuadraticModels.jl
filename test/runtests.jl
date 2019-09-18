using Test, QuadraticModels, SparseArrays, NLPModels, NLPModelsIpopt, LinearOperators

@testset "qpsreader" begin
	c0 = 0.0
	c = [1.5; -2.0]
	Q = sparse([1; 2; 2], [1; 1; 2], [8.0; 2.0; 10.0])
	A = sparse([1; 2; 1; 2], [1; 1; 2; 2], [2.0; -1.0; 1.0; 2.0])
	lcon = [2.0; -Inf]
	ucon = [Inf; 6.0]
	uvar = [20; Inf]
	lvar = [0.0; 0.0]

	qp = QuadraticModel(c, Q, opHermitian(Q), A, lcon, ucon, lvar, uvar, c0=c0)
	output = ipopt(qp, print_level=0)

	@test output.dual_feas < 1e-6
	@test output.primal_feas < 1e-6
	@test norm(output.objective - objectives[k]) < 1e-6

end # testset
