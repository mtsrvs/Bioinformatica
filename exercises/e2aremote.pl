#!/usr/local/bin/perl
#Remote-blast "factory object" creation and blast-parameter initialization
#tomado de: http://search.cpan.org/dist/BioPerl/Bio/Tools/Run/RemoteBlast.pm#submit_blast

#Al ingresar a http://www.ncbi.nlm.nih.gov/blast/Blast.cgi retorna un mensaje de error 403 Forbidden.
#Por lo tanto se ingreso otra url en $factory


#Ejecucion
#perl exercise_two.pl huntington.fas blast.out
use Bio::Tools::Run::RemoteBlast;
use Bio::Perl;
use Bio::Seq;
use Bio::SeqIO;
use strict;


my ($infile, $outfile) = @ARGV;
my $prog = 'blastp';
my $db   = 'swissprot';
my $e_val= '0.01';
my @params = ( '-prog' => $prog, '-data' => $db, '-expect' => $e_val, '-readmethod' => 'SearchIO' );
my $factory = Bio::Tools::Run::RemoteBlast->new(@params);

#$v is just to turn on and off the messages
my $v = 1;

#optional: send BLAST request to a cloud service provider instead of NCBI
$factory->set_url_base("https://blast.ncbi.nlm.nih.gov/Blast.cgi");
#$factory->set_url_base("https://www.ncbi.nlm.nih.gov/blast/Blast.cgi");
my $r = $factory->submit_blast($infile);
print STDERR "espere..." if( $v > 0 );
while ( my @rids = $factory->each_rid ) {
	foreach my $rid ( @rids ) {
		my $rc = $factory->retrieve_blast($rid);
      		if( !ref($rc) ) {
        		if( $rc < 0 ) {
          			$factory->remove_rid($rid);
        		}
        		print STDERR "." if ( $v > 0 );
        		sleep 5;
      		} else {
      	  		my $result = $rc->next_result();       
			$factory->save_output($outfile);
        		$factory->remove_rid($rid);
        		print "\nQuery Name: ", $result->query_name(), "\n";
        		while ( my $hit = $result->next_hit ) {
          			next unless ( $v > 0);
          			print "\thit name is ", $hit->name, "\n";
          			while( my $hsp = $hit->next_hsp ) {
            				print "\t\tscore is ", $hsp->score, "\n";
          			}
        		}
      		}
    	}
}

