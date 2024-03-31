#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

sampleid <- args[1]
left <- args[2]
right <- args[3]
assembly <- args[4]
out.dir <- args[5]

dir.create(out.dir, recursive=T)

seq <- readLines(assembly)
cpos <- gregexpr('C',seq)[[1]]

reads <- paste(
    readLines(left),
    readLines(right),
    sep="")
reads <- do.call(rbind, strsplit(reads,""))
reads <- reads[,cpos]

counts <- data.frame(
    site=cpos,
    meth=apply(reads,2,function(site) sum(site!="C")),
    total=nrow(reads))

write.csv(counts, file=file.path(out.dir, paste0(sampleid, "-counts.csv")), row.names=F)
