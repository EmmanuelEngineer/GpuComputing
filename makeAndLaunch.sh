#!/bin/bash
echo "building active";
########################################
#Set of changeble parameters for the testing
#Will be always executed a run with a block access pattern  and a run with a linear access pattern 
number_of_iterations=3 #number of times a setting is tested
starting_optimizations=0 # For testing only some of the optimizations(for example if you want to test only -O2 and -O3)
maximum_power=5 # Maximum n for matrices of 2^n*2^n
block_dimension=8
minimum_power=1 # Minimum n for matrices of 2^n*2^n 
#######################################
mkdir "Homework_runs"
mkdir "Homework_runs_block"
mkdir "cache_runs"
mkdir "cache_runs_block"



up_to=$maximum_power;num_iterations=$number_of_iterations;opt_num=$starting_optimizations;
until [ $opt_num -gt 3 ]; do
    dtype=0
    #0 is integers, 1 is float, 2 is double
    until [ $dtype -gt 2 ]; do
        make clean
        make DTYPE=$dtype OPT_NUM=$opt_num BLOCK=0
        num=$minimum_power
        until [ $num -gt $up_to ]; do
            time=1
            until [ $time -gt $num_iterations ]; do
            echo "$num\_$time\_$dtype\_$opt_num"
                bin/runnable_$dtype $num >Homework_runs/out_$num\_$time\_$dtype\_$opt_num\.txt
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done



up_to=$maximum_power;num_iterations=$number_of_iterations;opt_num=$starting_optimizations;
until [ $opt_num -gt 3 ]; do
    dtype=0
    #0 is integers, 1 is float, 2 is double
    until [ $dtype -gt 2 ]; do
        make clean
        make debug DTYPE=$dtype OPT_NUM=$opt_num BLOCK=0
        num=$minimum_power
        until [ $num -gt $up_to ]; do
            time=1
            until [ $time -gt $num_iterations ]; do
            echo "$num\_$time\_$dtype\_$opt_num"
                valgrind --tool=cachegrind --cache-sim=yes --cachegrind-out-file=.cache bin/runnable_$dtype $num &>"cache_runs/cache_$num-$time-$dtype-$opt_num.txt"
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done

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
                valgrind --tool=cachegrind --cache-sim=yes --cachegrind-out-file=.cache bin/runnable_$dtype $num &>"cache_runs_block/cache_$num-$time-$dtype-$opt_num.txt"
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done

up_to=$maximum_power;num_iterations=$number_of_iterations;opt_num=$starting_optimizations;
until [ $opt_num -gt 3 ]; do
    dtype=0
    #0 is integers, 1 is float, 2 is double
    until [ $dtype -gt 2 ]; do
        make clean
        make debug DTYPE=$dtype OPT_NUM=$opt_num BLOCK=$block_dimension
        num=$minimum_power
        until [ $num -gt $up_to ]; do
            time=1
            until [ $time -gt $num_iterations ]; do
            echo "$num\_$time\_$dtype\_$opt_num"
                valgrind --tool=cachegrind --cache-sim=yes --cachegrind-out-file=.cache bin/runnable_$dtype $num &>"cache_runs_block/cache_$num-$time-$dtype-$opt_num.txt"
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done

