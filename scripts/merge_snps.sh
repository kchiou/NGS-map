#!/bin/bash

VCFTOOLS=${HOME}/downloads/vcftools-0.1.14/bin/
GENOME_NAME=$1

${VCFTOOLS}/vcf-concat ${GENOME_NAME}_snps/chr[0-9]*.pass.snp.vcf | gzip -c > ${GENOME_NAME}.pass.snp.vcf.gz
