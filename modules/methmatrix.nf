process methmatrix {
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
    Rscript ${workflow.projectDir}/scripts/methmatrix.r ${files} matrix
    """
}
    
