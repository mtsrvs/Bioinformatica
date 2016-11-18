#!/usr/bin/perl -w
#http://emboss.sourceforge.net/apps/cvs/emboss/apps/index.html
use strict;
use Bio::SeqIO;
use Bio::Factory::EMBOSS;

#perl ./e4.pl huntington.gb result.modif
my ($infile, $outfile) = @ARGV;

my $factory = Bio::Factory::EMBOSS->new();

#Aplicacion getorf: Find and extract open reading frames (ORFs)
my $ORF = $factory->program('getorf');
$ORF->run({-sequence => $infile, -outseq => 'tmp.orf', -minsize => 600});

my $patmatmotifs = $factory->program('patmatmotifs');
$patmatmotifs->run({-sequence => 'tmp.orf', -outfile => $outfile});

