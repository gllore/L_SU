 package wtcomp;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  WTCOMP - Compression by Wavelet Transform				
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 WTCOMP - Compression by Wavelet Transform				

   wtcomp < stdin n1= n2=   [optional parameter] > sdtout		

 Required Parameters:							
 n1=			number of samples in the fast (first) dimension	
 n2=			number of samples in the slow (second) dimension
 Optional Parameters:							
 nstage1=		number of stages (set automatically based on n1)
 nstage2=		number of stages (set automatically based on n2)
 nfilter=11		number of filters				
 error=0.01		acceptable error				



 Author: CWP: Tong Chen,   Dec 1995


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $wtcomp		= {
		_error					=> '',
		_n1					=> '',
		_n2					=> '',
		_nfilter					=> '',
		_nstage1					=> '',
		_nstage2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$wtcomp->{_Step}     = 'wtcomp'.$wtcomp->{_Step};
	return ( $wtcomp->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$wtcomp->{_note}     = 'wtcomp'.$wtcomp->{_note};
	return ( $wtcomp->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$wtcomp->{_error}			= '';
		$wtcomp->{_n1}			= '';
		$wtcomp->{_n2}			= '';
		$wtcomp->{_nfilter}			= '';
		$wtcomp->{_nstage1}			= '';
		$wtcomp->{_nstage2}			= '';
		$wtcomp->{_Step}			= '';
		$wtcomp->{_note}			= '';
 }


=head2 sub error 


=cut

 sub error {

	my ( $self,$error )		= @_;
	if ( $error ne $empty_string ) {

		$wtcomp->{_error}		= $error;
		$wtcomp->{_note}		= $wtcomp->{_note}.' error='.$wtcomp->{_error};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' error='.$wtcomp->{_error};

	} else { 
		print("wtcomp, error, missing error,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$wtcomp->{_n1}		= $n1;
		$wtcomp->{_note}		= $wtcomp->{_note}.' n1='.$wtcomp->{_n1};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' n1='.$wtcomp->{_n1};

	} else { 
		print("wtcomp, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$wtcomp->{_n2}		= $n2;
		$wtcomp->{_note}		= $wtcomp->{_note}.' n2='.$wtcomp->{_n2};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' n2='.$wtcomp->{_n2};

	} else { 
		print("wtcomp, n2, missing n2,\n");
	 }
 }


=head2 sub nfilter 


=cut

 sub nfilter {

	my ( $self,$nfilter )		= @_;
	if ( $nfilter ne $empty_string ) {

		$wtcomp->{_nfilter}		= $nfilter;
		$wtcomp->{_note}		= $wtcomp->{_note}.' nfilter='.$wtcomp->{_nfilter};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' nfilter='.$wtcomp->{_nfilter};

	} else { 
		print("wtcomp, nfilter, missing nfilter,\n");
	 }
 }


=head2 sub nstage1 


=cut

 sub nstage1 {

	my ( $self,$nstage1 )		= @_;
	if ( $nstage1 ne $empty_string ) {

		$wtcomp->{_nstage1}		= $nstage1;
		$wtcomp->{_note}		= $wtcomp->{_note}.' nstage1='.$wtcomp->{_nstage1};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' nstage1='.$wtcomp->{_nstage1};

	} else { 
		print("wtcomp, nstage1, missing nstage1,\n");
	 }
 }


=head2 sub nstage2 


=cut

 sub nstage2 {

	my ( $self,$nstage2 )		= @_;
	if ( $nstage2 ne $empty_string ) {

		$wtcomp->{_nstage2}		= $nstage2;
		$wtcomp->{_note}		= $wtcomp->{_note}.' nstage2='.$wtcomp->{_nstage2};
		$wtcomp->{_Step}		= $wtcomp->{_Step}.' nstage2='.$wtcomp->{_nstage2};

	} else { 
		print("wtcomp, nstage2, missing nstage2,\n");
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