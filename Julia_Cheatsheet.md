# Julia Programming Cheat Sheet

## Basics

### Hello World
```julia
println("Hello, World!")
```

### Variables
```julia
x = 10         # Integer
y = 3.14       # Float
name = "Julia" # String
flag = true    # Boolean
```

### Comments
- Single-line comment: `# This is a comment`
- Multi-line comment: `#= This is a multi-line comment =#`

## Data Types

| Type      | Description                  |
|-----------|------------------------------|
| `Int`     | Integer                      |
| `Float64` | Floating-point number        |
| `Bool`    | Boolean (true/false)         |
| `Char`    | Character                    |
| `String`  | String                       |

### Type Checking
```julia
typeof(x) # Returns the type of x
```

### Type Conversion
```julia
x = Int(3.14)  # Convert to integer
```

## Control Flow

### If-Else
```julia
if x > 0
    println("Positive")
elseif x < 0
    println("Negative")
else
    println("Zero")
end
```

### Loops

#### For Loop
```julia
for i in 1:5
    println(i)
end
```

#### While Loop
```julia
while x > 0
    println(x)
    x -= 1
end
```

## Functions

### Function Definition
```julia
function add(a, b)
    return a + b
end

# One-liner
add(a, b) = a + b
```

### Anonymous Functions
```julia
f = x -> x^2
```

## Collections

### Arrays
```julia
arr = [1, 2, 3, 4]
arr[1] = 10  # Access and modify
push!(arr, 5) # Add an element
```

### Tuples
```julia
tup = (1, "Julia", true)
x, y, z = tup  # Destructuring
```

### Dictionaries
```julia
dict = Dict("a" => 1, "b" => 2)
dict["c"] = 3  # Add a new key-value pair
```

## Input/Output

### Read Input
```julia
name = readline()
```

### Print Output
```julia
println("Hello, $name")
```

## Modules and Packages

### Import Modules
```julia
using LinearAlgebra
```

### Install Packages
```julia
using Pkg
Pkg.add("Plots")
```

## Plotting Example
```julia
using Plots
x = 0:0.1:2π
y = sin.(x)
plot(x, y)
```

## Common Julia Commands

### Run a Script
```bash
$ julia script.jl
```

### REPL
- Start Julia REPL: `julia`
- Exit: `exit()`

### Package Management
```julia
using Pkg
Pkg.add("PackageName")
Pkg.update()
Pkg.remove("PackageName")
