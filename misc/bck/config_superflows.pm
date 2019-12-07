package config_superflows;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 Perl package: config_superflows.pm 
 AUTHOR: Juan Lorenzo
 DATE: June 22 2017 

 DESCRIPTION: 
 V 0.1 June 22 2017
 V 0.2 June 23 2017
   change class name from sunix.pm     

 USED FOR: 

 BASED ON: param_sunix
 inherits from: param_sunix (e.g., sub first_idx)
 TODO: fully inherit from param_sunix 

=cut

use Moose;
my $VERSION = '1.0.0';
extends 'param_sunix';

=pod

 private hash_ref
 w  for widgets

=cut

 my $config_superflows = {
	_program_name_sref 		=> '',
	_label_boxes_w 			=> '',
	_entry_boxes_w 			=> '',
	_check_buttons_w 		=> '',
	_all_aref         		=> '',
	_first_superflow_idx	=> 0,
	_length         		=> '',
	_inbound				=> '',
	_program_name_config	=> '',
	_size         			=> '',
 };

	use L_SU_global_constants;
	
 	my $get  	= new L_SU_global_constants();
 	my $var  	= $get->var();
 	my $on      = $var->{_on};
 	my $off     = $var->{_off};
 	my $nu      = $var->{_nu};
 	my $yes		= $var->{_yes};
 	my $no      = $var->{_no};
 	my $superflow_names  = $get->superflow_names_h();
 	
 	my $set  	= new 	L_SU_global_constants();
    my $alias   = $set	->alias_superflow_names_h;
    
    my $global_lib  			= $get->global_libs();
 	my $GLOBAL_CONFIG_LIB      	= $global_lib->{_param};

 sub get_names {
  my ($self) 	= @_ ;
  my $cfg_aref 	= $config_superflows->{_all_aref};
  my $length    = $config_superflows->{_length};
  my ($i,$j);
  my @names;
  
  for ($i=0,$j=0; $i < $length; $i=$i+2,$j++ ) {
    $names[$j]  = @$cfg_aref[$i]; 
     # print(" config_superflows, get_names :index $j names:  $names[$j]\n");
  }  
  return (\@names);
 }


 sub get_values {
 	
	  my ($self) 	= @_ ;
	  
	  my $cfg_aref 	= $config_superflows->{_all_aref};
	  my $length    = $config_superflows->{_length};
	  my ($i,$j);
	  my @values;
	  
	  # print("cfg_aref is @$cfg_aref\n");
	
	  for ($i=1,$j=0; $i < $length; $i=$i+2,$j++ ) {
	    	$values[$j]  = @$cfg_aref[$i]; 
	    	# print("config_superflows, get_values :index $j values: $values[$j]\n");
	  }
	  
	  return (\@values);
 } 


 sub get_check_buttons_settings {
  my ($self) 	= @_ ;
  my $cfg_aref 	= $config_superflows->{_all_aref};
  my $length	= $config_superflows->{_length};
  my ($i,$j);
  my @on_off;
  my @values;

  for ($i=1,$j=0; $i < $length; $i=$i+2,$j++ ) {
    $values[$j]  = @$cfg_aref[$i]; 
    		# print("config_superflows, get_check_buttons_settings :index $j values: $values[$j]\n");
     
     if($values[$j] eq $nu || $values[$j] eq $no ) {
     	
       $on_off[$j]     = $off;
       # print("1 config_superflows: get_check_buttons_settings 'nu' or no :index $j setting: $on_off[$j]\n");
       
     } elsif ($values[$j] eq "") { # test form empty string
     	$on_off[$j]     = $off;
     	# print("2 config_superflows: get_check_buttons_settings, empty string :index $j setting: $on_off[$j]\n");
     }
     else {
       $on_off[$j]     = $on;
       # print("3 config_superflows: get_check_buttons_settings, else, :index $j setting: $on_off[$j]\n");
     }
     # print("config_superflows: get_check_buttons_settings :index $j setting: $on_off[$j]\n");
   }
 return(\@on_off);
 }


=head2 sub length

 length is not the last index but one beyond
 print("config_superflows, lengthis $config_superflows->{_length}\n");
 	TODO: subroutine will fail unless _defaults are first called

=cut 

sub length {

  my ($self) = @_;
  _get_all();
  
  if ($config_superflows->{_length}) {
  		$config_superflows->{_length} = $config_superflows->{_length}/2 ;
  		return($config_superflows->{_length});
  } else{
		print("config_superflows,length. length is missing\n");
		return();
  }
}

=pod

 export all the private hash references

=cut

sub _get_all {

  	my ($self) = '';
  			#print("config_superflows,_get_all \n");
  	_local_or_defaults($config_superflows->{_program_name_sref}); 
  	return();
}


=head2 sub _local_or_defaults

 Read a default specification file 
 If default specification file# does not exist locally, 
 which is in PL_SEISMIC  for general superflow conguration files
 and and in legacy cases for Project.config
 If Project.config is not found check the user's configuration area: .LSU/configuration/active/Project.config
 and if not,
 then use the default one defined under global libs 
 Similary if a general superflow.configuration file is not found under PL_SEISMIC
 check for one default case under global libs

 Debug with
    print ("self is $self,program is $program_name\n");
 print("params are @$ref_CFG\n");
 program name is a hash
    print("params are @$ref_cfg\n");
    print ("self is $self,program is $program_name\n");
       print("config_superflows,_local_or_defaults,program_name:$$program_name_sref\n"); 
       print("config_superflows,_local_or_defaults,program_name:$$name_sref\n"); 
       print("config_superflows,_local_or_defaults,program_name:$$program_name_sref\n"); 

=cut

sub _local_or_defaults {
	my ($self) = @_ ;
  	my $name_sref    					= $config_superflows->{_program_name_sref};
		   # print("config_superflows, _local_or_defaults,program name=$$name_sref\n");
		   # print("config_superflows, _local_or_defaults,SCALAR program name=$name_sref\n");
    use superflows_config;
    my $superflows_config  				= new superflows_config();
    my ($cfg_aref,$size);

    $cfg_aref 							= $superflows_config->get($name_sref);
    $config_superflows->{_all_aref}  	= $cfg_aref;
    $config_superflows->{_length} 		= $superflows_config->length();
	       # print("config_superflows, _local_or_defaults,length=$config_superflows->{_length}\n");
    return ();
}


=head2 sub get_local_or_defaults

 Read a default specification file 
 1) If default specification file# does not exist locally (PL_SEISMIC)
 2) then check the user's configuration area: .LSU/configuration/active/Project.config
 and if not,
 3) then use the default one defined under global libs 
 
 

 Debug with
    print ("self is $self,program is $program_name\n");
 print("params are @$ref_CFG\n");
 program name is a hash
    print("params are @$ref_cfg\n");
    print ("self is $self,program is $program_name\n");
       print("config_superflows,get_local_or_defaults,program_name:$$program_name_sref\n"); 
       print("config_superflows,get_local_or_defaults,program_name:$$name_sref\n"); 
       print("config_superflows,get_local_or_defaults,program_name:$$program_name_sref\n"); 
    print("config_superflows,get_local_or_defaults, length:$config_superflows->{_length}\n");

=cut

sub get_local_or_defaults {
	my ($self,$config_base_name) = @_ ;
	
	use L_SU_local_user_constants;
	my $user_constants   	= L_SU_local_user_constants->new();
	
	# get the local user
	# get path to home from the OS
	# my $HOME = $user_constants->get_home();
	
	# print("config_superflows,get_local_or_defaults, HOME:$HOME\n");
	
	# look for  ~/.LSU/active/Project.config
	# Read the thrid line and extract the project name
	
	if ($config_superflows->{_program_name_sref} ) {

#		my $LOCAL =$HOME.'/.L_SU/active';
#		use 
#		
#		# Case 1: Look locally for ~/.L_SU/active
#		if (-d $LOCAL) {
#			
#			print("config_superflows,get_local_or_defaults, HOME:$HOME\n");
#			
#			
#		
#		# CASE # 2 Use the defaults	from global libs
#		} else {		
			use superflows_config;
    		my $superflows_config  				= new superflows_config();
    		my ($cfg_aref,$size);
		
			my $name_sref    					= $config_superflows->{_program_name_sref};
		
			# print("config_superflows, get_local_or_defaults,program name=$$name_sref\n");
			# print("config_superflows, get_local_or_defaults,SCALAR program name=$name_sref\n");

    		$cfg_aref 							= $superflows_config->get($name_sref);
	       	# print("config_superflows, get_local_or_defaults,cfg_aref = @{$cfg_aref}\n");
    		return ($cfg_aref);
#		}
	} else {
		print("config_superflows, get_local_or_defaults,missing program_name_sref\n");
	}
	
 }
 
 
=head2 sub save

	i/p: has a reference with the names values and program name
	names are in an array reference
	values are too
	no need for checkbuttons
        # print("config_superflows,save\nprog_name: ${$out_hash_ref->{_prog_name}}");
        # print("  labels: @{$out_hash_ref->{_ref_labels}}\n");
        # print("  values: @{$out_hash_ref->{_ref_values}}\n");


=cut

sub save {

   	my ($self,$in_hash_ref) = @_;

   	my $out_hash_ref = {
		_ref_labels  		=> '', 
		_ref_values  		=> '',
		_prog_name_sref	 	=> '',
    };

   	use files_LSU;
   	my $files_LSU 						= new files_LSU();

	$out_hash_ref->{_ref_labels}  		= $in_hash_ref->{_names_aref};  
	$out_hash_ref->{_ref_values} 		= $in_hash_ref->{_values_aref};
	$out_hash_ref->{_prog_name_sref} 	= $in_hash_ref->{_prog_name_sref};
	
		# print("config_superflows,save,out_hash_ref, ${$out_hash_ref->{_prog_name_sref}}\n");
		# print("config_superflows,save,out_hash_ref,@{$out_hash_ref->{_ref_values}}[0]\n");  #
		# print("config_superflows,save,out_hash_ref,@{$out_hash_ref->{_ref_labels}}\n");
	 
	if(${$out_hash_ref->{_prog_name_sref}} eq 'Project') {  # Single special case
	 	$files_LSU->set_Project_config();
	 	$files_LSU->set_prog_name_sref($out_hash_ref->{_prog_name_sref});  # scalar ref
	 	$files_LSU->set_outbound($out_hash_ref->{_prog_name_sref});  # scalar ref
   		$files_LSU->set_superflow_specs($out_hash_ref); # scalar ref
   		$files_LSU->write(); 	# to /home/gom/.L_SU/configuration/active/Project.config
   		
   		$files_LSU->set_outbound2($out_hash_ref->{_prog_name_sref});  # scalar ref
    	$files_LSU->write2(); 	# to /home/gom/.L_SU/configuration/ProjectName/Project.config	
#   		# also create additional directory and file in the configuration area  		
	 	
	} else {
	 	$files_LSU->set_config();  # all superflow configuration files except Project.config
	 	$files_LSU->set_prog_name_sref($out_hash_ref->{_prog_name_sref});  # scalar ref
	 	$files_LSU->outbound();
   		$files_LSU->set_superflow_specs($out_hash_ref); # scalar ref
   		$files_LSU->check2write(); # to $PL_SEISMIC/prog_name.config
	}
	
   	return();

}


=head2 sub  set_program_name

 i/p is scalar ref
 o/p is scalar ref
 print("config_superflows, program_name,:$alias->{ProjectVariables}\n"); 
 print("config_superflows, program_name,is ${$config_superflows->{_program_name_sref}}\n");


=cut 


sub set_program_name {
   my ($self, $program_name_sref) = @_;
 					
 			# print("config_superflows, set_program_name, program_name=$$program_name_sref\n");
			# print("config_superflows, set_program_name, program_name=$superflow_names->{_fk}\n");
   if ($program_name_sref) {
     my $name_sref;

     if ($$program_name_sref eq $superflow_names->{_fk} ) {
     	 # print("config_superflows, fk name = $superflow_names->{_fk}\n");
         $name_sref 	= \$alias->{fk};
         # print("config_superflows, alias of program name is $$name_sref\n");
     }

     if ($$program_name_sref eq $superflow_names->{_iBottomMute} ) {
         $name_sref 	= \$alias->{iBottomMute};
     }

     if ($$program_name_sref eq $superflow_names->{_iSpectralAnalysis} ) {
         $name_sref 	= \$alias->{iSpectralAnalysis};
     }

     if ($$program_name_sref eq $superflow_names->{_iTopMute}) {
         $name_sref 	= \$alias->{iTopMute};
     }

     if ($$program_name_sref eq $superflow_names->{_iVelAnalysis} ) {
 		 # print("config_superflows, iVA name = $superflow_names->{_iVelAnalysis}\n");
         $name_sref 	= \$alias->{iVelAnalysis};
         # print("config_superflows, alias of program name is $$name_sref\n");
     }
     
     if ($$program_name_sref eq $superflow_names->{_Project} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{Project};
     }
     
     if ($$program_name_sref eq $superflow_names->{_ProjectVariables} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{ProjectVariables};
     }
    
     if ($$program_name_sref eq $superflow_names->{_Synseis} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{Synseis};
     }
     
     if ($$program_name_sref eq $superflow_names->{_Sseg2su} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{Sseg2su};
     }
        
     if ($$program_name_sref eq $superflow_names->{_Sucat} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_Sucat}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_Sucat}\n");
         $name_sref 	= \$alias->{Sucat};
     }
     
     if ($$program_name_sref eq $superflow_names->{_iPick} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{iPick};
     }
    
     if ($$program_name_sref eq $superflow_names->{_temp} ) {
					# warning: must omit underscore
					#print("config_superflows, set_program_name,superflow_names=$superflow_names->{_ProjectVariables}\n");
					#print("config_superflows, set_program_name,alias superflow_names=$superflow_names->{_ProjectVariables}\n");
         $name_sref 	= \$alias->{temp};
     }

     $config_superflows->{_program_name_sref} = $name_sref;
					#print("config_superflows,set_program_name alias = ${$config_superflows->{_program_name_sref}}\n");
	_get_all;
	
    }
	return();
}


=head2

=cut

 sub get_prog_name_config {
	my ($self) = @_;
	
	if ($config_superflows->{_program_name_config} ) {
		
		my $prog_name_config =$config_superflows->{_program_name_config};
				# print("config_superflows,get_prog_name_config: $prog_name_config\n");
		return($prog_name_config);
		
	} else {
		print("config_superflows, get_prog_name_config: missing \n");
		return();		
	}
 }
 
 
=head2

=cut

 sub _get_prog_name_config {
	my ($self) = @_;
	
	if ($config_superflows->{_program_name_config} ) {
		
		my $prog_name_config =$config_superflows->{_program_name_config};
		return($prog_name_config);
		
	} else {
		print("config_superflows, _get_prog_name_config: $config_superflows->{_program_name_sref}\n");
		return();		
	}
 }
 

=head2 sub set_prog_name_config

needs $config_superflows->{_program_name_sref}

=cut
 
 sub set_prog_name_config {
 	my ($self,$program_name_sref) = @_;
 	if ( $program_name_sref ) {
 		
 		my $prog_name 		= $$program_name_sref;
		$config_superflows->{_program_name_config} = $prog_name.'.config';
 			
 	} else {
 			
 		print("config_superflows, set_prog_name_config,_program_name_sref: missing\n");	
 	}
 	return();
 }
 
=head2 sub outbound

		print("config_superflows, inbound, prog_name: $prog_name\n");
		print("config_superflows, inbound, outbound: $config_superflows->{_program_name_config}\n");
		print("config_superflows, inbound, outbound: $config_superflows->{_inbound}\n");

=cut

sub inbound {
	my ($self) = @_;
				# print("config_superflows, inbound,_program_name_sref: $config_superflows->{_program_name_sref}\n");
	if ( $config_superflows->{_program_name_sref} ) {
		use Project_config;
	
		my $Project 		= Project_config->new();
	
		my $PL_SEISMIC 		= $Project->PL_SEISMIC();
	
		my $prog_name 		= ${$config_superflows->{_program_name_sref}};

		$config_superflows->{_program_name_config} = $prog_name.'.config';

		$config_superflows->{_inbound} = $PL_SEISMIC.'/'.$config_superflows->{_program_name_config};
	
		return();
		
	} else {
		
		print("config_superflows, inbound, missing program_name_sref\n");
		
	}

 }
 
 
#=head2 sub set outbound
#
#		print("config_superflows, set_outbound, prog_name: $prog_name\n");
#		print("config_superflows, set_outbound, outbound: $config_superflows->{_program_name_config}\n");
#		print("config_superflows, set_outbound, outbound: $config_superflows->{_outbound}\n");
#
#=cut

# sub set_outbound_PATH {
#	my ($self,$PATH)  = @_;
#				print("config_superflows, set_outbound,_program_name_sref: $config_superflows->{_program_name_sref}\n");
#	if ( $PATH ) {
#		use Project_config;
#	
#		my $Project 		= Project_config->new();
#	
#		my $PL_SEISMIC 		= $PATH $Project->PL_SEISMIC();
#	
#		my $prog_name 		= ${$config_superflows->{_program_name_sref}};
#
#		$config_superflows->{_program_name_config} = $prog_name.'.config';
#
#		$config_superflows->{_outbound} = $PL_SEISMIC.'/'.$config_superflows->{_program_name_config};
#	
#		return();
#		
#	} else {
#		
#		print("config_superflows, set_outbound, missing program_name_sref\n");
#		
#	}
#
# }

=head2 sub set_names_values

needs $config_superflows->{_inbound}
first look in $PL_SEISMIC and then 
look in the default global library

=cut

 sub check2read {
 	my ($self) = @_;
 	
 	if ($config_superflows->{_inbound}) {
 	  
		if (not -e $config_superflows->{_inbound} ) { #if file does not exist
		
			use File::Copy;
			my $prog_name_config			= _get_prog_name_config();
			
			my $from 						= $GLOBAL_CONFIG_LIB.$prog_name_config;
			my $to   						= $config_superflows->{_inbound};
		
	 		copy ($from, $to);
	 		# print("config_superflows copy $from to $to \n");
	 		 
	 		
		} else {
	 		# print("config_superflows, write_config, configuration file exists and will be overwritten\n");

		}
 	}
	return();
}


	# removes Moose exports
# no Moose;    	
 	# increases speed
#__PACKAGE__->meta->make_immutable; 
1;