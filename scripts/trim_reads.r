#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

leftname <- args[1]
rightname <- args[2]
out.dir <- args[3]

dir.create(out.dir, recursive=T)

left <- readLines(leftname)
right <- readLines(rightname)

left <- sub("[AT]+[^AT]{1}", "", left)
right <- sub("[AT]+[^AT]{1}", "", right)

writeLines(left, con=file.path(out.dir, basename(leftname)))
writeLines(right, con=file.path(out.dir, basename(rightname)))

