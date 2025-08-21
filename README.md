# Variant-calling-pipeline
Bash workflow for calling variants with the aid of GATK best practises.

This involves two scripts, one for germline variants and the other for simple variant calling.

Make sure the following tools are already installed on your system:
fastqc (Quality check)
gatk4 (Variant calling)
bwa (Alignment)
samtools (File conversion)
sra toolkit (easy retrieval of sequences from SRA database in case you are not working on your own data)
