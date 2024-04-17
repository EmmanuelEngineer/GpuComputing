

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

void printMatrix(dtype **array, char *name, long double array_row, long double array_column)
{

    fprintf(stdout, "array %s", name);
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

// Sommare accumulando per singolo elemento e poi a blocchi
int main(int argc, char **argv)
{
    int power;
    power = atoi(argv[1]);
    long double array_dim = powl((long double)2, (long double)power);

    dtype **A, **B, **C;
    int data_dim = sizeof(DTYPE);

    fprintf(stdout, "dimension of matrices pow 2 at %d, %Lf total with type" DTYPE_str "\n", power, array_dim);
    A = malloc(array_dim * sizeof(void *));
    B = malloc(array_dim * sizeof(void *));
    C = malloc(array_dim * sizeof(void *));

    for (int x = 0; x < array_dim; x++)
    {
        A[x] = malloc(array_dim * data_dim);
        B[x] = malloc(array_dim * data_dim);
        C[x] = malloc(array_dim * data_dim);
    }

    for (int i = 0; i < array_dim; i++)
    {
        for (int j = 0; j < array_dim; j++)
        {
            for (int h = 0; h < array_dim; h++)
            {
                (*(*(A + i) + h)) = rand() % 100;
                (*(*(B + i) + h)) = rand() % 100;
            }
        }
    }

    clock_t t;
    int block = BLOCK;
    int s_k, s_z,e_k,e_z;
    if (block)
    {
        fprintf(stdout, "starting to elaborate\n");
        t = clock();
        for (int i = 0; i < array_dim; i++)
        {
            for (int j = 0; j < array_dim; j++)
            {
                // accumulo
                for (int h = 0; h < array_dim; h++)
                    *(*(C + i) + j) += (*(*(A + i) + h) * *(*(B + h) + j));
            }
        }
        t = clock() - t;
    }
    else
    {
        for (int i = 0; i < array_dim; i++)
        {
            for (int j = 0; j < array_dim; j++)
            {
                s_k = i * block;
                s_z = j * block;
                e_k = (i+1) * block;
                e_z = (j+1) * block;
                // accumulo
                for (int h = 0; h < array_dim; h++)
                    *(*(C + i) + j) += (*(*(A + i) + h) * *(*(B + h) + j));
            }
        }
    }
    double time_taken = ((double)t) / CLOCKS_PER_SEC;

    fprintf(stdout, "Your calculations took %lf seconds to run.\n", time_taken);
    /*printMatrix(A, "A", array_dim, array_dim);
    printMatrix(B, "B", array_dim, array_dim);
    printMatrix(C, "C", array_dim, array_dim);*/

    fprintf(stdout, "\n");

    for (int x = 0; x < array_dim; x++)
    {
        free(A[x]);
        free(B[x]);
        free(C[x]);
    }

    free(A);
    free(B);
    free(C);
}
