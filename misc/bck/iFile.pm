package iFile;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 Perl package: iFile.pm 
 AUTHOR: Juan Lorenzo
 DATE: Nov 3 2017 

 DESCRIPTION: 
 V 0.1 

 USED FOR:
 
 interactive file and path manipulation

 BASED ON:
 
 CHANGES: Nov 14 2018 now works on user-built
 		as well as pre-built superflows

=cut

	use Moose;

 	use L_SU_global_constants;
 	my $get					= new L_SU_global_constants();
 	my $global_libs			= $get->global_libs();
 	my $alias_superflow_config_names_aref 	
							= $get->alias_superflow_config_names_aref();
	my $alias_superflow_spec_names_h 	
							= $get ->alias_superflow_spec_names_h(); 
 	my $superflow_config_names_aref 	
							= $get->superflow_config_names_aref();

 	my $default_path  		= $global_libs->{_default_path};
 	my $var					= $get->var();
 	my $base_file_name		= $var->{_base_file_name};
 	# my $data_name			= $var->{_data_name};
 	my $on         			= $var->{_on};
 	my $off        			= $var->{_off};
 	my $nu         			= $var->{_nu};
 	my $true         		= $var->{_on};
 	my $false         		= $var->{_off};
 	my $flow_type_h			= $get->flow_type_href();
 	my $empty_string		= $var->{_empty_string};

=head2 private hash

10 keys and values

=cut

 my $iFile = {
 	
	_entry_button_label			 	=> '',
	_is_flow_listbox_grey_w         => '',
	_is_flow_listbox_pink_w         => '',
	_is_flow_listbox_green_w        => '',
	_is_flow_listbox_blue_w         => '',
	_is_flow_listbox_color_w		=> '',
	_is_superflow_select_button     => '',
	_last_parameter_index_touched_color => '',
	_last_flow_listbox_touched_w	=> '',
	_last_flow_index_touched		=> '',
	_parameter_value_index			=> '',
	_prog_name						=> '',
	_prog_name_sref					=> '',
	_values_aref					=> '',

 };


=head2 _get_DATA_DIR_IN

works for both user-built and pre-built superflows
JML Nov-14-2018

=cut

sub _get_DATA_DIR_IN {
	my ($self) = @_;
	

    my $prog_name;
    
	# correct the superflow alias for _spec_name
	# N.B. that a hyphen is not needed inside the value of $prog_name
	if ( $iFile->{_flow_type} eq $flow_type_h->{_pre_built_superflow} ) {
		
		my $alias_prog_name 		= _get_prog_name();
		$prog_name					= $alias_superflow_spec_names_h->{$alias_prog_name};
		# print("iFile,get_Data_path, my unaliased program = $prog_name\n");
			
	} elsif( $iFile->{_flow_type} eq $flow_type_h->{_user_built} )  {
		
		$prog_name					= _get_prog_name();
		
	} else {		
		print("iFile, unexpected flow type \n");
	}
	
	if ($prog_name) {
		
		my $DATA_PATH_IN;
		
		my $module_spec				= $prog_name.'_spec';
		my $module_spec_pm      	= $module_spec.'.pm';
 	
		require $module_spec_pm;		
		my $package					= $module_spec->new;
	
		# collect specifications of input and output directories 
		# from a program_spec.pm module
		my $specs_h        			= $package->variables();
		$DATA_PATH_IN               = $specs_h->{_DATA_DIR_IN};
		# print("iFile,get_Data_path, DATA_PATH_IN = $DATA_PATH_IN\n");
		return ($DATA_PATH_IN);
		
	} else {
		print("iFile,_get_DATA_DIR_IN, missing prog_name\n");
		return();
	}    	
}


=head2 _get_DATA_DIR_OUT

=cut

 sub _get_DATA_DIR_OUT {
 	my ($self) = @_;
    my $DATA_PATH_OUT;
    
    my $prog_name = _get_prog_name();
	# print("iFile,get_Data_path, my program = $prog_name\n");
	
	if ($prog_name) {
		
		my $module_spec			= $prog_name.'_spec';
		my $module_spec_pm      = $module_spec.'.pm';
 	
		require $module_spec_pm;		
		my $package				= $module_spec->new;
	
		# collect specifications of input and output directories 
		# fromt a program_spec.pm module
		my $specs_h        			= $package->variables();
		$DATA_PATH_OUT              = $specs_h->{_DATA_DIR_OUT};
		print("iFile,get_Data_path, DATA_PATH_OUT = $DATA_PATH_OUT\n");
		return ($DATA_PATH_OUT);
		
	} else {
		print("iFile,_get_DATA_DIR_OUT, missing prog_name\n");
		return();
	}   
 }


=head2 sub close 
	
	close out File Dialog and highlight the next
	location in the GUI
   			 # print("iFile,close, superflow=$hash_ref->{_is_superflow_select_button}\n");
   			 #  print("iFile,close, flowleft=$hash_ref->{_is_flow_listbox_grey_w}\n");

=cut


sub  close { 
  	my ($self,$hash_ref) = @_;

	if ($hash_ref->{_last_flow_listbox_touched_w}) {
		
		$iFile->{_last_flow_listbox_touched_w}  = $hash_ref->{_last_flow_listbox_touched_w};
 		$iFile->{_last_flow_index_touched} 		= $hash_ref->{_last_flow_index_touched};
 		
		print("1. iFile,close, _last_flow_listbox_touched_w = $iFile->{_last_flow_listbox_touched_w}\n");
		print("2. iFile,close, _last_flow_index_touched = $hash_ref->{_last_flow_index_touched}\n");
				
		if ( $hash_ref->{_is_flow_listbox_grey_w}  || 
			$hash_ref->{_is_flow_listbox_pink_w}   ||
			$hash_ref->{_is_flow_listbox_green_w}  ||
			$hash_ref->{_is_flow_listbox_blue_w}   ||
			$hash_ref->{_is_flow_listbox_color_w} ) {
			# print("3 of 3 iFile,close, is grey listbox  =$hash_ref->{_is_flow_listbox_grey_w}\n");

			_close4flow();
		}

		if($hash_ref->{_is_superflow_select_button}) {
			
			_close4superflow();
			
		}	
		
	} else {
		print("iFile,close, missing _last_flow_listbox_touched_w \n");
	} 

   return();
}

=head2 sub get_Open_perl_flow_path 

=cut

sub  get_Open_perl_flow_path { 

	my ($self) 		 = @_;
	use Project_config;
	my $Project		 = new Project_config();
	my $PL_SEISMIC 	 = $Project->PL_SEISMIC();
   
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
	
   	return($path);
}

=head2 sub get_Open_path 

=cut

sub  get_Open_path { 

	my ($self) 		 = @_;
	use Project_config;
	my $Project		 = new Project_config();
	my $PL_SEISMIC 	 = $Project->PL_SEISMIC();
    
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}

=head2 sub get_SaveAs_path 

=cut

sub  get_SaveAs_path { 

  	my ($self) 			= @_;
	use Project_config;
    my $Project 		= new Project_config();
	my $PL_SEISMIC 		= $Project->PL_SEISMIC();
    
   	$iFile->{_path} 	= $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}



=head2 sub get_Data_path

 
 get DATA path from SPEC file
 corresponding to the program name
 make sure to remove unneeded ticks in strings
 
=cut

sub  get_Data_path { 

  	my ($self) 				= @_;

  	use L_SU_global_constants;
  	use Project_config;
  	my $entry_label 		= $iFile->{_entry_button_label};
 
 		# print("iFile,get_path,parameter label or name = $entry_label\n");
  		# print("iData_File,get_Data_path,base_file_name     = $base_file_name\n");

		# my $suffix_type1	 		= @{$iFile->{_values_aref}}[1]; 			
  		# print("iFile,get_path,suffix_type = $suffix_type1\n");
  		

    my $Project 					= new Project_config();
    my $DATA_SEISMIC_BIN 			= $Project->DATA_SEISMIC_BIN();
	my $DATA_SEISMIC_SU 			= $Project->DATA_SEISMIC_SU();
	my $PL_SEISMIC 					= $Project->PL_SEISMIC();
	my $DATA_SEISMIC_SEGY 			= $Project->DATA_SEISMIC_SEGY();
	my $DATA_SEISMIC_TXT 			= $Project->DATA_SEISMIC_TXT();
	my $DATA_SEISMIC_WELL_SYNSEIS 	= $Project->DATA_SEISMIC_WELL_SYNSEIS();
	
	# CASE 1 user-built flows
	if ($iFile->{_flow_type} 	eq $flow_type_h->{_user_built} ) {
		
		# FOR A VERY SPECIFIC CASE
		# CASE 1A first label/name = 'base_file_name  				
		if ( $entry_label 			eq $base_file_name ) {
			
			my $suffix_type	 		= @{$iFile->{_values_aref}}[1]; 			
  			# print("iFile,get_path,suffix_type = $suffix_type\n"); 
			
			#CASE 1A.1	
			# second (index=1) 		
			# second label/name = 'type' &&  value = 'su'
			if ( $suffix_type eq 'su' or $suffix_type eq "'su'") { 
				# print("iFile,get_path,entry_button_label= $entry_label\n");			
				# print("2. iFile,get_Data_path,$DATA_SEISMIC_SU\n");
				$iFile->{_path}  = $DATA_SEISMIC_SU;
			
			# CASE 1A.2
			# and second (index=1) 'segy' 	
			# if second label/name = 'type' &&  value = 'segy'
		 	} elsif ( $suffix_type eq 'segy' or $suffix_type eq "'segy'" 
		 		or $suffix_type eq 'SEGY' 	or $suffix_type eq "'SEGY'" 
		 		or $suffix_type eq 'sgy' 	or $suffix_type eq "'sgy'"
		 		or $suffix_type eq 'SGY'   	or $suffix_type eq "'SGY'") {
		 			
				# print("iFile,get_path,entry_button_label= $entry_label\n");			
				# print("3. iFile,get_Data_path,$DATA_SEISMIC_SEGY\n");
				$iFile->{_path}  = $DATA_SEISMIC_SEGY;
			
			# CASE 1A.3
			# and second (index=1) text 	
			# if second label/name = 'type' &&  value is text	
		 	} elsif ( $suffix_type eq 'txt'or $suffix_type eq 'TXT' or $suffix_type eq "'txt'" or $suffix_type eq "'TXT'" 
		 		or $suffix_type eq 'text' or $suffix_type eq 'TEXT'or $suffix_type eq "'text'"or $suffix_type eq "'TEXT'" 
		 		or $suffix_type eq 'ascii' or $suffix_type eq 'ASCII'or $suffix_type eq "'ascii'"or $suffix_type eq "'ASCII'" ) {
		 			
				# print("iFile,get_path,entry_button_label= $entry_label\n");			
				# print("4. iFile,get_Data_path,$DATA_SEISMIC_TXT\n");
				$iFile->{_path}  = $DATA_SEISMIC_TXT;
				
			#CASE 1A.4
			# and second (index=1) entry value = binary data			
			# if second label/name = 'type' &&  value = bin
		 	} elsif ( $suffix_type eq 'bin'or $suffix_type eq 'BIN' or $suffix_type eq "'bin'" or $suffix_type eq "'BIN'") {
		 			
				# print("iFile,get_path,entry_button_label= $entry_label\n");			
				# print("5. iFile,get_Data_path,$DATA_SEISMIC_BIN\n");
				$iFile->{_path}  = $DATA_SEISMIC_BIN;
				
			# CASE 1A.5	unrecognized data type
		 	} else {
		 		$iFile->{_path}  = $default_path ;
   				print("iFile,get_path,path=$iFile->{_path}\n");	
		 		print("2. iFile,get_Data_path, unrecognized data type ... TB Added\n");		 	
		 	}
		
		# FOR ANOTHER VERY SPECIFIC CASE
		# CASE 1B : suop2
		# first label/name   = 'file1'
		# second label/name  = 'file2'  
		} elsif ( $entry_label 		eq 'file1' or
			 $entry_label 			eq 'file2'    ) {

			 $iFile->{_path}  = $DATA_SEISMIC_SU;			 

	    # FOR GENERAL CASES 
	    # which are pre-defined within the relevant spec files
	    } elsif ( $entry_label 		ne  $empty_string ) {	    	
			$iFile->{_path}  = _get_DATA_DIR_IN;
			# print("iFile,get_Data_path, DATA_DIR_IN= $iFile->{_path}\n")    
			 
		} elsif	( $entry_label 		eq  $empty_string ) {  # unlikely
				
		    # print("iFile,get_Data_path, entry_label is empty \n");
		    # print("iFile,get_Data_path, PL_SEISMIC path chose \n");	
    		$iFile->{_path}  = $PL_SEISMIC;		
   			 			
		} else {
    		$iFile->{_path}  = $default_path ;
   			print("iFile,get_path,path=$iFile->{_path}\n");	
			# print("iFile, get_Data_path, entry label is neither base_file_name (i.e. without suffix) nor fileX \n");
		}	 			

	# CASE 2 : for superflows where 
	# first label/name = 'base_file_name
	# and second label/name  = 'type',  
	# and second (index=1) entry value = 'su', 'segy' etc.		 		 
	} elsif	( 	$iFile->{_flow_type} eq $flow_type_h->{_pre_built_superflow} ) {
		
		# CASE 2A
		if ( $entry_label 			eq $base_file_name)	 {
			
			# print("2. iFile,get_Data_path,$DATA_SEISMIC_SU\n");
			#_get_DATA_DIR_OUT;
			 # _get_DATA_DIR_IN;
			$iFile->{_path}  = _get_DATA_DIR_IN;
			
		# CASE 2B
		} elsif	( $entry_label eq $empty_string ) {
				
		    # print("iFile,get_Data_path, entry_label is empty \n");
		    # print("iFile,get_Data_path, PL_SEISMIC path chose \n");	
    		$iFile->{_path}  = $PL_SEISMIC;
    		
		#CASE 2C
		} else {			
			$iFile->{_path}	= $default_path ;
			# print("iFile, get_Data_path, superflow entry label is unexpected \n");	
   			# print("iFile,get_path,path=$iFile->{_path}\n");
		}	
	
	# CASE 3: all other cases
	} else {				 
    	$iFile->{_path}  = $default_path ;
    	print("iFile,get_Data_path, unsuitable flow type \n");
   		print("iFile,get_path,path=$iFile->{_path}\n");
	}
	
	my $path = $iFile->{_path};
	# print("2. iFile,get_path,path=$iFile->{_path}\n");
   	return($path);
}


=head2 sub get_Path

	get DATA path from SPEC file
	corresponding to the program name
	make sure to remove unneeded ticks in strings
	Only used by _pre_built_superflow_open_path
	 
	prepend appropriately the path to the 
				final path in the parameter value
	e.z. Z becomes /home/gom/ProjectHome/site/spare_directory/etc..../Z
	you can do this by using (1) the current index
	current program name
	the current value of the parameter
	the previous indices
	the values or the previous parameters
 
=cut

sub get_Path { 

  	my ($self) 				= @_;
  	
  	if (defined $iFile->{_values_aref} 				&& 
  		defined $iFile->{_parameter_value_index} 	&& 	
   		defined $iFile->{_prog_name_sref} 			&& 	
  		$iFile->{_values_aref} 				ne $empty_string && 
  		$iFile->{_parameter_value_index} 	ne $empty_string &&
  		$iFile->{_prog_name_sref}  			ne $empty_string ) {

	  	my $Path;	
  		
	  	my $entry_label 		= $iFile->{_entry_button_label};
	  	my $index				= $iFile->{_parameter_value_index};
	  	my @values				= @{$iFile->{_values_aref}};	
	 
	 	# print("iFile,get_Path,parameter label or name 	=---$entry_label---\n");
	  	# print("iFile,get_Path,value	=---$value---\n");
	  	# print("1.iFile,get_Path, _values_aref: @{$iFile->{_values_aref}}\n");
	  	  				 	 		
		my $program_name	   =  _get_prog_name();

		if ( $program_name eq 'Project') {
		
			# print("1.iFile,get_Path, _values_aref: @{$iFile->{_values_aref}}[0]\n");
				
			use Project_config;
		
			my $Project = Project_config->new();
				
			my $forHOME			= $values[0];
			my $forPROJECT_HOME = $values[0];
			my $forSITE			= $values[1].'/seismics/pl/';
			my $forSPARE_DIR	= $forSITE.$values[2].'/';
			my $forDATE			= $forSPARE_DIR.$values[3].'/';
			my $forCOMPONENT	= $forDATE.$values[4].'/';
			my $forLINE			= $forCOMPONENT.$values[5];
					
			if ($index   == 0) {					
				$Path 		= $forHOME;
				
			} elsif ($index   == 1) {					
				$Path = $forPROJECT_HOME;
			
			} elsif ($index   == 2) {					
				$Path =  $forSITE;
			
			} elsif ($index   == 3) {					
				$Path =  $forSPARE_DIR;   
				
			} elsif ($index   == 4) {					
				$Path	= 	$forDATE;
		
			} elsif ($index   == 5) {					
				$Path	= 	$forCOMPONENT;
			
			} elsif ($index   == 6) {					
				$Path	= 	$forLINE;
				
			} else {
				print("1.iFile,get_Path, unexpected index \n");
			}
		}
  		
	  	$iFile->{_path}	= $Path;
	  		  	
		my $result= $iFile->{_path};
		# print("2. iFile,get_Path,path=$iFile->{_path}\n");
		
	   	return($result); 		
  		
  	} else {
  		# print("iFile,get_Path, missing values,program name or parameter index\n"); 
  		return();	
  	}
}

=head2 sub get_prog_name_href


=cut

sub get_prog_name_href {

	my ($self,$hash_ref) = @_;
	my ($program_name);
	if ($hash_ref) {
		my ($ans,$first_name,$suffix,$length);
		my @names     	= @$alias_superflow_config_names_aref;
		$length         = scalar (@names);
		$first_name 	= $hash_ref->{_selected_first_name};

		print("iFile,get_prog_name_href,first_name=$first_name\n");

			for ( my $i=0; $i < $length; $i++) {
				if ($names[$i] eq  $first_name) {
						$ans = $i;	
				}
			}
		$program_name	=	$names[$ans];
		print("iFile,get_prog_name,superflow name = $names[$ans]\n");
	}
	return($program_name); 
}


=head2 sub get_prog_name_s

	match the names of configuration files using aliases,
	which have hyphens, e.g. Project_Variables

	However, program names may be different: e.g. ProjectVariables


=cut

sub get_prog_name_s {

	my ($self,$scalar) = @_;
	my ($alias_program_name,$program_name);
	if ($scalar) {
		my ($ans,$first_name,$length);
		$first_name 	= $scalar;
		my @alias_names = @$alias_superflow_config_names_aref;
		my @names     	= @$superflow_config_names_aref;
		$length         = scalar (@names);

					# print("iFile,get_prog_name_s,first_name=$first_name\n");
			
			for ( my $i=0; $i < $length; $i++) {
				if ($alias_names[$i] eq  $first_name) {
						$ans = $i;	
        				$program_name		= 	$names[$ans];
				}
			}
		if($program_name) {
			 print("iFile,get_prog_name_s,superflow name = $program_name\n");
		} else {
			 print("iFile,get_prog_name_s,superflow name = NO MATCH\n");
		}
	}
	return($program_name); 
}

=head2 sub _close4flow 

	highlight the last index touched

=cut

sub  _close4flow { 
  my ($self) = @_;
  
  			print("iFile,_close4flow, iFile->{_last_flow_index_touched}: $iFile->{_last_flow_index_touched} \n");
   			print("iFile,_close4flow, iFile->{_last_flow_listbox_touched_w}: $iFile->{_last_flow_listbox_touched_w} \n");
   			
	if($iFile->{_last_flow_listbox_touched_w}  && ( $iFile->{_last_flow_index_touched}  >= 0) ) {  # -1 does exist as default in L_SU.pm
			$iFile->{_last_flow_listbox_touched_w}    
			->selectionSet(
                 $iFile->{_last_flow_index_touched}, 
	          );		
	} else {
			print("iFile, _close4flow, missing widget and or index (integer)\n");
	}
   return();
}




=head2 sub _close4superflow 

=cut

sub  _close4superflow { 

  my ($self) = @_;

   return();
}

=head2 sub _get_prog_name

	give scalar reference to program name 

=cut

sub  _get_prog_name { 

	my ($self) = @_;
	
	if(defined $iFile->{_prog_name_sref} && 
		$iFile->{_prog_name_sref} ne $empty_string) {
			
		# print("iFile,set_prog_name_sref,-- if assumed a scalar ref: ${$iFile->{_prog_name_sref}}\n");
		
		my $program_name = ${$iFile->{_prog_name_sref}};
		return($program_name);

   	} else {
		 print("iFile,set_prog_name_sref, no prog name is available to read\n");
		 return();
	}   	
 }


=head2 sub _set4getpath

=cut

sub  _set4get_path { 

	my ($self) = @_;
	my $conditions;


	return($conditions);
}


=head2 sub set_entry 

	force entry point from gui to be an Entry widget

=cut

sub  set_entry { 

  my ($self,$hash_ref) = @_;

	if( defined $hash_ref ) {
		
		# print("iFile,set_entry, entry_button label=$hash_ref->{_entry_button_label}___\n");
			
		if ($hash_ref->{_entry_button_label} ne $empty_string ) {
			
			$iFile->{_entry_button_label} = $hash_ref->{_entry_button_label}; 
			
		} else {
			print("iFile,set_entry, unexpected hash_ref\n");
		}
		
	}
   	
  return();
}

	
=head2 sub set_flow_type_h

	user_built_flow
	or
	pre_built_superflow
	
=cut

 sub set_flow_type_h {
 	
 	my ($self,$how_built) = @_;
 	
 	if ( defined $how_built ) {
 			 		
 		$iFile->{_flow_type} = $how_built->{_flow_type};
 		# print("iFile, set_flow_type_h : $iFile->{_flow_type}\n");
 		
 	} else {		
 		print("iFile, set_flow_type_h , missing how_built\n");
 	}
 	
 	return();
 }


=head2 sub set_parameter_value_index

	Index of selected parameter

=cut

sub  set_parameter_value_index { 

  my ($self,$hash_ref) = @_;

	if( defined $hash_ref ) {
		
		# print("iFile,set_parameter_value_index, index=$hash_ref->{_parameter_value_index}----\n");
			
		if ($hash_ref->{_parameter_value_index} ne $empty_string ) {
			
			$iFile->{_parameter_value_index} = $hash_ref->{_parameter_value_index}; 
			
		} else {
			print("iFile,set_parameter_value_index, unexpected hash_ref\n");
		}		
	}   	
	my $result		= $iFile->{_parameter_value_index};
	return($result);
}


=head2 sub set_prog_name_sref

	give scalar reference to program name 

=cut

sub  set_prog_name_sref { 

	my ($self,$hash_ref) = @_;
	if($hash_ref->{_prog_name_sref}) {
		
				 # print("iFile,set_prog_name_sref,raw: $hash_ref->{_prog_name_sref}\n");
				 # print("iFile,set_prog_name_sref,-- if assumed a scalar ref: ${$hash_ref->{_prog_name_sref}}\n");
		$iFile->{_prog_name_sref} = $hash_ref->{_prog_name_sref};

   	} else {
		 print("iFile,set_prog_name_sref, no prog name given\n");
	}
   	return();
 }
 
 
=head2 sub set_values_aref

	introduce array or parameter values
 
=cut

sub  set_values_aref { 

	my ($self,$hash_ref) = @_;
	if($hash_ref->{_values_aref}) {
		
				 # print("iFile,set_values_aref,raw: @{$hash_ref->{_values_aref}}[0],@{$hash_ref->{_values_aref}}[1]\n");
		$iFile->{_values_aref} = $hash_ref->{_values_aref};

   	} else {
		 print("iFile,set_values_aref, missing values_aref \n");
	}
   	return();
 }

1;