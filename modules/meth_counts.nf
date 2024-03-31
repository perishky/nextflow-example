
process meth_counts {
    tag "Methylation counts"

    input:
    tuple val(sampleid), path(reads)
    val(assembly)
    val(outdir)

    output:
    tuple val(sampleid), path("counts/${sampleid}-counts.csv"), emit: counts

    publishDir "${outdir}"

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/meth_counts.r ${sampleid} ${reads[0]} ${reads[1]} ${assembly} counts
    """
}
