
=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  sudoc2pm.pl							

 AUTHOR: Juan Lorenzo
 DATE:   Jan 25 2018 
 DESCRIPTION: generate (1) package for sunix module
 			  and (2) configuration file for the same sunix module
 Version: 1.0.0

=head2 USE

=head3 NOTES

=head4 Examplessudoc2pm

=head3 NOTES

 	Program group array and the directory names:
 		
 	$program_group[0]   	= 'data';
 	$program_group[1]   	= 'datuming';
 	$program_group[2]   	= 'display';
  	$program_group[3]   	= 'filter';
  	$program_group[4]   	= 'inversion';
 	$program_group[5]   	= 'metadata';
 	$program_group[6]   	= 'migration';	  	
 	$program_group[7]   	= 'misc';
 	$program_group[8]   	= 'model';
  	$program_group[9]   	= 'NMO_Vel_Stk';
  	$program_group[10]   	= 'par';
  	$program_group[11]   	= 'picking';
  	$program_group[12]   	= 'shapeNcut';
  	$program_group[13]   	= 'statsMath';
  	$program_group[14]   	= 'transform';
  	$program_group[15]   	= 'well';

=head2 CHANGES and their DATES


=cut

use Moose;

use sudoc;
use sunix_package;
use prog_doc2pm;

my $sudoc       = sudoc->new();
my $package     = sunix_package->new();
my $prog_doc2pm = prog_doc2pm->new();

my ( @file_in, @pm_file_out, @package_name );
my (@config_file_out);
my (@spec_file_out);
my (@path_out);
my ($i);
my @file;
my @package_path_out;

my $sudoc2pm = {
	_names         => '',
	_values        => '',
	_line_contents => '',
};

=head2 SET UP sunix package to build


=cut
#print("sudoc2pm, reading $file_in[0]\n");

# which group number do you want to use to create
# *.pm, *.config, and *_spec.pm files ?
my $group_no = 12;    # e.g. transfoms=14

$prog_doc2pm->set_group_directory($group_no);
my $path_in        = $prog_doc2pm->get_path_in();
my $path_out       = $prog_doc2pm->get_path_out();
my $list_length    = $prog_doc2pm->get_list_length();
my @long_file_name = @{ $prog_doc2pm->get_list_aref() };

print("sudoc2pm.pl,long_file_name: @long_file_name\n");

# print("sudoc2pm.pl,path_out: $path_out\n");
my @program_name = @{ $prog_doc2pm->get_program_aref() };

# first $i=2 because first two elements are empty,
#  because . and .. were not detected
# print("sudoc2pm.pl,program_name: @program_name\n"); #first two are empty
# skip . and ..	start at index 2 in list
#$list_length = 11;

for ( my $i = 2; $i < $list_length; $i++ ) {

	$package_name[0]    = $program_name[$i];
	$pm_file_out[0]     = $package_name[0] . '.pm';
	$config_file_out[0] = $package_name[0] . '.config';
	$spec_file_out[0]   = $package_name[0] . '_spec.pm';

	print("sudoc2pm.pl, writing $pm_file_out[0]\n");
	print("sudoc2pm.pl, writing $config_file_out[0]\n");
	print("sudoc2pm.pl, writing $spec_file_out[0]\n");

=head2 Read in sunix documentaion

=cut

	my $file = $long_file_name[$i];
	$sudoc->set_file_in_sref( \$file );
	$sudoc->set_perl_path_in($path_in);
	$sudoc->whole();
	my $whole_aref = $sudoc->get_whole();

	# my $length 			= scalar @$whole_aref;
	# print("sudoc2pm.pl,num_lines= $length\n");
	# for (my $i=0; $i <$length; $i++) {
	# 	print("sudoc2pm.pl,All sunix documentation @{$whole_aref}[$i]\n");
	# }

	$sudoc2pm->{_line_contents} = $sudoc->lines_with('=');
	my $sudoc_namVal = $sudoc->parameters( $sudoc2pm->{_line_contents} );
	my $length       = scalar @{ $sudoc_namVal->{_names} };

	print("sudoc2pm.pl, num names = $length\n");

	#					for (my $i=0; $i < $length; $i++) {
	#  	 			 print("\n3. sudoc2pm,_names = _values,
	#     			 line#$i @{$sudoc_namVal->{_names}}[$i] = ");
	#  				print("@{$sudoc_namVal->{_values}}[$i]\n");
	#				}

	$package_path_out[0] = $path_out;
	$package->set_file_out( \@pm_file_out );
	$package->set_path_out( \@package_path_out );
	$package->set_config_file_out( \@config_file_out );
	$package->set_spec_file_out( \@spec_file_out );
	$package->set_package_name( \@package_name );
	$package->set_param_names( $sudoc_namVal->{_names} );
	$package->set_param_values( $sudoc_namVal->{_values} );
	$package->set_sudoc_aref($whole_aref);
	$package->write_pm();
	$package->write_config();
	$package->write_spec();
}
