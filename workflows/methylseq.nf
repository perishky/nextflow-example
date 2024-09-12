include { trim_reads } from '../modules/trim_reads'
include { meth_counts } from '../modules/meth_counts'
include { meth_matrix } from '../modules/meth_matrix' 
include { meth_sum } from '../modules/meth_sum'

workflow methylseq {
    
    take:
    fastqdir
    assembly
    outdir
    
    main:
    read_pairs = Channel.fromFilePairs("${fastqdir}/*-R{1,2}.fastq", checkIfExists: true)
    trim_reads(read_pairs, outdir)
    meth_counts(trim_reads.out.reads, assembly, outdir)
    files_ch = meth_counts.out.counts
	.map{ it -> it[0] + "," + it[1].toString() }
	.collectFile(name: "files.csv", newLine: true)
    meth_matrix(files_ch, outdir)
    meth_sum(meth_matrix.out.meth, outdir)
    
    emit:
    meth = meth_matrix.out.meth
    total = meth_matrix.out.total
}

