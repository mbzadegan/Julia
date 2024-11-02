using Random
using LinearAlgebra
using BenchmarkTools  # For accurate timing

# Set the number of random numbers
n = 1000

# Generate n random numbers between 0 and 1000
arr = rand(1:1000, n)

# Bubble Sort Function
function bubble_sort(arr)
    a = copy(arr)
    for i in 1:length(a)-1
        for j in 1:length(a)-i
            if a[j] > a[j+1]
                a[j], a[j+1] = a[j+1], a[j]  # Swap elements
            end
        end
    end
    return a
end

# Insertion Sort Function
function insertion_sort(arr)
    a = copy(arr)
    for i in 2:length(a)
        key = a[i]
        j = i - 1
        while j > 0 && a[j] > key
            a[j+1] = a[j]
            j -= 1
        end
        a[j+1] = key
    end
    return a
end

# Quick Sort Function
function quick_sort(arr)
    a = copy(arr)
    quick_sort!(a, 1, length(a))
    return a
end

# Helper function for Quick Sort
function quick_sort!(a, low, high)
    if low < high
        p = partition!(a, low, high)
        quick_sort!(a, low, p - 1)
        quick_sort!(a, p + 1, high)
    end
end

function partition!(a, low, high)
    pivot = a[high]
    i = low - 1
    for j in low:high-1
        if a[j] <= pivot
            i += 1
            a[i], a[j] = a[j], a[i]
        end
    end
    a[i + 1], a[high] = a[high], a[i + 1]
    return i + 1
end

# Measure and compare processing times
println("Sorting $n random numbers:")

@btime bubble_sort(arr)
@btime insertion_sort(arr)
@btime quick_sort(arr)
@btime sort(arr)  # Built-in Quick Sort for comparison
