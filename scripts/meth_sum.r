#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

meth.filename <- args[1]
output.filename <- args[2]

dir.create(dirname(output.filename), recursive=T, showWarnings=F)

meth <- read.csv(meth.filename,row.names=1)
meth.sum <- data.frame(
    mean=apply(meth,1,mean),
    median=apply(meth,1,median),
    sd=apply(meth,1,sd),
    iqr=apply(meth,1,function(x) quantile(x,probs=0.75)-quantile(x,probs=0.25)))

write.csv(meth.sum, file=output.filename)
