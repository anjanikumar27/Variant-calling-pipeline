# Download and unzip reference genome
    wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
    gunzip human_g1k_v37.fasta.gz

# Extract chromosome of interest with the aid of samtools and index
    samtools faidx human_g1k_v37.fasta 22 > chr22.fa
    bwa index chr22.fa
    samtools faidx chr22.fa

# Utilising sra toolkit, download fastq files for analysis
    fastq-dump --split-files ERR184650

# Align reads to reference genome
    bwa mem -t 4 chr22.fa ERR184650_1.fastq.gz ERR184650_2.fastq.gz > aligned.sam
    
# Convert the aligned reads to bam format and then sort and index
    samtools view -Sb aligned.sam > aligned.bam
    samtools sort -@ 4 aligned.bam -o aligned.sorted.bam
    samtools index aligned.sorted.bam

# Now finally, proceed with variant filtering
    bcftools mpileup -a AD,DP,SP -Ou -f chr22.fa aligned.sorted.bam | bcftools call -mv -Ov -o variants.vcf

# Filter the variants using custom filters
    bcftools view -i 'QUAL>30 & DP>10 & AF<0.05' variants.vcf -Ov -o filtered_variants.vcf

#Generate Statistics
    bcftools stats filtered_variants.vcf > vcf.stats
