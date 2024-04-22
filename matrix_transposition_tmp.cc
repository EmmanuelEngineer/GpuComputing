#ifdef DTYPE_code
// Use the user-defined matrix type
#else
#define DTYPE_code 0
#endif

#ifdef BLOCK
#else
#define BLOCK 8
#endif

#if DTYPE_code == 0
#define DTYPE int
typedef int dtype;
#define DTYPE_spec "%d"
#define DTYPE_str "INT"
#elif DTYPE_code == 1
#define DTYPE float
typedef float dtype;
#define DTYPE_spec "%f"
#define DTYPE_str "FLOAT"
#elif DTYPE_code == 2
#define DTYPE double
typedef double dtype;
#define DTYPE_spec "%lf"
#define DTYPE_str "DOUBLE"
#endif

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>
#include <iostream>


void printMatrix(dtype **array, char *name, long double array_row, long double array_column)
{

    fprintf(stdout, "array %s \n", name);
    for (int i = 0; i < array_row; i++)
    {
        for (int j = 0; j < array_column; j++)
        {

            fprintf(stdout, DTYPE_spec ",", (*(*(array + i) + j)));
        }
        fprintf(stdout, "\n");
    }

    fprintf(stdout, "\n");
}

class Timer
{
public:
    Timer( )// Initialize shape in the constructor initializer list
    {
        start = std::chrono::high_resolution_clock::now();
    }

    ~Timer()
    {
        end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double, std::milli> ms_double = end - start;
        std::cout << ms_double.count() << std::endl;
    }

private:
    
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point end;
}; 

// Sommare accumulando per singolo elemento e poi a blocchi
int main(int argc, char **argv)
{
    int power;
    power = atoi(argv[1]);
    long double array_dim = powl((long double)2, (long double)power);

    dtype **A, **B;
    int data_dim = sizeof(DTYPE);

    fprintf(stdout, "dimension of matrices pow 2 at %d, %Lf total with type " DTYPE_str "\n", power, array_dim);
    A = (dtype**) malloc(array_dim * sizeof(dtype *));
    B =  (dtype**) malloc(array_dim * sizeof(dtype *));

    for (int x = 0; x < array_dim; x++)
    {
        A[x] = (dtype*)malloc(array_dim * data_dim);
        B[x] = (dtype*)malloc(array_dim * data_dim);
    }

    for (int i = 0; i < array_dim; i++)
    {
        for (int j = 0; j < array_dim; j++)
        {
            for (int h = 0; h < array_dim; h++)
            {
                (*(*(A + i) + h)) = rand() % 100;
            }
        }
    }

    clock_t t;

    int s_k, s_z,e_k,e_z;

        fprintf(stdout, "starting to elaborate\n");
        //t = clock();
        {Timer time;
        for (int i = 0; i < array_dim; i++)
        {

                for (int h = 0; h < array_dim; h++)
                    *(*(B + h) + i) = *(*(A + i) + h);
            }

}
        //t = clock() - t;
  
    double time_taken = ((double)t) / CLOCKS_PER_SEC;

    //fprintf(stdout, "Your calculations took %lf seconds to run.\n", time_taken);
    //printMatrix(A, "A", array_dim, array_dim);
    //printMatrix(B, "B", array_dim, array_dim);

    fprintf(stdout, "\n");

    for (int x = 0; x < array_dim; x++)
    {
        free(A[x]);
        free(B[x]);
    }

    free(A);
    free(B);
}
