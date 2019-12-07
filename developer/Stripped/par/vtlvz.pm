 package vtlvz;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  VTLVZ -- Velocity as function of Time for Linear V(Z);		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 VTLVZ -- Velocity as function of Time for Linear V(Z);		
          writes out a vector of velocity = v0 exp(a t/2)		

 vtlvz > velfile nt= dt= v0= a= 					

 Required parameters							
 nt=	number of time samples						
 dt=	time sampling interval						
 v0=	velocity at the surface						
 a=	velocity gradient						

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $vtlvz		= {
		_a					=> '',
		_dt					=> '',
		_nt					=> '',
		_v0					=> '',
		_velocity					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$vtlvz->{_Step}     = 'vtlvz'.$vtlvz->{_Step};
	return ( $vtlvz->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$vtlvz->{_note}     = 'vtlvz'.$vtlvz->{_note};
	return ( $vtlvz->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$vtlvz->{_a}			= '';
		$vtlvz->{_dt}			= '';
		$vtlvz->{_nt}			= '';
		$vtlvz->{_v0}			= '';
		$vtlvz->{_velocity}			= '';
		$vtlvz->{_Step}			= '';
		$vtlvz->{_note}			= '';
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$vtlvz->{_a}		= $a;
		$vtlvz->{_note}		= $vtlvz->{_note}.' a='.$vtlvz->{_a};
		$vtlvz->{_Step}		= $vtlvz->{_Step}.' a='.$vtlvz->{_a};

	} else { 
		print("vtlvz, a, missing a,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$vtlvz->{_dt}		= $dt;
		$vtlvz->{_note}		= $vtlvz->{_note}.' dt='.$vtlvz->{_dt};
		$vtlvz->{_Step}		= $vtlvz->{_Step}.' dt='.$vtlvz->{_dt};

	} else { 
		print("vtlvz, dt, missing dt,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$vtlvz->{_nt}		= $nt;
		$vtlvz->{_note}		= $vtlvz->{_note}.' nt='.$vtlvz->{_nt};
		$vtlvz->{_Step}		= $vtlvz->{_Step}.' nt='.$vtlvz->{_nt};

	} else { 
		print("vtlvz, nt, missing nt,\n");
	 }
 }


=head2 sub v0 


=cut

 sub v0 {

	my ( $self,$v0 )		= @_;
	if ( $v0 ne $empty_string ) {

		$vtlvz->{_v0}		= $v0;
		$vtlvz->{_note}		= $vtlvz->{_note}.' v0='.$vtlvz->{_v0};
		$vtlvz->{_Step}		= $vtlvz->{_Step}.' v0='.$vtlvz->{_v0};

	} else { 
		print("vtlvz, v0, missing v0,\n");
	 }
 }


=head2 sub velocity 


=cut

 sub velocity {

	my ( $self,$velocity )		= @_;
	if ( $velocity ne $empty_string ) {

		$vtlvz->{_velocity}		= $velocity;
		$vtlvz->{_note}		= $vtlvz->{_note}.' velocity='.$vtlvz->{_velocity};
		$vtlvz->{_Step}		= $vtlvz->{_Step}.' velocity='.$vtlvz->{_velocity};

	} else { 
		print("vtlvz, velocity, missing velocity,\n");
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