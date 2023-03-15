#!/bin/bash

# Print the options needed to run SVDSS.
echo "Below are the parameters needed to run SVDSS with long-read sequencing data."
echo "-t   Name of BAM file for tumor cells."
echo "-c   Number of cores."
echo "-r   Name of FASTA file for the reference genome."


# Options are saved as variables for running SVDSS. 
while getopts ":t:c:r:" opt; do
        case "$opt" in
                t) NAME=$OPTARG ;;

		c) CORES="$OPTARG" ;;

                r) REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$OPTARG" ;;
        esac
done

TUMOR="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Bams/$NAME.bam"
DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/svdss/$NAME"

# Modified from SVDSS github: https://raw.githubusercontent.com/Parsoa/SVDSS/master/tests/run-svdss.sh
echo "################"
echo "### INDEXING ###"
echo "################"
SVDSS index --fastq $REF.fasta --index $REF.bwt

echo "#################"
echo "### SMOOTHING ###"
echo "#################"
SVDSS smooth --reference $REF.fasta --bam $TUMOR --workdir $DIR --threads $CORES
samtools sort -T {output.bam}.sort-tmp $DIR/smoothed.selective.bam > $DIR/smoothed.selective.sorted.bam
samtools index $DIR/smoothed.selective.sorted.bam

echo "#################"
echo "### SEARCHING ###"
echo "#################"
SVDSS search --index $REF.bwt --bam $DIR/smoothed.selective.sorted.bam --threads $CORES --workdir $DIR --assemble

echo "###############"
echo "### CALLING ###"
echo "###############"
N=$(ls $DIR/solution_batch_*.assembled.sfs | wc -l)
SVDSS call --reference $REF.fasta --bam $DIR/smoothed.selective.sorted.bam --threads $CORES --workdir $DIR --batches $N
bcftools sort $DIR/svs_poa.vcf > $DIR/SVDSS.vcf
