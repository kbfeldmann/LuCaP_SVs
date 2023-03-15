#!/bin/bash
source /app/lmod/lmod/init/profile

# Load module for running SAMtools.
module load SAMtools/1.16.1-GCC-11.2.0

samtools coverage /fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$1.bam -o /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/$1_coverage.txt

# Unload module for running SAMtools.
module unload SAMtools/1.16.1-GCC-11.2.0

# Multiply the length of each chromosome by the mean coverage for that chromosome.
length_x_coverage=$(tail -n +2 /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/$1_coverage.txt | awk '{printf "%f\n", ($3 - $2 + 1) * $7}' | paste -sd+ - | bc)

# Calculate the sum of all lengths.
sum_of_lengths=$(tail -n +2 /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/$1_coverage.txt | awk '{print ($3 - $2 + 1)}' | paste -sd+ - | bc)

# Calculate the weighted mean.
mean_coverage=$(echo "scale=4; $length_x_coverage / $sum_of_lengths" | bc)

echo "Mean coverage across chromosomes is weighted by chromosome length." >> /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/$1_coverage.txt

echo "Mean Sample Coverage = $mean_coverage" >> /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/$1_coverage.txt
