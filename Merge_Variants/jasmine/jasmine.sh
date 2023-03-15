#!/bin/bash

# Print the options needed to run Jasmine.
echo "Below are the parameters needed to run Jasmine for merging VCF files."
echo "-t   Name of TUMOR sample."
echo "-c   Number of cores."
echo "-r   Name of FASTA file for the reference genome."

# Options are saved as variables for running Jasmine.
while getopts ":t:c:r:" opt; do
        case "$opt" in
		t) SAMPLE=$OPTARG ;;

                c) CORES="$OPTARG" ;;

		r) REF="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Reference_Genomes/$OPTARG.fasta" ;;
        esac
done

#FLIST="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Merge_Variants/jasmine/${SAMPLE}.txt"
#FLIST="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Merge_Variants/jasmine/${SAMPLE}_germline.txt"
FLIST="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Merge_Variants/jasmine/${SAMPLE}_non_germline.txt"
BLIST="/fh/fast/ha_g/user/kfeldman/2023/LuCaP_SVs/Merge_Variants/jasmine/${SAMPLE}_bam_list.txt"
#DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/jasmine/${SAMPLE}"
#DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/jasmine/${SAMPLE}_germline"
DIR="/fh/scratch/delete90/ha_g/users/kfeldman/LuCaP_SVs/jasmine/${SAMPLE}_non_germline"
OUTPUT="$DIR/${SAMPLE}_merged.vcf"

jasmine file_list=$FLIST bam_list=$BLIST genome_file=$REF out_dir=$DIR out_file=$OUTPUT min_support=1 threads=$CORES --dups_to_ins --run_iris --normalize_type
