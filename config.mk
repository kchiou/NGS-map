# -------------------------------------------------------------------------------------- #
# --- Configuration makefile of user-editable variables 
# -------------------------------------------------------------------------------------- #

# All paths must be absolute or relative to the NGS-map top directory

# -------------------------------------------------------------------------------------- #
# --- Paths to input files
# -------------------------------------------------------------------------------------- #

# Individual ID (used to name files)
IND_ID=Kafue

# Paths to input reads files
# Must be in FASTQ format and end in '.fastq'
# or in gzip'd FASTQ format and end in '.fastq.gz'
# FastQC will not name the output file properly if ending is '.fq'
READ1=./data/${IND_ID}.read1.fastq
READ2=./data/${IND_ID}.read2.fastq
READ_SE=./data/${IND_ID}_SE.fastq

# Paired-end or single-end analysis?
# Must be either PE or SE
READ_TYPE=PE

# Paths to genomes files
# Must be in FASTA format
GENOME_FA=genomes/papAnu2/papAnu2.fa

# Figure out genome code from path to genome FASTA
GENOME_CODE=$(notdir $(basename $(GENOME_FA)))

# Common name of genome (used to name files)
GENOME_NAME=baboon

# Should results be uploaded to AWS S3? TRUE or FALSE
DO_S3_UPLOAD=FALSE

# AWS S3 bucket name for project - location to upload results
# - Unique name, 3 to 63 characters
# - One or more labels, separated by periods
# - Can contain lowercase letters, numbers, and hyphens
# - Labels must start and end with a lowercase letter or a number.
S3_PROJECT_BUCKET_NAME=pretend-project-results-bucket-name

# -------------------------------------------------------------------------------------- #
# --- Paths to external programs
# -------------------------------------------------------------------------------------- #

FASTQC=${HOME}/downloads/fastqc-0.11.5/
FASTX=${HOME}/downloads/fastx-0.0.13/
BWA=${HOME}/downloads/bwa-0.7.13/
SAMTOOLS=${HOME}/downloads/samtools-1.3.1/
BEDTOOLS=${HOME}/downloads/bedtools-2.25.0/bin/
LIFTOVER=${HOME}/downloads/kent-20160510/
PICARD=${HOME}/downloads/picard-tools-1.119/
BAMTOOLS=/share/apps/bamtools/2.3.0/intel/bin/
GATK=${HOME}/downloads/gatk-3.5/
BCFTOOLS=${HOME}/downloads/bcftools-1.3.1/
VCFTOOLS=${HOME}/downloads/vcftools-0.1.14/bin/
TABIX=${HOME}/downloads/htslib-develop/bin/
PLINK=${HOME}/downloads/plink-1.07/

# -------------------------------------------------------------------------------------- #
# --- Parameters for external programs
# -------------------------------------------------------------------------------------- #

# BWA parameters
BWA_ALN_PARAM=-t 8
# SAMtools mpileup parameters
SNP_MIN_COV=5
SNP_MAX_COV=100
# BAMtools filter parameters
MAPQUAL=0
# Should we mark duplicates? TRUE or FALSE
MARK_DUPS=FALSE
# Max number of file handles to keep open when Picard's MarkDuplicates writes to disk.
# This should be a bit lower than the per-process max number of files that can be open.
# You can find that max using command 'ulimit -n'
# This avoids the "java.io.FileNotFoundException: (Too many open files)" exception
PICARD_MARK_DUP_MAX_FILES=4000

# -------------------------------------------------------------------------------------- #
# --- Parameters for multi-sample SNP calling
# -------------------------------------------------------------------------------------- #

