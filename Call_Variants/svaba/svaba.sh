#!/bin/bash
source /app/lmod/lmod/init/profile

# Print the options needed to run SvABA.
echo "Below are the parameters needed to run SvABA with short-read sequencing data."
echo "-t   Name of BAM file for tumor cells."
echo "-n   Name of BAM file for normal cells."
echo "-c   Number of cores."
echo "-r   Name of FASTA file for the reference genome."

# Options are saved as variables for running SvABA.
while getopts ":t:n:c:r:" opt; do
        case "$opt" in
                t) NAME=$OPTARG ;;

		n) NORMAL="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$OPTARG.bam" ;;

		c) CORES="$OPTARG" ;;

		r) SYM_REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$OPTARG.fasta" ;;
        esac
done

TUMOR="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$NAME.bam"
REF=$(realpath "$SYM_REF")

# Load module for running SvABA.
module load svaba/4d7b571-GCC-10.2.0

# Command to run SvABA using the human reference genome (REF), a BAM file from normal cells (NORMAL) and a BAM file from tumor cells (TUMOR).
svaba run -t $TUMOR -n $NORMAL -p $CORES -a $NAME -G $REF

# Unload module for running SvABA.
module unload svaba/4d7b571-GCC-10.2.0

# Move files to scratch to save space on fast.
mkdir /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/svaba/$NAME/
mv /fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Call_Variants/svaba/$NAME.* /fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/svaba/$NAME/
