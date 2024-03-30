
process methcounts {
    tag "Methylation counts"

    input:
    tuple val(sample_id), path(reads)
    val(assembly)
    val(outdir)

    output:
    tuple val(sample_id), path("counts/${sample_id}-*"), emit: counts

    publishDir "${outdir}"

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/methcounts.r ${sample_id} ${reads[0]} ${reads[1]} ${assembly} counts
    """
}
