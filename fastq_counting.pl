#!/usr/bin/perl
use strict;
use Getopt::Long qw(GetOptions);



my $file;
my $CUTOFF; # 

my $usage_sentence = "perl $0 --fastq fastq_file --cutoff 10";


GetOptions ("file=s" => \$file,    # numeric
	        "cutoff=s" => \$CUTOFF
    ) or die $usage_sentence;

if (!$file || !$CUTOFF) {die $usage_sentence;}

local $/ = "+";


open (DATA, $file) or die;
my %result;
my $total = 0;
while (my $line = <DATA>){
  
    my @tmp = split /\n/, $line;
    my $quality = $tmp[1];
    my $seq = $tmp[3];
 
    $total ++;
    $result{$seq}++;
   
}
my $i=1;
foreach my $seq (sort {$result{$b}<=>$result{$a}} keys %result)
{
#    my $RCseq = reverse_complement($seq);
    my $count = $result{$seq};
    my $fraction = ($count /$total) * 100;
    my $id = "count_".$i."_occurence_".$count."_percentage_of_total_read_".$fraction;
   if ($fraction >= $CUTOFF)
   {
       print ">$id\n$seq\n";
   }
    $i++;
}


sub reverse_complement {
    my $dna = shift;

    # reverse the DNA sequence
    my $revcomp = reverse($dna);

    # complement the reversed DNA sequence
    $revcomp =~ tr/ACGTacgt/TGCAtgca/;
    return $revcomp;
}
