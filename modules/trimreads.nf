process trimreads {
    tag "Trim reads"

    input:
    tuple val(sample_id), path(reads)
    val(outdir)

    output:
    tuple val(sample_id), path("trimmed/${sample_id}-*.fastq"), emit: reads

    publishDir "${outdir}"

    shell:
    """ 
    Rscript ${workflow.projectDir}/scripts/trimreads.r ${reads[0]} ${reads[1]} trimmed
    """
}
