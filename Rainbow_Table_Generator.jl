using SHA, Random

# Define the hash function (e.g., SHA-256)
function hash_function(input::String)
    return bytes2hex(SHA.sha256(input))
end

# Define a reduction function
# This maps a hash back to a key in the keyspace
function reduction_function(hash::String, round::Int, keyspace::Vector{String})
    index = parse(Int, "0x" * hash[1:8]) + round
    return keyspace[(index % length(keyspace)) + 1]
end

# Generate the rainbow table
function generate_rainbow_table(n::Int, chain_length::Int, keyspace::Vector{String})
    rainbow_table = Dict{String, String}()
    
    for _ in 1:n
        # Start with a random plaintext from the keyspace
        start_key = rand(keyspace)
        current_key = start_key
        
        # Generate the chain
        for round in 1:chain_length
            hashed = hash_function(current_key)
            current_key = reduction_function(hashed, round, keyspace)
        end
        
        # Store only the start and end points
        rainbow_table[start_key] = current_key
    end
    
    return rainbow_table
end

# Keyspace and parameters
keyspace = [string(i) for i in 1:1000]  # Example keyspace (1 to 1000 as strings)
n = 100  # Number of chains
chain_length = 10  # Length of each chain

# Generate the rainbow table
rainbow_table = generate_rainbow_table(n, chain_length, keyspace)

# Print the table
println("Rainbow Table:")
for (start_key, end_key) in rainbow_table
    println("Start: $start_key -> End: $end_key")
end
