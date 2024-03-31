process simulate_reads {
    tag "Simulate reads"

    input:
    path(fasta)
    val(fastqdir)

    output:
    path("*.fastq"), emit: fastq
    
    publishDir "${fastqdir}", mode: 'copy'

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/simulate_reads.r . ${fasta}
    """
}

process simulate_genome {
    tag "Simulate genome"

    input:
    val(assembly)
    val(genomedir)

    output:
    path("*.fa"), emit: fasta
    
    publishDir "${genomedir}", pattern: "*.fa", mode: 'copy'

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/simulate_genome.r ${assembly}.fa
    """
}


workflow simulate_dataset {
    take:
    fastqdir
    assembly

    main:
    simulate_genome(assembly, fastqdir)
    simulate_reads(simulate_genome.out.fasta, fastqdir)

    emit:
    fastq = simulate_reads.out.fastq
    genome = simulate_genome.out.fasta
}


workflow {
    simulate_dataset("${params.fastqdir}", "${params.assembly}")
}
