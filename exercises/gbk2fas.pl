#!/usr/local/bin/perl
#http://bioperl.org/howtos/SeqIO_HOWTO
use Bio::Perl;
use Bio::SeqIO;

#Ejecucion
#perl ./exercise_one.pl huntington.gb
my ($infile, $outfile) = @ARGV;
$infileformat = 'Genbank'; 
$outfileformat = 'Fasta';

#Archivos de entrada y salida
$inputFile = Bio::SeqIO->new(-file => "$infile", -format => $infileformat);
$frame1File = Bio::SeqIO->new(-file => ">$outfile", -format => $outfileformat);

#Conversion a formato Fasta
my $seq = $inputFile->next_seq();

$frame1File->write_seq($seq);
print "output.fas, longitud=". $seq->length. "\n";
