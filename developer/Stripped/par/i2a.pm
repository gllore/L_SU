 package i2a;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  I2A - convert binary integers to ascii				
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 I2A - convert binary integers to ascii				

 i2a <stdin >stdout 						

 Required parameters:						
 	none							

 Optional parameters:						
 	n1=2		floats per line in output file 		

 	outpar=/dev/tty	output parameter file, contains the	
			number of lines (n=)			


 Credits:
 Potash Corporation: c. 2008, Balazs Nemeth,  Saskatoon, Saskatchewan.
   based on b2a.c by:  CWP: Jack K. Cohen

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $i2a		= {
		_n					=> '',
		_n1					=> '',
		_outpar					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$i2a->{_Step}     = 'i2a'.$i2a->{_Step};
	return ( $i2a->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$i2a->{_note}     = 'i2a'.$i2a->{_note};
	return ( $i2a->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$i2a->{_n}			= '';
		$i2a->{_n1}			= '';
		$i2a->{_outpar}			= '';
		$i2a->{_Step}			= '';
		$i2a->{_note}			= '';
 }


=head2 sub n 


=cut

 sub n {

	my ( $self,$n )		= @_;
	if ( $n ne $empty_string ) {

		$i2a->{_n}		= $n;
		$i2a->{_note}		= $i2a->{_note}.' n='.$i2a->{_n};
		$i2a->{_Step}		= $i2a->{_Step}.' n='.$i2a->{_n};

	} else { 
		print("i2a, n, missing n,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$i2a->{_n1}		= $n1;
		$i2a->{_note}		= $i2a->{_note}.' n1='.$i2a->{_n1};
		$i2a->{_Step}		= $i2a->{_Step}.' n1='.$i2a->{_n1};

	} else { 
		print("i2a, n1, missing n1,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$i2a->{_outpar}		= $outpar;
		$i2a->{_note}		= $i2a->{_note}.' outpar='.$i2a->{_outpar};
		$i2a->{_Step}		= $i2a->{_Step}.' outpar='.$i2a->{_outpar};

	} else { 
		print("i2a, outpar, missing outpar,\n");
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