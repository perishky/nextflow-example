include { trimreads } from '../modules/trimreads'
include { methcounts } from '../modules/methcounts'
include { methmatrix } from '../modules/methmatrix' 

workflow methylseq {
    
    take:
    pattern
    assembly
    outdir
    
    main:
    read_pairs_ch = Channel.fromFilePairs(pattern, checkIfExists: true)
    trimreads(read_pairs_ch, outdir)
    methcounts(trimreads.out.reads, assembly, outdir)
    files_ch = methcounts.out.counts
	.map{ it -> it[0] + "," + it[1].toString() }
	.collectFile(name: "files.csv", newLine: true)
    methmatrix(files_ch, outdir)
    
    emit:
    meth = methmatrix.out.meth
    total = methmatrix.out.total
}

