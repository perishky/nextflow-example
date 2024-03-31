process trim_reads {
    tag "Trim reads"

    input:
    tuple val(sampleid), path(reads)
    val(outdir)

    output:
    tuple val(sampleid), path("trimmed/${sampleid}-*.fastq"), emit: reads

    publishDir "${outdir}"

    shell:
    """ 
    Rscript ${workflow.projectDir}/scripts/trim_reads.r ${reads[0]} ${reads[1]} trimmed
    """
}
