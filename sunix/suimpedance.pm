 package suimpedance;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUIMPEDANCE - Convert reflection coefficients to impedances.  
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUIMPEDANCE - Convert reflection coefficients to impedances.  

 suimpedance <stdin >stdout [optional parameters]		

 Optional Parameters:					  	
 v0=1500.	Velocity at first sample (m/sec)		
 rho0=1.0e6	Density at first sample  (g/m^3)		

 Notes:							
 Implements recursion [1-R(k)]Z(k) = [1+R(k)]Z(k-1).		
 The input traces are assumed to be reflectivities, and thus are
 expected to have amplitude values between -1.0 and 1.0.	


 Credits:
	SEP: Stew Levin

 Trace header fields accessed: ns
 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suimpedance		= {
		_rho0					=> '',
		_v0					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suimpedance->{_Step}     = 'suimpedance'.$suimpedance->{_Step};
	return ( $suimpedance->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suimpedance->{_note}     = 'suimpedance'.$suimpedance->{_note};
	return ( $suimpedance->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suimpedance->{_rho0}			= '';
		$suimpedance->{_v0}			= '';
		$suimpedance->{_Step}			= '';
		$suimpedance->{_note}			= '';
 }


=head2 sub rho0 


=cut

 sub rho0 {

	my ( $self,$rho0 )		= @_;
	if ( $rho0 ne $empty_string ) {

		$suimpedance->{_rho0}		= $rho0;
		$suimpedance->{_note}		= $suimpedance->{_note}.' rho0='.$suimpedance->{_rho0};
		$suimpedance->{_Step}		= $suimpedance->{_Step}.' rho0='.$suimpedance->{_rho0};

	} else { 
		print("suimpedance, rho0, missing rho0,\n");
	 }
 }


=head2 sub v0 


=cut

 sub v0 {

	my ( $self,$v0 )		= @_;
	if ( $v0 ne $empty_string ) {

		$suimpedance->{_v0}		= $v0;
		$suimpedance->{_note}		= $suimpedance->{_note}.' v0='.$suimpedance->{_v0};
		$suimpedance->{_Step}		= $suimpedance->{_Step}.' v0='.$suimpedance->{_v0};

	} else { 
		print("suimpedance, v0, missing v0,\n");
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