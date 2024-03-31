process meth_matrix {
    tag "Methylation matrix"

    input:
    path(files)
    val(outdir)

    output:
    path("matrix/meth.csv"), emit: meth
    path("matrix/total.csv"), emit: total

    publishDir "${outdir}"

    shell:
    """
    Rscript ${workflow.projectDir}/scripts/meth_matrix.r ${files} matrix
    """
}
    
