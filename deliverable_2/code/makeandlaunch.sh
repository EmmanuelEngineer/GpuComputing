#!/bin/bash
#SBATCH --partition=edu5
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --job-name=test
#SBATCH --output=test-%j.out
#SBATCH --error=test-%j.err

echo "building active";
########################################
#Set of changeble parameters for the testing
#Will be always executed a run with a block access pattern and a run with a linear access pattern and a cachegrind run for both
#and alway with 3 data types: integers, floats and doubles
number_of_iterations=3 #number of times a setting is tested
starting_optimizations=0 # For testing only some of the optimizations(for example if you want to test only -O2 and -O3, must be setted to 2)
maximum_power=5 # Maximum n for matrices 2^n*2^n
block_dimension=8
minimum_power=1 # Minimum n for matrices 2^n*2^n 
#######################################
mkdir "deliverable_runs"

module load cuda/12.1



up_to=$maximum_power;num_iterations=$number_of_iterations;opt_num=$starting_optimizations;
until [ $opt_num -gt 3 ]; do
    dtype=0
    #0 is integers, 1 is float, 2 is double
    until [ $dtype -gt 2 ]; do
        make clean
        make DTYPE=$dtype OPT_NUM=$opt_num BLOCK=$block_dimension
        num=$minimum_power
        until [ $num -gt $up_to ]; do
            time=1
            until [ $time -gt $num_iterations ]; do
            echo "$num\_$time\_$dtype\_$opt_num"
                srun bin/runnable_$dtype $num &>"deliverable_runs/$num-$time-$dtype-$opt_num.txt"
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done