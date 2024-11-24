using Random
using LinearAlgebra

# Function to generate Shamir's Secret Shares
function generate_shares(secret, num_shares, threshold, prime)
    coeffs = [secret; rand(1:prime-1, threshold - 1)] # Polynomial coefficients
    shares = [(x, mod(sum(c * x^(i-1) for (i, c) in enumerate(coeffs)), prime)) for x in 1:num_shares]
    return shares
end

# Function to reconstruct the secret from shares
function reconstruct_secret(shares, prime)
    secret = 0
    for (xj, yj) in shares
        lj = prod((0 - xi) * invmod(xj - xi, prime) for (xi, _) in shares if xi != xj)
        secret = mod(secret + yj * lj, prime)
    end
    return secret
end

# Modular inverse function
function invmod(a, prime)
    return mod(invmod_helper(a, prime), prime)
end

function invmod_helper(a, prime)
    if gcd(a, prime) != 1
        error("Inverse does not exist")
    else
        return mod(a^(prime-2), prime) # Using Fermat's Little Theorem
    end
end

# Simulate an MPC protocol for summing private inputs
function mpc_sum(parties, threshold, prime)
    num_parties = length(parties)

    # Each party generates shares of their secret input
    all_shares = [generate_shares(secret, num_parties, threshold, prime) for secret in parties]

    # Each party receives shares from all other parties
    shared_shares = [map(i -> all_shares[i][j][2], 1:num_parties) for j in 1:num_parties]

    # Each party locally computes the sum of the shares they received
    local_sums = map(sum, shared_shares)

    # Reconstruction of the sum of secrets using shares
    reconstructed_sum = reconstruct_secret([(i, local_sums[i]) for i in 1:threshold], prime)
    return reconstructed_sum
end

# Example usage
prime = 97              # A prime number larger than any secret
threshold = 3           # Minimum number of parties needed to reconstruct the secret
parties = [15, 22, 10]  # Secret inputs of parties

result = mpc_sum(parties, threshold, prime)
println("Sum of secrets: ", result)
