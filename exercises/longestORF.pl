use strict;
use warnings;
use Bio::SeqIO;
use Text::Wrap;

$Text::Wrap::columns = 61;
my @orf_files=<*.orf>;
foreach my $input_orf(@orf_files){
	my $in  = Bio::SeqIO->new(-file =>  $input_orf , '-format' => 'Fasta');
	my $longest_seq="";
	my $longest_id="";
	my $longest_desc="";
	while ( my $seq = $in->next_seq ){
               my $id=$seq->id();
               my $seq_str= uc ($seq->seq());
               if(length($seq_str) > length($longest_seq)){
		        $longest_id=$id;
		        $longest_desc=$seq->desc();
		        $longest_seq=$seq_str;
                }
        }
print  ">",$longest_id," ",$longest_desc,"\n",wrap('', '', $longest_seq),"\n";            
}
