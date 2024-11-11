using Random  # For random number generation
using LinearAlgebra  # For matrix operations like inversion

# Set the number of threads to the maximum available
Threads.nthreads()  # Check the number of available threads

function threaded_matrix_inverse(n::Int)
    # Generate a random n x n matrix
    A = rand(n, n)
    
    # Calculate the inverse using all available CPU threads
    # Matrix inversion in Julia with `inv` is already multi-threaded,
    # so we simply call it here.
    try
        A_inv = Threads.@threads inv(A)  # Compute the inverse
        return A_inv
    catch e
        println("Matrix is singular and cannot be inverted.")
        return nothing
    end
end

# Example usage: Invert a 1000x1000 random matrix
n = 1000
result = threaded_matrix_inverse(n)
println("Inverse matrix computed for size $n x $n")
