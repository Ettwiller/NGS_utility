# NGS_utility


invert_R1_in_sam.pl :
This program reverse the R1 of a paired-end read. This program can be used upstream of bedtools multicov when counting a paired-end reads of a RNA-seq strand specific library. In this case the R1 and R2 will have both the same orientation. 

Alternatively, there is a oneline solution :
samtools view -h accepted_hits.bam | perl -ne 'if($_ !~/^\@/){ @tmp = split/\t/,$_; $flag = (split/\t/,$_)[1]; if($flag & 64){if ($flag & 16){$flag =$flag-16; $tmp[1]=$fl
ag; $line =join("\t", @tmp); print "$line"} else {$flag =$flag+16; $tmp[1]=$flag; $line =join("\t", @tmp); print "$line"}} else {print "$_"}} else {print "$_"}' > test.sam

Utility  : upstream of bedtools multicov in order to count the reads that overalp on the same (-s) or different strand (-S) compare to a feature. Useful for some RNA-seq application that require the counting of the mapped read using bedtools.  

