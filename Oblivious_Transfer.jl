# Function to XOR encrypt/decrypt a string
function xor_encrypt(msg::String, key::Int)
    encrypted = [Char(Int(c) ⊻ key) for c in msg]
    return join(encrypted)
end

# Sender's messages
M0 = "Secret Message 0"
M1 = "Secret Message 1"

# Generate a random encryption key
using Random
key = rand(1:255)  # Random integer key between 1 and 255

# Encrypt messages using XOR encryption
Enc_M0 = xor_encrypt(M0, key)
Enc_M1 = xor_encrypt(M1, key)

# Receiver chooses which message to retrieve (0 for M0, 1 for M1)
println("Enter your choice (0 or 1):")
choice = parse(Int, readline())

# Receiver's key for decryption
key_receiver = choice == 0 ? key : key + 1  # If the choice is 1, simulate an incorrect key

# Decrypt the chosen message
Received_Message = choice == 0 ? xor_encrypt(Enc_M0, key_receiver) : xor_encrypt(Enc_M1, key_receiver)

# Output results
println("----- Oblivious Transfer Results -----")
println("Sender's Messages: M0 = $M0, M1 = $M1")
println("Encrypted Messages: Enc_M0 = $Enc_M0, Enc_M1 = $Enc_M1")
println("Receiver's Choice: $choice")
println("Receiver's Retrieved Message: $Received_Message")
