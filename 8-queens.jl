function is_safe(board, row, col)
    # Check for queens in the same column and diagonals
    for i in 1:row-1
        if board[i] == col || abs(board[i] - col) == row - i
            return false
        end
    end
    return true
end

function solve_n_queens(board, row, n, solutions)
    if row > n
        # Save the current solution
        push!(solutions, copy(board))
    else
        for col in 1:n
            if is_safe(board, row, col)
                board[row] = col
                solve_n_queens(board, row + 1, n, solutions)
                board[row] = 0 # Backtrack
            end
        end
    end
end

function n_queens(n)
    board = zeros(Int, n)  # Array to store queen positions
    solutions = []         # List to store all solutions
    solve_n_queens(board, 1, n, solutions)
    return solutions
end

function print_board(board)
    n = length(board)
    for row in 1:n
        for col in 1:n
            if board[row] == col
                print(" Q ")
            else
                print(" . ")
            end
        end
        println()
    end
    println()
end

# Solve the 8-Queens problem
n = 8
solutions = n_queens(n)

# Display all solutions
println("Number of solutions: ", length(solutions))
for solution in solutions
    print_board(solution)
end
