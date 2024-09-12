process meth_sum {
	tag "Summarize methylation matrix"

	input:
	path(file)
	val(outdir)

	output:
	path("matrix/sum.csv"), emit: sum

	publishDir "${outdir}"

	shell:
	"""
	Rscript ${workflow.projectDir}/scripts/meth_sum.r ${file} matrix/sum.csv
	"""
}