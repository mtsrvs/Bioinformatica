#!/usr/local/bin/perl
#Remote-blast "factory object" creation and blast-parameter initialization
#tomado de: http://search.cpan.org/dist/BioPerl/Bio/Tools/Run/RemoteBlast.pm#submit_blast

#Al ingresar a http://www.ncbi.nlm.nih.gov/blast/Blast.cgi retorna un mensaje de error 403 Forbidden.
#Por lo tanto se ingreso otra url en $factory


#Ejecucion
#perl exercise_two.pl huntington.fas blast.out
use Bio::Tools::Run::RemoteBlast;
use Bio::Tools::Run::StandAloneBlastPlus;
use Bio::Perl;
use Bio::Seq;
use Bio::SeqIO;

my ($infile, $outfile) = @ARGV;

$factory = Bio::Tools::Run::StandAloneBlastPlus->new(
		-db_name => '/home/matias/Desktop/ncbi-blast-2.5.0+/data/swissprot',
		-prog_dir => '/home/matias/Desktop/ncbi-blast-2.5.0+/bin'	
);
$result = $factory->blastp(-query => $infile, 
			-outfile => $outfile, 
			-method_args => [ '-evalue' => 0.01 ]
	);

