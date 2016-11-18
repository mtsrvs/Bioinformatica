##!/usr/local/bin/perl -w

use strict;

use lib "/usr/lib/perl5/5.005/"; # or whatever your path is
use Bio::Seq;
use Bio::SeqIO;
use Bio::Tools::FindORF;

my $seqin = Bio::SeqIO->new( '-format' => 'Fasta' , -file => 'huntington.fas');

while((my $seqobj = $seqin->next_seq()))		# run through flat
file
{
	print "\n".$seqobj->display_id();		# each sequence in
turn
	my $ORF_obj = Bio::Tools::FindORF->new($seqobj);# make an ORF object
			
	my $array_ref = $ORF_obj->get_ORFs(2000);	# run the method
	
	my @array_of_arrays = @$array_ref;		# dereference the
output
	foreach(@array_of_arrays)
	{
		print "\n@$_";				# print results
	}
}

