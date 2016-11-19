#!/usr/local/bin/perl
use Bio::Tools::Run::Alignment::Clustalw;
use Bio::Perl;
use Bio::Seq;
use Bio::SeqIO;

#  Build a clustalw alignment factory
@params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
$factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
 
#  Pass the factory a list of sequences to be aligned.        
$inputfilename = '../msa/msa.fas';
$aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.

#foreach $seq ( $aln->each_seq() ) {
#  print $seq->length, "\n";
#  print $seq->num_residues, "\n";
#  print $seq->is_flush, "\n";
#  print $seq->num_sequences, "\n";
#  print $seq->score, "\n";
#  print $seq->percentage_identity, "\n";
#  print $seq->consensus_string(50), "\n";
	

	#print "ID: ", $seq->id(), "\n";
	#print "ACCESSION_NUMBER: ", $seq->accession_number(), "\n";
	#print "match_line: ", $seq->match_line(), "\n";
	#print "--------------- \n";
#}

#$aln = $aln->next_aln();
# or
#$seq_array_ref = \@seq_array;
# where @seq_array is an array of Bio::Seq objects
#$aln = $factory->align($seq_array_ref);
 
# Or one can pass the factory a pair of (sub)alignments
#to be aligned against each other, e.g.:
#$aln = $factory->profile_align($aln1,$aln2);
# where $aln1 and $aln2 are Bio::SimpleAlign objects.
 
# Or one can pass the factory an alignment and one or more unaligned
# sequences to be added to the alignment. For example:        
#$aln = $factory->profile_align($aln1,$seq); # $seq is a Bio::Seq object.

#  print $aln->length, "\n";
#  print $aln->num_residues, "\n";
#  print $aln->is_flush, "\n";
#  print $aln->num_sequences, "\n";
#  print $aln->score, "\n";
#  print $aln->percentage_identity, "\n";
#  print $aln->consensus_string(50), "\n";
 
# Get a tree of the sequences
#$tree = $factory->tree(\@seq_array);
 
# Get both an alignment and a tree
#($aln, $tree) = $factory->run(\@seq_array);
 
# Do a footprinting analysis on the supplied sequences, getting back the
# most conserved sub-alignments
#my @results = $factory->footprint(\@seq_array);
foreach my $result (@results) {
  print $result->consensus_string, "\n";
}
 
# There are various additional options and input formats available.
# See the DESCRIPTION section that follows for additional details.
