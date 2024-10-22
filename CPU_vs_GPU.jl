<<<<<<< HEAD
# Import the required libraries
using CUDA  # For GPU computing
using LinearAlgebra  # For matrix multiplication
using Random  # For generating random numbers

# Function to compare matrix multiplication on CPU and GPU
function compare_cpu_gpu_multiplication(n)

    # Generate two random matrices of size n x n
    A_cpu = rand(Float32, n, n)
    B_cpu = rand(Float32, n, n)

    # --------------------------
    # CPU Multiplication
    # --------------------------
    println("CPU Multiplication:")
    @time C_cpu = A_cpu * B_cpu

    # --------------------------
    # GPU Multiplication
    # --------------------------
    println("GPU Multiplication:")

    # Transfer matrices to GPU
    A_gpu = CUDA.fill(A_cpu)  # Transfer matrix A to GPU
    B_gpu = CUDA.fill(B_cpu)  # Transfer matrix B to GPU

    # Ensure GPU is warmed up (for accurate timing)
    @cuda C_gpu = A_gpu * B_gpu

    # Perform matrix multiplication on GPU and measure time
    CUDA.synchronize()  # Synchronize to make sure GPU operations finish
    @time C_gpu = A_gpu * B_gpu

    # Transfer result back to CPU
    C_gpu = Array(C_gpu)

    # Optional: Compare CPU and GPU results for correctness
    if isapprox(C_cpu, C_gpu, rtol=1e-5)
        println("CPU and GPU results match!")
    else
        println("Warning: CPU and GPU results do not match.")
    end
end

# Set matrix size (e.g., 1024 x 1024 for testing)
matrix_size = 1024

# Call the function to compare CPU and GPU multiplication
compare_cpu_gpu_multiplication(matrix_size)
=======
# Import the required libraries
using CUDA  # For GPU computing
using LinearAlgebra  # For matrix multiplication
using Random  # For generating random numbers

# Function to compare matrix multiplication on CPU and GPU
function compare_cpu_gpu_multiplication(n)

    # Generate two random matrices of size n x n
    A_cpu = rand(Float32, n, n)
    B_cpu = rand(Float32, n, n)

    # --------------------------
    # CPU Multiplication
    # --------------------------
    println("CPU Multiplication:")
    @time C_cpu = A_cpu * B_cpu

    # --------------------------
    # GPU Multiplication
    # --------------------------
    println("GPU Multiplication:")

    # Transfer matrices to GPU
    A_gpu = CUDA.fill(A_cpu)  # Transfer matrix A to GPU
    B_gpu = CUDA.fill(B_cpu)  # Transfer matrix B to GPU

    # Ensure GPU is warmed up (for accurate timing)
    @cuda C_gpu = A_gpu * B_gpu

    # Perform matrix multiplication on GPU and measure time
    CUDA.synchronize()  # Synchronize to make sure GPU operations finish
    @time C_gpu = A_gpu * B_gpu

    # Transfer result back to CPU
    C_gpu = Array(C_gpu)

    # Optional: Compare CPU and GPU results for correctness
    if isapprox(C_cpu, C_gpu, rtol=1e-5)
        println("CPU and GPU results match!")
    else
        println("Warning: CPU and GPU results do not match.")
    end
end

# Set matrix size (e.g., 1024 x 1024 for testing)
matrix_size = 1024

# Call the function to compare CPU and GPU multiplication
compare_cpu_gpu_multiplication(matrix_size)
>>>>>>> 5e3990c52f835b7aef85f45d446cb92a9bf26f85
