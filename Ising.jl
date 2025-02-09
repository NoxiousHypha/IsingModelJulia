using StaticArrays
using Random

N = 5
spinMatrix = @MArray randn(N,N)
for j in 1:N
    for i in 1:N
        if spinMatrix[i,j] >= 0.5
            spinMatrix[i,j] = 1
        else
            spinMatrix[i,j] = -1
        end
    end
end

function timeStepIsing(M, b, F) #Spin Matrix M, b = (1/k_b T), F is free energy
    m,n = size(M) #Used to find bounds
    M_new = @MArray ones(m,n)
    for j in 1:n
        for i in 1:m
            up    = ifelse(i==1, 0, M[i,j]) #We consider the boundary to have no interaction, could change this to cyclic BC's
            down  = ifelse(i==m, 0, M[i,j])
            left  = ifelse(j==1, 0, M[i,j])
            right = ifelse(j==n, 0, M[i,j])
            H = up + down + left + right
            prob = (exp((F-H)/b)) #Proaba
            if (rand() < prob) 
                M_new[i,j] = -M[i,j]
            else
                M_new[i,j] = M[i,j]
            end
        end
    end
    M_new
end

spins = timeStepIsing(spinMatrix, 1, 5)




            
