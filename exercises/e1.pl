#!/usr/local/bin/perl
#http://bioperl.org/howtos/SeqIO_HOWTO
use Bio::Perl;
use Bio::SeqIO;

#Ejecucion
#perl ./exercise_one.pl huntington.gb
my ($infile) = @ARGV;
$infileformat = 'Genbank'; 
$outfileformat = 'Fasta';

#Archivos de entrada y salida
$inputFile = Bio::SeqIO->new(-file => "$infile", -format => $infileformat);
$frame1File = Bio::SeqIO->new(-file => ">f1.fas", -format => $outfileformat);
$frame2File = Bio::SeqIO->new(-file => ">f2.fas", -format => $outfileformat);
$frame3File = Bio::SeqIO->new(-file => ">f3.fas", -format => $outfileformat);
$frame4File = Bio::SeqIO->new(-file => ">r1.fas", -format => $outfileformat);
$frame5File = Bio::SeqIO->new(-file => ">r2.fas", -format => $outfileformat);
$frame6File = Bio::SeqIO->new(-file => ">r3.fas", -format => $outfileformat);

#Conversion a formato Fasta
my $seq = $inputFile->next_seq();

$frame1File->write_seq($seq->translate());
print "open reading frame +1, longitud=". $seq->length. "\n";

$prot_obj = $seq->translate(-frame => 1);
$frame2File->write_seq($prot_obj);
print "open reading frame +2, longitud=". $prot_obj->length. "\n";

$prot_obj = $seq->translate(-frame => 2);
$frame3File->write_seq($prot_obj);
print "open reading frame +3, longitud=". $prot_obj->length. "\n";

$reverse_complement = $seq->revcom; 	
$frame4File->write_seq($reverse_complement->translate());	
print "open reading frame -1, longitud=". $reverse_complement->length. "\n";

$prot_obj = $reverse_complement->translate(-frame => 1);
$frame5File->write_seq($prot_obj);
print "open reading frame -2, longitud=". $prot_obj->length. "\n";
	
$prot_obj = $reverse_complement->translate(-frame => 2);
$frame6File->write_seq($prot_obj);
print "open reading frame -3, longitud=". $prot_obj->length. "\n";	
