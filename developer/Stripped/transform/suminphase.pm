 package suminphase;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUMINPHASE - convert input to minimum phase				
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUMINPHASE - convert input to minimum phase				

 suminphase <stdin >stdout [optional parameters]	 		

 Required parameters:					 		
	if dt is not set in header, then dt is mandatory		

 Optional parameters:							
	sign1=1		sign of first transform	(1 or -1)		
	sign2=-1	sign of second transform (-1 or 1)		
    	pnoise=1.e-9	   white noise in spectral routine		
	verbose=0		=1 for advisory messages		


 Credits:
      SEAM Project: Bruce VerWest c. 2013
 
 Trace header fields accessed: ns, dt, d1

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suminphase		= {
		_pnoise					=> '',
		_sign1					=> '',
		_sign2					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suminphase->{_Step}     = 'suminphase'.$suminphase->{_Step};
	return ( $suminphase->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suminphase->{_note}     = 'suminphase'.$suminphase->{_note};
	return ( $suminphase->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suminphase->{_pnoise}			= '';
		$suminphase->{_sign1}			= '';
		$suminphase->{_sign2}			= '';
		$suminphase->{_verbose}			= '';
		$suminphase->{_Step}			= '';
		$suminphase->{_note}			= '';
 }


=head2 sub pnoise 


=cut

 sub pnoise {

	my ( $self,$pnoise )		= @_;
	if ( $pnoise ne $empty_string ) {

		$suminphase->{_pnoise}		= $pnoise;
		$suminphase->{_note}		= $suminphase->{_note}.' pnoise='.$suminphase->{_pnoise};
		$suminphase->{_Step}		= $suminphase->{_Step}.' pnoise='.$suminphase->{_pnoise};

	} else { 
		print("suminphase, pnoise, missing pnoise,\n");
	 }
 }


=head2 sub sign1 


=cut

 sub sign1 {

	my ( $self,$sign1 )		= @_;
	if ( $sign1 ne $empty_string ) {

		$suminphase->{_sign1}		= $sign1;
		$suminphase->{_note}		= $suminphase->{_note}.' sign1='.$suminphase->{_sign1};
		$suminphase->{_Step}		= $suminphase->{_Step}.' sign1='.$suminphase->{_sign1};

	} else { 
		print("suminphase, sign1, missing sign1,\n");
	 }
 }


=head2 sub sign2 


=cut

 sub sign2 {

	my ( $self,$sign2 )		= @_;
	if ( $sign2 ne $empty_string ) {

		$suminphase->{_sign2}		= $sign2;
		$suminphase->{_note}		= $suminphase->{_note}.' sign2='.$suminphase->{_sign2};
		$suminphase->{_Step}		= $suminphase->{_Step}.' sign2='.$suminphase->{_sign2};

	} else { 
		print("suminphase, sign2, missing sign2,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suminphase->{_verbose}		= $verbose;
		$suminphase->{_note}		= $suminphase->{_note}.' verbose='.$suminphase->{_verbose};
		$suminphase->{_Step}		= $suminphase->{_Step}.' verbose='.$suminphase->{_verbose};

	} else { 
		print("suminphase, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 