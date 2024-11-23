using SHA
using Threads

# Function to calculate the SHA-256 hash of a binary chunk
function hash_chunk(chunk::Vector{UInt8})
    return sha256(chunk)
end

# Function to calculate the SHA-256 hash of a binary file in parallel
function calculate_sha256_parallel(file_path::String, chunk_size::Int = 1024 * 1024)
    # Open the file for reading
    file = open(file_path, "r")
    chunks = Vector{Vector{UInt8}}()
    
    # Read the file in chunks
    while !eof(file)
        push!(chunks, read(file, chunk_size))
    end
    close(file)

    # Get number of threads
    n_threads = nthreads()

    # Parallelize chunk hashing
    chunk_hashes = Vector{Vector{UInt8}}(undef, length(chunks))
    @threads for i in 1:length(chunks)
        chunk_hashes[i] = hash_chunk(chunks[i])
    end

    # Combine chunk hashes into a final hash
    final_hash = reduce((h1, h2) -> sha256(vcat(h1, h2)), chunk_hashes)
    return final_hash
end

# Convert the hash to a hexadecimal string
function hash_to_hex(hash::Vector{UInt8})
    return join(string.(hash, base=16, pad=2))
end

# Example Usage
function main()
    println("Enter the binary file path:")
    file_path = readline()
    
    if isfile(file_path)
        println("Calculating SHA-256 hash in parallel...")
        hash_result = calculate_sha256_parallel(file_path)
        println("SHA-256 Hash:")
        println(hash_to_hex(hash_result))
    else
        println("File does not exist!")
    end
end

main()
