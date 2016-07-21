#!/bin/bash

VCFTOOLS=${HOME}/downloads/vcftools-0.1.14/bin/
PLINK=${HOME}/downloads/plink-1.07/
GENOME_NAME=$1

# Concatenate separate chromosomes and compress output
${VCFTOOLS}/vcf-concat ${GENOME_NAME}_snps/chr[0-9]*.pass.snp.vcf | gzip -c > ${GENOME_NAME}.pass.snp.vcf.gz

# Convert VCF to plink PED
${VCFTOOLS}/vcftools --gzvcf ${GENOME_NAME}.pass.snp.vcf.gz --plink --out ${GENOME_NAME}.pass.snp;

# Edit the MAP file (${GENOME_NAME}.pass.snp.map) and get rid of the "chr"
# VCF uses, e.g., "chr10" whereas plink wants just "10"
sed -i -e 's/^chr//' ${GENOME_NAME}.pass.snp.map

# Create binary PED
${PLINK}/plink --noweb --file ${GENOME_NAME}.pass.snp --make-bed --out ${GENOME_NAME}.pass.snp

# Now repeat the same steps for the X chromosome
${VCFTOOLS}/vcftools --vcf ${GENOME_NAME}_snps/chrX.pass.snp.vcf --plink --out ${GENOME_NAME}.chrX.pass.snp;
sed -i -e 's/^chr//' ${GENOME_NAME}.chrX.pass.snp.map
${PLINK}/plink --noweb --file ${GENOME_NAME}.chrX.pass.snp --make-bed --out ${GENOME_NAME}.chrX.pass.snp

# Now make a SNP set with autosomes + X
${VCFTOOLS}/vcf-concat ${GENOME_NAME}_snps/chr*.pass.snp.vcf | \
	${VCFTOOLS}/vcftools --vcf - --plink --out ${GENOME_NAME}.withX.pass.snp;
sed -i -e 's/^chr//' ${GENOME_NAME}.withX.pass.snp.map
${PLINK}/plink --noweb --file ${GENOME_NAME}.withX.pass.snp --make-bed --out ${GENOME_NAME}.withX.pass.snp


exit