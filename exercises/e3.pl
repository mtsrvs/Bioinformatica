#!/usr/bin/perl; 
use Bio::Perl;
use Bio::SearchIO;
use Data::Dumper; 

my ($blastPath,$pattern, $outPath)= @ARGV;
$blastSearchObj = new Bio::SearchIO ('-format' => 'blast', '-file'   => $blastPath); 

while ( my $currentResult = $blastSearchObj->next_result){
	print ">>Database info\n";
	print $currentResult->database_name;
	print ">>Algorithm info\n";
	print $currentResult->algorithm;
	while ( my $hit = $currentResult->next_hit ){
		my $hsp = $hit->next_hsp;
		if (defined($hsp)){
			$hsp->query->start;
		}
		#print "DESCRIPCION: ", $hit->description, "\n";
		if(index($hit->description, $pattern) != -1){
			print ">>hit section\n";
			while ( (my $khit, my $vhit) = each %{$hit}) { 
		 		 print "$khit => $vhit \n"; 
			}
			print ">>hit section\n";
			while ( (my $khit,my $vhit) = each %{$hsp}) {
				if ($khit eq "_evalue") { 
					 print "$khit => $vhit \n";
				}  
			}

			my $accession = $hit->accession;
			my $gb = Bio::DB::GenBank->new(-retrievaltype => 'tempfile', -format => 'Fasta');
			my $seq_in = $gb->get_Stream_by_acc($accession);
			my $seq_out = Bio::SeqIO->new('-file' => ">>$outPath",'-format' => 'Fasta');

			while (my $inseq = $seq_in->next_seq) { 
				$seq_out->write_seq($inseq); 
			}
		}
	
	}

}
