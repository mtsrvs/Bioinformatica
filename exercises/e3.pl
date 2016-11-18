#!/usr/bin/perl; 
use Bio::Perl;
use Bio::SearchIO;
use Data::Dumper; 


# This script will analize a BLAST report in search for hits thorugh a given pattern. 
# For those matching patterns it will revert the hit into its original FASTA sequence.
# Input: A blast report (.out from ex2), a search pattern, a destination path
# Note: a pattern can be any word or regex
# Output: A list of hits matching the given pattern (trough STDIO)
# Usage (from root folder): perl src/Ex3.pm output/2/blast-1F.out medium-wave-sensitive output/3/matchingFasta.out
sub getHits {
	my ($blastPath,$pattern, $outPath)= @_;
	$blastSearchObj = new Bio::SearchIO ('-format' => 'blast', '-file'   => $blastPath); 

 	while ( my $currentResult = $blastSearchObj->next_result){
 		print "=== Database info =====\n";
 		print $currentResult->database_name;
 		print "=== Algorithm info =====\n";
 		print $currentResult->algorithm;
 		while ( my $hit = $currentResult->next_hit ){
 			my $hsp = $hit->next_hsp;
			if (defined($hsp)){
				$hsp->query->start;
			}
 			if(index($hit->description, $pattern) != -1){
 				#printKeys($hit,$hsp);
 				writeFastaSequence($hit->accession, $outPath);
 			}
    		
    	}
    	
    }
}

# Prints detailed information about a specific hit
# Input: a hit , an hsp
# Output: STDOUT description.
sub printKeys{
	my ($hit,$hsp) = @_;
	print "=== HIT info =====\n";
	while ( (my $khit, my $vhit) = each %{$hit}) { 
 		 print "$khit => $vhit \n"; 
	}
	print "=== HSP info =====\n";
	while ( (my $khit,my $vhit) = each %{$hsp}) {
		if ($khit eq "_evalue") {   
			 print "$khit => $vhit \n";
		}  
	}
}

# Writes fasta sequence from a given accession.
# Input: an accession, a destination path.
# Output: a fasta sequence.
sub writeFastaSequence {
	my ($accession,$outPath) = @_;
	my $gb = Bio::DB::GenBank->new(-retrievaltype => 'tempfile', -format => 'Fasta');
	my $seq_in = $gb->get_Stream_by_acc($accession);
	my $seq_out = Bio::SeqIO->new('-file' => ">>$outPath",'-format' => 'Fasta');
	# write each entry in the input file to the output file 
	while (my $inseq = $seq_in->next_seq) {
			$seq_out->write_seq($inseq);
	}
}

getHits($ARGV[0],$ARGV[1],$ARGV[2]);
