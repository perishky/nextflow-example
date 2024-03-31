#!/usr/bin/env nextflow

/*
 * Toy methyl-seq pipeline
 */

include { prepare_genome } from './workflows/prepare_genome'
include { methylseq } from './workflows/methylseq'

workflow {
    prepare_genome("${params.fastqdir}", "${params.assembly}", "${params.genomedir}")
    index = prepare_genome.out
    methylseq("${params.fastqdir}", index, "${params.outdir}") 
}
