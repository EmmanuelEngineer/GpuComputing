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
#SBATCH --reservation=gpu_computing

echo "building active";
#0 is integers, 1 is float, 2 is doubles
dtype=0
optimizer=0
make clean
make DTYPE=$dtype OPT=$optimizer
num=1
until [ $num -gt 5 ]; do
	time=1
    until [ $time -gt 3 ]; do
        #valgrind --tool=cachegrind --cache-sim=yes bin/runnable_$dtype $num >out_$num\_$time
        bin/runnable_$dtype $num >Homework_runs/no_optimization/int/out_$num\_$time\_$dtype\.txt
        time=$(($time+1))
    done
	num=$(($num+1))
done

