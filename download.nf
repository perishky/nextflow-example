process simulate {
    tag "Simulate dataset"

    input:
    val(fastqdir)
    val(genomedir)
    val(assembly)

    output:
    path("*.fastq"), emit: fastq 
    path("*.fa"), emit: assembly
    
    publishDir "${fastqdir}", pattern: "*.fastq", mode: 'copy'
    publishDir "${genomedir}", pattern: "*.fa", mode: 'copy'

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/simulate.r . "${assembly}.fa"
    """
}

workflow {
    simulate("${params.fastqdir}", "${params.genomedir}", "${params.assembly}")
}
