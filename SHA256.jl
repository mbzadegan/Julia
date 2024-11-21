### Ensure that Julia is started with the required number of threads. 
### For example:
### JULIA_NUM_THREADS=4 julia sha256_parallel.jl


using SHA
using Base.Threads  # For multithreading

function calculate_sha256_parallel(filepath::String, chunk_size::Int = 1024*1024)
    # Open the file in binary mode
    open(filepath, "r") do io
        file_size = filesize(filepath)
        num_chunks = ceil(Int, file_size / chunk_size)

        # Read the file in chunks
        hashes = Vector{String}(undef, num_chunks)
        @threads for i in 1:num_chunks
            start_byte = (i - 1) * chunk_size + 1
            end_byte = min(i * chunk_size, file_size)

            seek(io, start_byte - 1)  # Move to the start of the chunk
            chunk = read(io, end_byte - start_byte + 1)
            hashes[i] = string(sha256(chunk))  # Compute SHA256 of the chunk
        end

        # Combine individual hashes to a single SHA256
        combined_hash = sha256(reduce(*, hashes))
        return string(combined_hash)
    end
end

# Input: Path to the file
println("Enter the file path:")
filepath = readline()

# Compute SHA256
try
    sha256_result = calculate_sha256_parallel(filepath)
    println("SHA256 hash of the file: $sha256_result")
catch e
    println("Error reading file: ", e)
end
