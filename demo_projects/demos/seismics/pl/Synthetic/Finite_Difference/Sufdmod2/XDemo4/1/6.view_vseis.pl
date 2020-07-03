=head2 SYNOPSIS

PACKAGE NAME: 

AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut


	use Moose;
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
	use Project_config;

	my $Project		= new Project_config();
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use misc::message;
	use misc::flow;
	use sunix::data::data_in;
	use sunix::shapeNcut::suwind;
	use sunix::plot::suxwigb;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suwind				= new suwind();
	my $suxwigb				= new suxwigb();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suwind);
	my (@suxwigb);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('vseis'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	suwind parameter values

=cut

 	 $suwind 	 	 	 	 ->clear();
 	 $suwind 	 	 	 	 ->j(quotemeta(3));
 	 $suwind [1]  	 	 	 = $suwind ->Step();

=head2 Set up

	suxwigb parameter values

=cut

 	 $suxwigb 	 	 	 	 ->clear();
 	 $suxwigb 	 	 	 	 ->absclip(quotemeta(1));
 	 $suxwigb 	 	 	 	 ->box_width(quotemeta(450));
 	 $suxwigb 	 	 	 	 ->box_height(quotemeta(450));
 	 $suxwigb 	 	 	 	 ->box_X0(quotemeta(20));
 	 $suxwigb 	 	 	 	 ->box_Y0(quotemeta(50));
 	 $suxwigb 	 	 	 	 ->orientation(quotemeta('seismic'));
 	 $suxwigb 	 	 	 	 ->title(quotemeta('Vertical line of seismograms'));
 	 $suxwigb 	 	 	 	 ->windowtitle(quotemeta('Vertical'));
 	 $suxwigb 	 	 	 	 ->xlabel(quotemeta('Depth (km)'));
 	 $suxwigb 	 	 	 	 ->ylabel(quotemeta('Time (sec)'));
 	 $suxwigb [1]  	 	 	 = $suxwigb ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suwind[1], $in,
		  $data_in[1], $to,
		  $suxwigb[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);


=head2 RUN FLOW(s) 


=cut

	$run->flow(\$flow[1]);



=head2 LOG FLOW(s)

	to screen and FILE

=cut

	print $flow[1];

	$log->file($flow[1]);


