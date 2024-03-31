#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

data.dir <- args[1]
assembly.file <- args[2]

dir.create(data.dir, recursive=T)

set.seed(20240328)

seq <- readLines(assembly.file)

cpos <- gregexpr('C',seq)[[1]]
gpos <- gregexpr('G',seq)[[1]]

for (i in 1:6) {
    seqs <- sapply(1:20, function(i) {
        seq <- strsplit(seq, "")[[1]]
        idx <- sample(cpos, floor(length(cpos)*0.8))
        seq[idx] <- 'T'
        idx <- sample(gpos, floor(length(gpos)*0.8))
        seq[idx] <- 'A'
        paste(seq, collapse="")
    })
    left <- substring(seqs, first=1, last=nchar(seq)/2)
    right <- substring(seqs, first=nchar(seq)/2+1, last=nchar(seq))
    left <- paste("ATATATATC", left, sep="")
    right <- paste("ATATATATC", right, sep="")
    
    writeLines(left, con=file.path(data.dir, paste0('sample-',i,"-R1.fastq")))
    writeLines(right, con=file.path(data.dir, paste0('sample-',i,"-R2.fastq")))
}
