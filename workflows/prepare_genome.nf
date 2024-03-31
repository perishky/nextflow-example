process retrieve_genome {
    tag "Copy genome"

    input:
    val(fastqdir)
    val(assembly)
    val(genomedir)

    output:
    path("*.fa"), emit: fasta
    
    publishDir "${genomedir}", pattern: "*.fa", mode: 'copy'

    shell:
    """
    cp ${fastqdir}/${assembly}.fa .
    """
}


workflow prepare_genome {
    take:
    fastqdir
    assembly
    genomedir

    main:
    retrieve_genome(fastqdir, assembly, genomedir)

    emit:
    retrieve_genome.out.fasta
}











