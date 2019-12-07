 package sukdmdcr;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:   SUKDMDCR - 2.5D datuming of receivers for prestack, common source    
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

  SUKDMDCR - 2.5D datuming of receivers for prestack, common source    
            data using constant-background data mapping formula.       
            (See selfdoc for specific survey requirements.)            

    sukdmdcr  infile=  outfile=  [parameters] 	         		

 Required file parameters:						
 infile=stdin		file for input seismic traces			
 outfile=stdout	file for output          			
 ttfile		file for input traveltime tables		

 Required parameters describing the traveltime tables:		        
 fzt 			first depth sample in traveltime table		
 nzt 			number of depth samples in traveltime table	
 dzt			depth interval in traveltime table		
 fxt			first lateral sample in traveltime table	
 nxt			number of lateral samples in traveltime table	
 dxt			lateral interval in traveltime table		
 fs 			x-coordinate of first source in table		
 ns 			number of sources in table			
 ds 			x-coordinate increment of sources in table	

 Parameters describing the input data:                                 
 nxso                  number of shots                                 
 dxso                  shot interval                                   
 fxso=0                x-coordinate of first shot                      
 nxgo                  number of receiver offsets per shot             
 dxgo                  receiver offset interval                        
 fxgo=0                first receiver offset                           
 dt= or from header (dt)       time sampling interval of input data    
 ft= or from header (ft)       first time sample of input data         

 Parameters describing the domain of the problem:             		
 dzo=0.2*dzt		vertical spacing in surface determination       
 offmax=99999		maximum absolute offset allowed          	

 Parameters describing the recording and datuming surfaces:            
 recsurf=0             recording surface (horizontal=0, topographic=1) 
 zrec                  defines recording surface when recsurf=0        
 recfile=              defines recording surface when recsurf=1        
 datsurf=0             datuming surface (horizontal=0, irregular=1)    
 zdat                  defines datuming surface when datsurf=0         
 datfile=              defines datuming surface when datsurf=1         

 Optional parameters describing the extrapolation:                     
 aperx=nxt*dxt/2  	lateral half-aperture 				
 v0=1500(m/s)		reference wavespeed               		
 freq=50               dominant frequency in data, used to determine   
                       the minimum distance below the datum that       
                       the stationary phase calculation is valid.      
 scale=1.0             user defined scale factor for output            
 jpfile=stderr		job print file name 				
 mtr=100  		print verbal information at every mtr traces	
 ntr=100000		maximum number of input traces to be datumed	



 Computational Notes:                                                
   
 1. Input traces must be SU format and organized in common shot gathers.

 2. Traveltime tables were generated by program rayt2d (or equivalent)     
    on any grid, with dimension ns*nxt*nzt. In the extrapolation process,       
    traveltimes are interpolated into shot/geophone locations and     
    output grids.                                          

 3. If the offset value of an input trace is not in the offset array     
    of output, the nearest one in the array is chosen.                   

 4. Amplitudes are computed using the constant reference wavepeed v0.
                                
 5. Input traces must specify source and receiver positions via the header  
    fields tr.sx and tr.gx.             

 6. Recording and datuming surfaces are defined as follows:  If recording
    surface is horizontal, set recsurf=0 (default).  Then, zrec will be a
    required parameter, set to the depth of surface.  If the recording  
    surface is topographic, then set recsurf=1.  Then, recfile is a required
    input file.  The input file recfile should be a single column ascii file
    with the depth of the recording surface at every surface location (first 
    source to last offset), with spacing equal to dxgo. 
 
    The same holds for the datuming surface, using datsurf, zdat, and datfile.


 Assumptions and limitations:

 1. This code implements a 2.5D extraplolation operator that allows to
    transfer data from one reference surface to another.  The formula used in
    this application is an adaptation of Bleistein & Jaramillo's 2.5D data
    mapping formula for receiver extrapolation.  This is the result of a
    stationary phase analysis of the data mapping equation in the case of
    a constant source location (shot gather). 
 

 Credits:
 
 Authors:  Steven D. Sheaffer (CWP), 11/97 


 References:  Sheaffer, S., 1999, "2.5D Downward Continuation of the Seismic
              Wavefield Using Kirchhoff Data Mapping."  M.Sc. Thesis, 
              Dept. of Mathematical & Computer Sciences, 
              Colorado School of Mines.



=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sukdmdcr		= {
		_aperx					=> '',
		_datfile					=> '',
		_datsurf					=> '',
		_dt					=> '',
		_dzo					=> '',
		_freq					=> '',
		_ft					=> '',
		_fxgo					=> '',
		_fxso					=> '',
		_infile					=> '',
		_jpfile					=> '',
		_mtr					=> '',
		_ntr					=> '',
		_offmax					=> '',
		_outfile					=> '',
		_recfile					=> '',
		_recsurf					=> '',
		_scale					=> '',
		_v0					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sukdmdcr->{_Step}     = 'sukdmdcr'.$sukdmdcr->{_Step};
	return ( $sukdmdcr->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sukdmdcr->{_note}     = 'sukdmdcr'.$sukdmdcr->{_note};
	return ( $sukdmdcr->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sukdmdcr->{_aperx}			= '';
		$sukdmdcr->{_datfile}			= '';
		$sukdmdcr->{_datsurf}			= '';
		$sukdmdcr->{_dt}			= '';
		$sukdmdcr->{_dzo}			= '';
		$sukdmdcr->{_freq}			= '';
		$sukdmdcr->{_ft}			= '';
		$sukdmdcr->{_fxgo}			= '';
		$sukdmdcr->{_fxso}			= '';
		$sukdmdcr->{_infile}			= '';
		$sukdmdcr->{_jpfile}			= '';
		$sukdmdcr->{_mtr}			= '';
		$sukdmdcr->{_ntr}			= '';
		$sukdmdcr->{_offmax}			= '';
		$sukdmdcr->{_outfile}			= '';
		$sukdmdcr->{_recfile}			= '';
		$sukdmdcr->{_recsurf}			= '';
		$sukdmdcr->{_scale}			= '';
		$sukdmdcr->{_v0}			= '';
		$sukdmdcr->{_Step}			= '';
		$sukdmdcr->{_note}			= '';
 }


=head2 sub aperx 


=cut

 sub aperx {

	my ( $self,$aperx )		= @_;
	if ( $aperx ne $empty_string ) {

		$sukdmdcr->{_aperx}		= $aperx;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' aperx='.$sukdmdcr->{_aperx};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' aperx='.$sukdmdcr->{_aperx};

	} else { 
		print("sukdmdcr, aperx, missing aperx,\n");
	 }
 }


=head2 sub datfile 


=cut

 sub datfile {

	my ( $self,$datfile )		= @_;
	if ( $datfile ne $empty_string ) {

		$sukdmdcr->{_datfile}		= $datfile;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' datfile='.$sukdmdcr->{_datfile};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' datfile='.$sukdmdcr->{_datfile};

	} else { 
		print("sukdmdcr, datfile, missing datfile,\n");
	 }
 }


=head2 sub datsurf 


=cut

 sub datsurf {

	my ( $self,$datsurf )		= @_;
	if ( $datsurf ne $empty_string ) {

		$sukdmdcr->{_datsurf}		= $datsurf;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' datsurf='.$sukdmdcr->{_datsurf};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' datsurf='.$sukdmdcr->{_datsurf};

	} else { 
		print("sukdmdcr, datsurf, missing datsurf,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sukdmdcr->{_dt}		= $dt;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' dt='.$sukdmdcr->{_dt};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' dt='.$sukdmdcr->{_dt};

	} else { 
		print("sukdmdcr, dt, missing dt,\n");
	 }
 }


=head2 sub dzo 


=cut

 sub dzo {

	my ( $self,$dzo )		= @_;
	if ( $dzo ne $empty_string ) {

		$sukdmdcr->{_dzo}		= $dzo;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' dzo='.$sukdmdcr->{_dzo};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' dzo='.$sukdmdcr->{_dzo};

	} else { 
		print("sukdmdcr, dzo, missing dzo,\n");
	 }
 }


=head2 sub freq 


=cut

 sub freq {

	my ( $self,$freq )		= @_;
	if ( $freq ne $empty_string ) {

		$sukdmdcr->{_freq}		= $freq;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' freq='.$sukdmdcr->{_freq};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' freq='.$sukdmdcr->{_freq};

	} else { 
		print("sukdmdcr, freq, missing freq,\n");
	 }
 }


=head2 sub ft 


=cut

 sub ft {

	my ( $self,$ft )		= @_;
	if ( $ft ne $empty_string ) {

		$sukdmdcr->{_ft}		= $ft;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' ft='.$sukdmdcr->{_ft};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' ft='.$sukdmdcr->{_ft};

	} else { 
		print("sukdmdcr, ft, missing ft,\n");
	 }
 }


=head2 sub fxgo 


=cut

 sub fxgo {

	my ( $self,$fxgo )		= @_;
	if ( $fxgo ne $empty_string ) {

		$sukdmdcr->{_fxgo}		= $fxgo;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' fxgo='.$sukdmdcr->{_fxgo};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' fxgo='.$sukdmdcr->{_fxgo};

	} else { 
		print("sukdmdcr, fxgo, missing fxgo,\n");
	 }
 }


=head2 sub fxso 


=cut

 sub fxso {

	my ( $self,$fxso )		= @_;
	if ( $fxso ne $empty_string ) {

		$sukdmdcr->{_fxso}		= $fxso;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' fxso='.$sukdmdcr->{_fxso};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' fxso='.$sukdmdcr->{_fxso};

	} else { 
		print("sukdmdcr, fxso, missing fxso,\n");
	 }
 }


=head2 sub infile 


=cut

 sub infile {

	my ( $self,$infile )		= @_;
	if ( $infile ne $empty_string ) {

		$sukdmdcr->{_infile}		= $infile;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' infile='.$sukdmdcr->{_infile};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' infile='.$sukdmdcr->{_infile};

	} else { 
		print("sukdmdcr, infile, missing infile,\n");
	 }
 }


=head2 sub jpfile 


=cut

 sub jpfile {

	my ( $self,$jpfile )		= @_;
	if ( $jpfile ne $empty_string ) {

		$sukdmdcr->{_jpfile}		= $jpfile;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' jpfile='.$sukdmdcr->{_jpfile};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' jpfile='.$sukdmdcr->{_jpfile};

	} else { 
		print("sukdmdcr, jpfile, missing jpfile,\n");
	 }
 }


=head2 sub mtr 


=cut

 sub mtr {

	my ( $self,$mtr )		= @_;
	if ( $mtr ne $empty_string ) {

		$sukdmdcr->{_mtr}		= $mtr;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' mtr='.$sukdmdcr->{_mtr};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' mtr='.$sukdmdcr->{_mtr};

	} else { 
		print("sukdmdcr, mtr, missing mtr,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sukdmdcr->{_ntr}		= $ntr;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' ntr='.$sukdmdcr->{_ntr};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' ntr='.$sukdmdcr->{_ntr};

	} else { 
		print("sukdmdcr, ntr, missing ntr,\n");
	 }
 }


=head2 sub offmax 


=cut

 sub offmax {

	my ( $self,$offmax )		= @_;
	if ( $offmax ne $empty_string ) {

		$sukdmdcr->{_offmax}		= $offmax;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' offmax='.$sukdmdcr->{_offmax};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' offmax='.$sukdmdcr->{_offmax};

	} else { 
		print("sukdmdcr, offmax, missing offmax,\n");
	 }
 }


=head2 sub outfile 


=cut

 sub outfile {

	my ( $self,$outfile )		= @_;
	if ( $outfile ne $empty_string ) {

		$sukdmdcr->{_outfile}		= $outfile;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' outfile='.$sukdmdcr->{_outfile};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' outfile='.$sukdmdcr->{_outfile};

	} else { 
		print("sukdmdcr, outfile, missing outfile,\n");
	 }
 }


=head2 sub recfile 


=cut

 sub recfile {

	my ( $self,$recfile )		= @_;
	if ( $recfile ne $empty_string ) {

		$sukdmdcr->{_recfile}		= $recfile;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' recfile='.$sukdmdcr->{_recfile};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' recfile='.$sukdmdcr->{_recfile};

	} else { 
		print("sukdmdcr, recfile, missing recfile,\n");
	 }
 }


=head2 sub recsurf 


=cut

 sub recsurf {

	my ( $self,$recsurf )		= @_;
	if ( $recsurf ne $empty_string ) {

		$sukdmdcr->{_recsurf}		= $recsurf;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' recsurf='.$sukdmdcr->{_recsurf};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' recsurf='.$sukdmdcr->{_recsurf};

	} else { 
		print("sukdmdcr, recsurf, missing recsurf,\n");
	 }
 }


=head2 sub scale 


=cut

 sub scale {

	my ( $self,$scale )		= @_;
	if ( $scale ne $empty_string ) {

		$sukdmdcr->{_scale}		= $scale;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' scale='.$sukdmdcr->{_scale};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' scale='.$sukdmdcr->{_scale};

	} else { 
		print("sukdmdcr, scale, missing scale,\n");
	 }
 }


=head2 sub v0 


=cut

 sub v0 {

	my ( $self,$v0 )		= @_;
	if ( $v0 ne $empty_string ) {

		$sukdmdcr->{_v0}		= $v0;
		$sukdmdcr->{_note}		= $sukdmdcr->{_note}.' v0='.$sukdmdcr->{_v0};
		$sukdmdcr->{_Step}		= $sukdmdcr->{_Step}.' v0='.$sukdmdcr->{_v0};

	} else { 
		print("sukdmdcr, v0, missing v0,\n");
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