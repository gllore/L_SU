package manage_files_by2;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 
 Contains methods/subroutines/functions to operate on directories

 PROGRAM NAME: manage_files_by  classIVA 
 AUTHOR: Juan Lorenzo
 DATE:   V 1. March 3 2008
 V 2 May 27 2014
         
 DESCRIPTION: 
 modified from
 manage_files_by 
 to stricts requirements using Moose
 manage_files_by  class

 =head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 NOTES  

=head4 CHANGES and their DATES


=cut

=pod
=cut 

=head3 sub does_file_exist
 returns a 1 if the file does exist
 and returns a 0 if the file does not

=cut

use Moose;
our $VERSION = '0.0.1';
use L_SU_global_constants;

=head2 Instantiation

=cut

my $get          = L_SU_global_constants->new();
my $var          = $get->var();
my $empty_string = $var->{_empty_string};

=head2 created private hash


=cut

my $manage_files_by2 = {

	_file_name => '',
	_fifo_name => '',	
	_format    => '',

};

=head2 clear variables in private hash


=cut

sub clear {
	my ($self) = @_;

	$manage_files_by2->{_file_name} = '';
	$manage_files_by2->{_fifo_name} = '';
	$manage_files_by2->{_format}    = '';

	return ();

}

sub does_file_exist {

	my ( $does_file_exist, $ref_file ) = @_;

	$does_file_exist->{ref_file} = $$ref_file if defined($ref_file);

	# print("file name is, $$ref_file\n");

	# default situation is to have a file non-existent
	my $answer = 0;

	# -e returns 1 or ''
	# verified by JL
	# print("plain file for test is $$ref_file\n\n");
	if ( -f $does_file_exist->{ref_file} ) {

		#print  ("file existence verified\n\n") ;
		$answer = 1;
	}

	#	answer=1 if existent and =0 if non-existent
	#verified by JL
	return ($answer);
}

sub does_file_exist_sref {

	my ($ref_file) = @_;

	if ($ref_file) {

		my $file = $$ref_file;

	# print("manage_files_by2,does_file_exist_sref,file name is, $$ref_file\n");

		# default situation is to have a file non-existent
		my $answer = 0;

		# -e returns 1 or ''
		# verified by JL
		# print("file for exist test is $$ref_file\n\n");
		# actually dies it exist and is it a plain file!!
		if ( -f $file ) {

			# print  ("file existence verified\n\n") ;
			$answer = 1;
		}

		#	answer=1 if existent and =0 if non-existent
		#verified by JL
		return ($answer);
	}
	else {
		print("does_file_exist_sref, ref_file is missing\n");
	}

}

=pod sub unique_elements

	filter out only unique elements from an array

=cut 

sub unique_elements {
	my ( $self, $array_ref ) = @_;

	my $results_ref;

	if ($array_ref) {

		my @unique_progs;
		my $total_num_progs4flow = scalar @{$array_ref};
		my $false                = 0;
		my $true                 = 1;
		my $num_unique_progs     = 1;

		my $seen = $true;
		$unique_progs[0] = @{$array_ref}[0];

		# print("manage_files_by2, program in flow: @{$array_ref}[0]\n");

		for ( my $i = 1; $i < $total_num_progs4flow; $i++ ) {

		# print("manage_files_by2, program in flow: @{$array_ref}[$i]\n");
		# print ("1. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");
			for ( my $j = 0; $j < $num_unique_progs; $j++ ) {

				if ( $unique_progs[$j] eq @{$array_ref}[$i] ) {

			# print("program index in flow=$i\n");
			# print(" 1. manage_files_by2,repeated program detected \n");
			# print("manage_files_by2, prog_ repeated: @{$array_ref}[]$i]\n\n");
					$seen = $true;

					# exit if-loop and increment $j
				}
				else {
	  # print("program index in flow=$i\n");
	  # print("manage_files_by2, prog @{array_ref}[]$i] is unique\n\n");
	  # print ("2. manage_files_by2,unique_prog detected=@{$array_ref}[$i] \n");
					$seen = $false;
				}
			}

			if ($seen) {
				$seen = $false;    #reset for next check
			}
			else {
				push @unique_progs, @{$array_ref}[$i];

		 # print(" 1. manage_files_by2,unique new program found for output \n");
				$num_unique_progs++;
			}

		}    # end all programs

		# print("3. manage_files_by2, unique_progs are: @unique_progs\n");
		# print ("3. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");

		$results_ref = \@unique_progs;
		return ($results_ref);

	}
	else {
		print("manage_files_by2,unique_elements, missing array\n");
		return ();

	}    # end if
}

=pod

 read in a 2-columned file
 reads cols 1 and 2 in a text file


=cut

sub read_2cols {

	my ( $variable, $ref_origin ) = @_;

	#declare locally scoped variables
	my ( $i, $line, $t, $x, $num_rows );
	my ( @TIME, @TIME_OUT, @OFFSET, @OFFSET_OUT );
	print("In this subroutine $$ref_origin\n");

	# open the file of interest
	open( FILE, $$ref_origin ) || print("Can't open. $$ref_origin \n");

	#set the counter
	$i = 1;

	# read contents of shotpoint geometry file
	while ( $line = <FILE> ) {

		#print("\n$line");
		chomp($line);
		( $t, $x ) = split( "  ", $line );
		$TIME[$i]   = $t;
		$OFFSET[$i] = $x;

		#print("\n $TIME[$i] $OFFSET[$i]\n");
		$i = $i + 1;

	}

	close(FILE);

	$num_rows = $i - 1;

	# print out the number of lines of data for the user
	#print ("\nThis file contains $num_rows row(s) of data\n");

	#   to prevent contaminating outside variables
	@TIME_OUT   = @TIME;
	@OFFSET_OUT = @OFFSET;

	return ( \@TIME_OUT, \@OFFSET_OUT, $num_rows );
}

=head2 sub read_par

 read parameter file
 file name is a scalar reference to 
 scalar file name

=cut 

sub read_par {

	my ( $self, $ref_file_name ) = @_;

# print ("\nmanage_files_by2,read_par,The input file is called $$ref_file_name\n");

=pod Steps

     1. open file

     2. set the counter

     3. read contents of parameter file

     4. odd-numbered lines contain tnmo and even contain vnmo
     

=cut

	open( FILE, $$ref_file_name ) || print("Can't open file_name, $!\n");

	my $row = -1;
	my (@Items);
	my ( $i,   $line );
	my ( @row, @ValuesPerRow );

	while ( $line = <FILE> ) {
		$row++;
		my @things;

		# print("manage_files_by2,read_par, $line");

=pod

 1. remove end of line
 2. calculate number of useful elements
 2. only leave the numbers with commas in between:
 	e.g. things=tnmo 0.0567282,0.271768
 	N.B. these are only 2 things and not 3 things

=cut

		chomp($line);
		@things = split /[=,]/, $line;
		print("manage_files_by2,read_par, things=@things, row= $row\n");
		$Items[$row]        = \@things;
		$ValuesPerRow[$row] = scalar(@things);

# print("manage_files_by2,read_par, ValuesPerRow=$ValuesPerRow[$row], row=$row\n");

	}
	close(FILE);

# print("manage_files_by2,read_par, ROW 0 $Items[0] \n");
# print("manage_files_by2,read_par, ROW 1 $Items[1]\n");
# print("manage_files_by2,read_par, ROW 0,1 number of titems: @ValuesPerRow\n");
	return ( \@Items, \@ValuesPerRow );

}

=pod

  set file name

=cut

sub set_fifo_name {

	my ( $self, $fifo_name ) = @_;

	if ( defined $fifo_name
		&& $fifo_name ne $empty_string )
	{

		$manage_files_by2->{_fifo_name} = $fifo_name;
		print("manage_files_by2,set_fifo_name:$fifo_name\n");

	}
	else {

		print("manage_files_by2,set_fifo_name. unexpected\n");
	}

}

=pod

  set file name

=cut

sub set_file_name {

	my ( $self, $file_name ) = @_;

	if ( defined $file_name
		&& $file_name ne $empty_string )
	{

		$manage_files_by2->{_file_name} = $file_name;

	}
	else {

		print("manage_files_by2,set_file_name. unexpected\n");
	}

}

=pod

  set format

=cut

sub set_format {

	my ( $self, $format ) = @_;

	if ( defined $format
		&& $format ne $empty_string )
	{

		$manage_files_by2->{_format} = $format;

		# print("manage_files_by2,set_format=$format\n");

	}
	else {

		print("manage_files_by2,set_format. unexpected\n");
	}

}

=head2 sub write_1col2fifo

  write out a 1-columned file to fifo

=cut

sub write_1col2fifo {

	# open and write to output file
	my ( $self, $X_aref ) = @_;

	if (   $manage_files_by2->{_fifo_name} ne $empty_string
		&& $manage_files_by2->{_format} ne $empty_string )
	{
	
		#declare locally scoped variables
		my $j;
		my $fmt = $manage_files_by2->{_format};

		my $num_rows  = scalar @$X_aref;
		my $fifo_name = $manage_files_by2->{_fifo_name};

		# $variable is an unused hash

		print("\nThe subroutine has is called $self\n");
		print("\nThe output file contains $num_rows rows\n");
		print("\nThe output file uses the following format: $fmt\n");
		use POSIX qw(mkfifo);
		unlink($fifo_name);
		mkfifo($fifo_name, 0777) or die "mkfifo($fifo_name) failed: $!";		

		open(FIFO, "> $fifo_name")  or die "error opening ...$!";

		# first line without <CR>
		printf FIFO "$fmt", @$X_aref[0];

		for ( $j = 1; $j < $num_rows; $j++ ) {

			# now <CR>
			printf FIFO "\n";

			# print OUT  ("@$X_aref[$j]\n");
			printf FIFO "$fmt", @$X_aref[$j];

			# print("@$X_aref[$j]\n");
		}

		# close(FIFO);

	}
	else {
		print("$manage_files_by2,write_1col, bad file name \n");
	}

}


=pod

  write out a 1-columned file

=cut

sub write_1col {

	# open and write to output file
	my ( $self, $X_aref ) = @_;

	if (   $manage_files_by2->{_file_name} ne $empty_string
		&& $manage_files_by2->{_format} ne $empty_string )
	{

		#declare locally scoped variables
		my $j;
		my $fmt = $manage_files_by2->{_format};

		my $num_rows  = scalar @$X_aref;
		my $file_name = $manage_files_by2->{_file_name};

		# $variable is an unused hash

		print("\nThe subroutine has is called $self\n");
		print("\nThe output file contains $num_rows rows\n");
		print("\nThe output file uses the following format: $fmt\n");
		open( OUT, ">$file_name" );

		# first line without <CR>
		printf OUT "$fmt", @$X_aref[0];

		for ( $j = 1; $j < $num_rows; $j++ ) {

			# now <CR>
			printf OUT "\n";

			# print OUT  ("@$X_aref[$j]\n");
			printf OUT "$fmt", @$X_aref[$j];

			# print("@$X_aref[$j]\n");
		}

		close(OUT);

	}
	else {
		print("$manage_files_by2,write_1col, bad file name \n");
	}

}

=pod

  write out a 2-columned file

=cut

sub write_2cols {

	# open and write to output file
	my ( $variable, $ref_X, $ref_Y, $num_rows, $ref_file_name, $ref_fmt ) = @_;

	#declare locally scoped variables
	my $j;

	# $variable is an unused hash

	#print("\nThe subroutine has is called $variable\n");
	#print("\nThe output file contains $num_rows rows\n");
	#print("\nThe output file uses the following format: $$ref_fmt\n");
	open( OUT, ">$$ref_file_name" );

	for ( $j = 1; $j <= $num_rows; $j++ ) {

		#print OUT  ("$$ref_X[$j] $$ref_Y[$j]\n");
		printf OUT "$$ref_fmt\n", $$ref_X[$j], $$ref_Y[$j];

		#print("$$ref_X[$j] $$ref_Y[$j]\n");
	}

	close(OUT);

}

=head2 sub write_par

 write parameter file
 file name is a scalar reference to 
 scalar file name

=cut 

sub write_par {

	my ( $self, $ref_outbound, $ref_array_tnmo_row, $ref_array_vnmo_row ) = @_;

	#print(
	#	"\nmanage_files_by2,write_par,The input file is called $$ref_outbound\n"
	#);

=head2 local definitions

=cut

	my $values_per_row;
	my @tnmo_array               = @$ref_array_tnmo_row;
	my @vnmo_array               = @$ref_array_vnmo_row;
	my $number_of_values_per_row = scalar @tnmo_array;

=pod Steps

     odd-numbered lines contain tnmo and even contain vnmo
     e.g., tnmo=1,2,3
     	   vnm==4,5,6
     
=cut

=head2 open and write values

=cut

	open( my $fh, '>', $$ref_outbound );

	print $fh ("tnmo=$tnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$tnmo_array[$i]");

	}

	print $fh ("\n");

	print $fh ("vnmo=$vnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$vnmo_array[$i]");

	}

	close($fh);
}

1;