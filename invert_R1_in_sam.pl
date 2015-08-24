#!/usr/bin/perl
use strict;
use Getopt::Long qw(GetOptions);


#this program reverse the R1 of a paired-end read. This program can be used upstream of bedtools multicov when counting a paired-end reads of a RNA-seq strand specific library. In this case the R1 and R2 will have both the same orientation. 


#alterinatively the oneliner is : 
#samtools view -h accepted_hits.bam | perl -ne 'if($_ !~/^\@/){ @tmp = split/\t/,$_; $flag = (split/\t/,$_)[1]; if($flag & 64){if ($flag & 16){$flag =$flag-16; $tmp[1]=$flag; $line =join("\t", @tmp); print "$line"} else {$flag =$flag+16; $tmp[1]=$flag; $line =join("\t", @tmp); print "$line"}} else {print "$_"}} else {print "$_"}' > test.sam
my $sam;


my $usage_sentence = "perl $0 --sam samfile.sam\nthis program reverse the R1 of a paired-end read. This program can be used upstream of bedtools multicov when counting a paired-end reads of a RNA-seq strand specific library. In this case the R1 and R2 will have both the same orientation";

GetOptions ("sam=s" => \$sam,    # numeric
	       
    ) or die $usage_sentence;

if (!$sam) {die $usage_sentence;}





open (SAM, $sam) or die " can't open the sam file $sam\n";
foreach my $line (<SAM>)
{
    if ($line !~ /^\@/) #not a header line. 
    {
	chomp $line;
	my @tmp = split /\t/, $line;
	my $flag = $tmp[1];
	if ($flag & 64) #first in pair reads
	{
	    if ($flag & 16)#negative strand
	    {
		$flag = $flag -16;
	    }
	    else {
		$flag = $flag + 16;
	    }
	    $tmp[1] =$flag;
	    my $new_line = join("\t", @tmp);
	    print "$new_line\n";
	}
	else {
	    print "$line\n";
	}
    }
    else {
	print "$line";
    }
}
close SAM;

