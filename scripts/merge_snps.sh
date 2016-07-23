#!/bin/bash

module load plink/intel/1.90p
module load vcftools/intel/0.1.13

GENOME_NAME=$1

# Concatenate separate chromosomes and compress output
vcf-concat ${GENOME_NAME}_snps/chr[0-9]*.pass.snp.vcf | gzip -c > ${GENOME_NAME}.pass.snp.vcf.gz

# Convert VCF to plink PED
vcftools --gzvcf ${GENOME_NAME}.pass.snp.vcf.gz --plink --out ${GENOME_NAME}.pass.snp

# Edit the MAP file (${GENOME_NAME}.pass.snp.map) and get rid of the "chr"
# VCF uses, e.g., "chr10" whereas plink wants just "10"
sed -i -e 's/^chr//' ${GENOME_NAME}.pass.snp.map

# Create binary PED
plink --noweb --file ${GENOME_NAME}.pass.snp --make-bed --out ${GENOME_NAME}.pass.snp

# Now repeat the same steps for the X chromosome
vcftools --vcf ${GENOME_NAME}_snps/chrX.pass.snp.vcf --plink --out ${GENOME_NAME}.chrX.pass.snp
sed -i -e 's/^chr//' ${GENOME_NAME}.chrX.pass.snp.map
plink --noweb --file ${GENOME_NAME}.chrX.pass.snp --make-bed --out ${GENOME_NAME}.chrX.pass.snp

# Now make a SNP set with autosomes + X
vcf-concat ${GENOME_NAME}_snps/chr*.pass.snp.vcf | \
	vcftools --vcf - --plink --out ${GENOME_NAME}.withX.pass.snp
sed -i -e 's/^chr//' ${GENOME_NAME}.withX.pass.snp.map
plink --noweb --file ${GENOME_NAME}.withX.pass.snp --make-bed --out ${GENOME_NAME}.withX.pass.snp

exit