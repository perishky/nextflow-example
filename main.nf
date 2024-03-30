#!/usr/bin/env nextflow

/*
 * Toy methyl-seq pipeline
 * nextflow run main.nf -c main.config -resume
 */

include { methylseq } from './workflows/methylseq'

workflow {
    pattern = "${params.fastqdir}/*R{1,2}.fastq"
    assembly = "${params.genomedir}/${params.assembly}.fa"
    methylseq (pattern, assembly, "${params.outdir}") 
}
