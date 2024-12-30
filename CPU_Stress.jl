using Base.Threads

# Get the number of available threads
num_threads = nthreads()

println("Starting CPU stress test on $num_threads threads...")

# Function to perform intensive computation
function stress_test()
    x = 0.0
    while true
        x += sin(rand()) * cos(rand())
        if isnan(x)
            x = 0.0 # Reset if NaN occurs
        end
    end
end

# Launch stress test on all threads
Threads.@threads for i in 1:num_threads
    stress_test()
end

# Keep the main thread alive
time_limit = 60  # Duration to keep the stress test running in seconds
println("Stress test running for $time_limit seconds...")
sleep(time_limit)
println("Stress test completed.")