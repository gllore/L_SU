
=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: L_SU.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017 

 DESCRIPTION 
     

 BASED ON:
 Version 0.1 April 18 2017 SeismicUnixPlTk.pl  
     Added a simple configuration file readable 
	flow
    and writable using Config::Simple (CPAN)

 Version 0.2 
    incorporate more object oriented classes
   
 Update: Simple (ASCII) local configuration 
      file is Project_Variables.config
      
 V 0.2.0 Jan 12 2018: removed all Config::Simple dependencies   
 V 0.3.0 May 14, 2018: refactored into L_SU.pm and L_SU.pl
 0
 Fall 2018
 V 0.3.1 makes Run = Save and Run
 Moves SaveAs to L_SU Menu and removes Save button
 
 V 0.3.2 has 4 flow panels
 
 V 0.3.3 has dragNdrop deactivated to stabilize version
 
 V 0.3.4 has classifies sunix programs using tabbed notebooks Sept. 12, 2018
 
 V0.3.7 removed all ticks from strings in GUIS using control module
     From now on users can write words with gaps and commas and L_SU will accept these
     value and formulate the correct Seismic Unix sytnax.
     
 V 0.3.8 Standardized format with PerlTidy, tidyviewer .perltidyrc Aug., 2019
 
 V 0.3.9 Introduce Moose attributes to handle GUI history in OOP style
 
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.3.9';

extends 'gui_history' => { -version => 0.0.2 };

use Tk;
use Tk::Pane;
use Tk::NoteBook;
use L_SU 0.1.5;
use L_SU_global_constants;

=head2 Instantiation

=cut

my $get         = L_SU_global_constants->new();
my $L_SU        = L_SU->new();
my $gui_history = gui_history->new();

=head2 Import Special Variables

=cut

my $var                           = $get->var();
my $on                            = $var->{_on};
my $true                          = $var->{_true};
my $false                         = $var->{_false};
my $empty_string                  = $var->{_empty_string};
my $flow_type                     = $get->flow_type_href();
my $alias_FileDialog_button_label = $get->alias_FileDialog_button_label_aref;
my $superflow_names_gui_aref      = $get->superflow_names_gui_aref();
my $file_dialog_type              = $get->file_dialog_type_href();
my $global_libs                   = $get->global_libs();

my @sunix_data_programs        = @{ $var->{_sunix_data_programs} };
my @sunix_datum_programs       = @{ $var->{_sunix_datum_programs} };
my @sunix_plot_programs        = @{ $var->{_sunix_plot_programs} };
my @sunix_filter_programs      = @{ $var->{_sunix_filter_programs} };
my @sunix_header_programs      = @{ $var->{_sunix_header_programs} };
my @sunix_inversion_programs   = @{ $var->{_sunix_inversion_programs} };
my @sunix_migration_programs   = @{ $var->{_sunix_migration_programs} };
my @sunix_shell_programs       = @{ $var->{_sunix_shell_programs} };
my @sunix_model_programs       = @{ $var->{_sunix_model_programs} };
my @sunix_NMO_Vel_Stk_programs = @{ $var->{_sunix_NMO_Vel_Stk_programs} };
my @sunix_par_programs         = @{ $var->{_sunix_par_programs} };
my @sunix_picks_programs       = @{ $var->{_sunix_picks_programs} };
my @sunix_shapeNcut_programs   = @{ $var->{_sunix_shapeNcut_programs} };
my @sunix_statsMath_programs   = @{ $var->{_sunix_statsMath_programs} };
my @sunix_transform_programs   = @{ $var->{_sunix_transform_programs} };
my @sunix_well_programs        = @{ $var->{_sunix_well_programs} };

=head2 Declare private variables

 flow_listbox_color_w   -listbox, input by user selection
 sunix_listbox   		-choice of listed sunix modules in a listbox
 
 flow_types: 'user_built flow' and 'pre_built_superflow'
 
 29 off, 4 off, 1 off9iAGABJIBAzUuMZgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwip09T9rMjqAhUJd6wKHWdJDGAQ4dUDCAs&uact=5

=cut

my ( $top_menu_frame, $top_titles_frame, $work_frame, $parameter_titles_frame, );
my ($side_menu_frame);
my ( $sunix_frame_top_row, $sunix_frame_bottom_row, $parameters_pane, $flow_control_frame );
my ( @param, @args );
my @values = qw//;

=head2 Define private variables

=cut

my $user_built          = $flow_type->{_user_built};
my $pre_built_superflow = $flow_type->{_pre_built_superflow};
my $no_color            = 'no_color';

=head2 Default Tk settings{

 Create scoped hash 
 43 off

=cut

my $main_href = $gui_history->get_defaults();

=head2 Set gui_history conditions for debugging

=cut

# $gui_history->set_log_view($true);

=head2 L_SU Window contains

 a top menu frame 
 a middle menu titles frame
 and a
 bottom  work_frame
 font is made to be arial normal 14
 border width is defaulted too

=cut

( $main_href->{_mw} ) = MainWindow->new;
( $main_href->{_mw} )->title( $var->{_program_title} );
( $main_href->{_mw} )->geometry( $var->{_box_position} );
( $main_href->{_mw} )->resizable( 0, 0 );    # not resizable in either width or height
( $main_href->{_mw} )->focusFollowsMouse;


=head2 Define 
  
  fonts to use in the menu

=cut

my $garamond = ( $main_href->{_mw} )->fontCreate(
	'garamond',
	-family => 'garamond',
	-weight => 'normal',
	-size   => -14
);

my $arial_14 = ( $main_href->{_mw} )->fontCreate(
	'arial_14',
	-family => 'arial',
	-weight => 'normal',
	-size   => -14
);

my $arial_16 = ( $main_href->{_mw} )->fontCreate(
	'arial_16',
	-family => 'arial',
	-weight => 'normal',
	-size   => -16
);

my $arial_notebooks = $arial_14;

my $arial_18 = ( $main_href->{_mw} )->fontCreate(
	'arial_18',
	-family => 'arial',
	-weight => 'normal',
	-size   => -18
);

my $arial_12 = ( $main_href->{_mw} )->fontCreate(
	'arial_12',
	-family => 'arial',
	-weight => 'normal',
	-size   => -12
);

my $arial_italic_18 = ( $main_href->{_mw} )->fontCreate(
	'arial_italic_18',
	-family => 'arial',
	-weight => 'normal',
	-slant  => 'italic',
	-size   => -18
);

my $arial_18_bold = ( $main_href->{_mw} )->fontCreate(
	'arial_18_bold',
	-family => 'arial',
	-weight => 'bold',
	-size   => -18
);

my $arial_italic_large = $arial_italic_18;

my $arial_italic_12 = ( $main_href->{_mw} )->fontCreate(
	'arial_italic_small',
	-family => 'arial',
	-weight => 'normal',
	-slant  => 'italic',
	-size   => -12
);
my $arial_italic_medium = $arial_italic_12;

my $arial_italic_very_small = ( $main_href->{_mw} )->fontCreate(
	'arial_italic_very_small',
	-family => 'arial',
	-slant  => 'italic',
	-weight => 'normal',
	-size   => -9
);

my $small_garamond = ( $main_href->{_mw} )->fontCreate(
	'small_garamond',
	-family => 'garamond',
	-weight => 'normal',
	-size   => -9
);

$top_menu_frame = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-background  => $var->{_my_purple},
	-relief      => 'groove'
);

$side_menu_frame = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-background  => $var->{_my_purple},
	-relief      => 'groove'
);

=head2 load images
Button bitmaps and pixmaps
XXX_cartoon image is used to delete
a seismic unix program from the flow

=cut

my $cross_cartoon =
	( $main_href->{_mw} )->Pixmap( -file => $global_libs->{_images} . 'cross.xpm', );
my $minus_cartoon =
	( $main_href->{_mw} )->Pixmap( -file => $global_libs->{_images} . 'minus.xpm', );
my $flow_item_up_arrow =
	( $main_href->{_mw} )->Bitmap( -file => $global_libs->{_images} . 'file_item_up_arrow.xbm', );
my $flow_item_down_arrow = ( $main_href->{_mw} )->Bitmap( -file => $global_libs->{_images} . 'file_item_down_arrow.xbm', );

=head2  top menu frame
Contains:
(1) top menus
for superflows
and (2) icons for (a) wiping plots 
 
help goes to superflow bindings 

=cut

$main_href->{_superflow_select} = $top_menu_frame->Menubutton(
	-text               => 'Tools',
	-font               => $arial_16,
	-height             => 1,
	-width              => 6,
	-padx               => $var->{_five_pixels},
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat'
);

my $top_menu_bar = ( $main_href->{_superflow_select} )->Menu( -font => $arial_16 );

$top_menu_bar->bind( '<ButtonRelease-3>' => [ \&_L_SU_superflow_bindings, 'help' ], );

=head2 Top menu frame icon
wipe background plots
enable from the start

=cut 

$main_href->{_wipe_plots_button} = $top_menu_frame->Button(
	-image              => $cross_cartoon,
	-height             => $var->{_18_pixels},
	-border             => 0,
	-padx               => 8,
	-width              => $var->{_18_pixels},
	-background         => $var->{_my_light_grey},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'active',
);

=head2 Top title reminders for Selected flow and Superflow names


=cut 

my $top_menu_frame_spacer = $top_menu_frame->Label(
	-text               => "\t\t\t\t",
	-font               => $arial_16,
	-height             => $var->{_one_character},
	-border             => $var->{_no_pixel},
	-anchor             => 'center',
	-width              => 0,
	-padx               => 0,
	-height             => 1,
	-width              => $var->{_thirty_characters},
	-padx               => $var->{_five_pixels},
	-background         => $var->{_my_purple},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat'
);

$main_href->{_flowNsuperflow_name_w} = $top_menu_frame->Label(
	-text               => 'Flow Name',
	-anchor             => 'center',
	-font               => $arial_italic_large,
	-height             => $var->{_one_character},
	-border             => $var->{_no_pixel},
	-padx               => 0,
	-height             => 1,
	-width              => $var->{_thirty_characters},
	-padx               => $var->{_five_pixels},
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
);

=pod
    $args[0] = $superflow_names->{_ProjectVariables}; (OLD)
	print("main, _Project: $args[0]\n");
	print("main,sflows:$sflows\n");
	print("main,$length_sflows\n");
	
=cut

=head2 give user superflow names

=cut

@args = @$superflow_names_gui_aref;
my $length_sflows = ( scalar @args ) - 1;    # last member is "temp"

( $main_href->{_superflow_select} )->configure( -menu => $top_menu_bar );

for ( my $sflows = 0; $sflows < $length_sflows; $sflows++ ) {
	$main_href->{_superflow_select}->command(
		-label     => $args[$sflows],
		-underline => 0,
		-font      => $arial_16,
		-command   => [ \&_L_SU_superflows, 'pre_built_superflows', \$args[$sflows] ],
	);
}

=pod tied button widgets
to a tool_array
for easier management
bind MB3 to help
my @who;
my $this=0;

$who[$this] = $top_menu_bar->focusCurrent;
print(" who is @who\n");
my $a =$top_menu_bar->bind();
print(" bind is @$a\n");
my $class = ref $top_menu_bar;
print "Button \\$top_menu_bar is an instance of class '$class'.\n" .
      "This class has bindings for these events:\n\n";
print join("\n", $top_menu_bar->bind($class) ), "\n";

=cut

=head2  side menu frame

 contains side menus
 1. for files

=cut

$main_href->{_file_menubutton} = $side_menu_frame->Menubutton(
	-text               => 'File',
	-font               => $arial_16,
	-height             => 1,
	-relief             => 'flat',
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
);

my $side_menu_bar = ( $main_href->{_file_menubutton} )->Menu( -font => $arial_16 );

( $main_href->{_file_menubutton} )->configure( -menu => $side_menu_bar );

( $main_href->{_file_menubutton} )->separator;
my @File_option;
$File_option[0] = $file_dialog_type->{_Data};
$File_option[1] = $file_dialog_type->{_Flow};
$File_option[2] = $file_dialog_type->{_SaveAs};

$main_href->{_Data_menubutton} = ( $main_href->{_file_menubutton} )->command(
	-label     => @$alias_FileDialog_button_label[0],
	-underline => 0,
	-state     => 'disabled',
	-command   => [ \&_L_SU, 'FileDialog_button', \$File_option[0] ],
	-font      => $arial_16
);

# Flow is the only button enabled from the start
# in order to open a user-built perl flow
( $main_href->{_file_menubutton} )->separator;
$main_href->{_Flow_menubutton} = ( $main_href->{_file_menubutton} )->command(
	-label     => @$alias_FileDialog_button_label[1],
	-underline => 0,
	-command   => [ \&_L_SU, 'FileDialog_button', \$File_option[1] ],
	-font      => $arial_16,
);

( $main_href->{_file_menubutton} )->separator;
$main_href->{_SaveAs_menubutton} = ( $main_href->{_file_menubutton} )->command(
	-label     => @$alias_FileDialog_button_label[2],
	-underline => 0,
	-state     => 'disabled',
	-command   => [ \&_L_SU, 'FileDialog_button', \$File_option[2] ],
	-font      => $arial_16
);

$top_titles_frame = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => $var->{_light_gray},
	-relief      => 'groove'
);

$main_href->{_parameter_menu_frame} = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => $var->{_light_gray},
	-relief      => 'groove'
);
$parameter_titles_frame = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => $var->{_light_gray},
	-relief      => 'groove'
);

=head2  side menu frame
contains side menus
 2. for action 

=cut

my $Run_option = 'Run';
$main_href->{_run_button} = $side_menu_frame->Button(
	-text               => 'Run',
	-font               => $arial_16,
	-height             => 1,
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU, 'run_button', \$Run_option ],
);

my $Save_option = 'Save';
$main_href->{_save_button} = $side_menu_frame->Button(
	-text               => 'Save',
	-font               => $arial_16,
	-height             => 1,
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU, 'save_button', \$Save_option ],
);

my $Check_code_option = 'Check';
$main_href->{_check_code_button} = $side_menu_frame->Button(
	-text               => 'Check',
	-font               => $arial_16,
	-height             => 1,
	-background         => $var->{_my_yellow},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU, 'check_code_button', \$Check_code_option ],
);

=head2 top_titles frame
above the work frame
contains Titles only 

=cut

my $top_titles_spacer = $top_titles_frame->Label(
	-text       => "spacer",
	-font       => $arial_16,
	-height     => $var->{_one_character},
	-border     => $var->{_no_pixel},
	-width      => 0,
	-padx       => 0,
	-background => $var->{_light_gray},
	-relief     => 'groove'
);

$main_href->{_add2flow_button_grey} = ( $main_href->{_parameter_menu_frame} )->Button(
	-text               => '   Flow -+->',
	-font               => $arial_16,
	-height             => 1,
	-width              => 3,
	-padx               => 28,
	-background         => $var->{_my_light_grey},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_black},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU_add2flows, 'add2flow_button', 'grey' ],
);

$main_href->{_add2flow_button_pink} = ( $main_href->{_parameter_menu_frame} )->Button(
	-text               => '2. -+->',
	-font               => $arial_16,
	-height             => 1,
	-width              => 3,
	-background         => $var->{_my_pink},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_black},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU_add2flows, 'add2flow_button', 'pink' ],
);

$main_href->{_add2flow_button_green} = ( $main_href->{_parameter_menu_frame} )->Button(
	-text               => '3. -+->',
	-font               => $arial_16,
	-height             => 1,
	-width              => 3,
	-background         => $var->{_my_light_green},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU_add2flows, 'add2flow_button', 'green' ],
);

$main_href->{_add2flow_button_blue} = ( $main_href->{_parameter_menu_frame} )->Button(
	-text               => '4. -+->',
	-font               => $arial_16,
	-height             => 1,
	-width              => 3,
	-background         => $var->{_my_light_blue},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
	-command            => [ \&_L_SU_add2flows, 'add2flow_button', 'blue' ]
);

$main_href->{_delete_from_flow_button} = ( $main_href->{_parameter_menu_frame} )->Button(
	-image              => $minus_cartoon,
	-height             => $var->{_24_pixels},
	-border             => 0,
	-padx               => 8,
	-width              => $var->{_12_pixels},
	-background         => $var->{_my_light_grey},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
);

=pod

button that moves items (program names) UP in a flow (color grey, pink, green or blue);
 up within a listbox

=cut

$main_href->{_flow_item_up_arrow_button} = ( $main_href->{_parameter_menu_frame} )->Button(
	-image              => $flow_item_up_arrow,
	-height             => $var->{_24_pixels},
	-border             => 0,
	-padx               => 8,
	-width              => $var->{_12_pixels},
	-background         => $var->{_my_light_grey},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
);

=pod

 button that moves items (program names) DOWN in a flow (color grey, pink, green or blue);
 down within a listbox

=cut

$main_href->{_flow_item_down_arrow_button} = ( $main_href->{_parameter_menu_frame} )->Button(
	-image              => $flow_item_down_arrow,
	-height             => $var->{_24_pixels},
	-border             => 0,
	-padx               => 8,
	-width              => $var->{_12_pixels},
	-background         => $var->{_my_light_grey},
	-foreground         => $var->{_my_black},
	-disabledforeground => $var->{_my_dark_grey},
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-relief             => 'flat',
	-state              => 'disabled',
);

=head2 Listbox widgets
tied to button action
for easier management

=cut

( $main_href->{_delete_from_flow_button} )->bind( '<1>' => [ \&_L_SU_flow_bindings_any_color, 'delete_from_flow_button' ], );

( $main_href->{_flow_item_up_arrow_button} )->bind( '<1>' => [ \&_L_SU_flow_bindings_any_color, 'flow_item_up_arrow_button' ], );

( $main_href->{_flow_item_down_arrow_button} )->bind( '<1>' => [ \&_L_SU_flow_bindings_any_color, 'flow_item_down_arrow_button' ], );

( $main_href->{_wipe_plots_button} )->bind( '<1>' => [ \&_L_SU_bindings_shell, 'wipe_plots_button' ], );

$work_frame = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => 'yellow',
	-relief      => 'groove'
);

=head2 work frame
has menu items to its left
contains a sunix_frame at its top, 
a parameters_pane (with names value buttons and values) in the middle left
and four listboxes contained in a module-sequences frame on the middle right
and a message text area across the whole bottom
 
=cut

=head2 sunix_frame
The sunix_frame itself contains five stories
sub-frames called sunix_frame_I through and sunix_frame_V
(levels 1 through 5)
 
=cut 

$sunix_frame_top_row = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',

	#-width       	=> $var->{_11_characters},
	-background => $var->{_my_purple},
);
$sunix_frame_bottom_row = ( $main_href->{_mw} )->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',

	#-width       	=> $var->{_11_characters},
	-background => $var->{_my_purple},
);
my $sunix_frame_V = $sunix_frame_top_row->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',
	-width       => $var->{_11_characters},
	-height      => '10',
	-background  => $var->{_my_purple},
);
my $sunix_frame_IV = $sunix_frame_top_row->Frame(
	-borderwidth => $var->{_no_borderwidth},

	#                          	-pady			=> $var->{_one_pixel},
	-relief     => 'flat',
	-width      => $var->{_11_characters},
	-height     => '10',
	-background => $var->{_my_purple},
);
my $sunix_frame_III = $sunix_frame_top_row->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',
	-width       => $var->{_11_characters},
	-height      => '10',
	-background  => $var->{_my_purple},
);
my $sunix_frame_II = $sunix_frame_top_row->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',
	-width       => $var->{_11_characters},
	-height      => '10',
	-background  => $var->{_my_purple},
);

my $sunix_frame_I = $sunix_frame_bottom_row->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'flat',
	-width       => $var->{_11_characters},
	-height      => '10',
	-background  => $var->{_my_purple},
);

=head2 Notebooks 
within sunix_frame_V (top row)

 
=cut  

my $sunix_programs_V_book = $sunix_frame_V->NoteBook(
	-font          => $arial_notebooks,
	-borderwidth   => $var->{_no_borderwidth},
	-backpagecolor => $var->{_my_purple},
);

my $sunix_data_programs_tab  = $sunix_programs_V_book->add( "data programs tab",  -label => "data" );
my $sunix_datum_programs_tab = $sunix_programs_V_book->add( "datum programs tab", -label => "datum" );

my $sunix_plot_programs_tab = $sunix_programs_V_book->add( "plot programs tab", -label => "plot" );

my $sunix_filter_programs_tab = $sunix_programs_V_book->add( "filter programs tab", -label => "filter", );
my $sunix_data_programs_listbox = $sunix_data_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_datum_programs_listbox = $sunix_datum_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_plot_programs_listbox = $sunix_plot_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);
my $sunix_filter_programs_listbox = $sunix_filter_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

$sunix_data_programs_listbox->insert( "end", sort @sunix_data_programs, );

$sunix_datum_programs_listbox->insert( "end", sort @sunix_datum_programs, );

$sunix_plot_programs_listbox->insert( "end", sort @sunix_plot_programs, );
$sunix_filter_programs_listbox->insert( "end", sort @sunix_filter_programs, );

=head2 Notebooks
within sunix_frame_IV (top row)

=cut  

my $sunix_programs_IV_book = $sunix_frame_IV->NoteBook(
	-font          => $arial_notebooks,
	-borderwidth   => $var->{_no_borderwidth},
	-backpagecolor => $var->{_my_purple},
);

my $sunix_header_programs_tab = $sunix_programs_IV_book->add( "header programs tab", -label => "header" );

my $sunix_inversion_programs_tab = $sunix_programs_IV_book->add( "inversion programs tab", -label => "inversion" );

my $sunix_migration_programs_tab = $sunix_programs_IV_book->add( "migration programs tab", -label => "migration", );

my $sunix_header_programs_listbox = $sunix_header_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_inversion_programs_listbox = $sunix_inversion_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_migration_programs_listbox = $sunix_migration_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

$sunix_header_programs_listbox->insert( "end", sort @sunix_header_programs, );

$sunix_inversion_programs_listbox->insert( "end", sort @sunix_inversion_programs, );

$sunix_migration_programs_listbox->insert( "end", sort @sunix_migration_programs, );

=head2 Notebooks within 
sunix_frame_III (top row)

 
=cut  

my $sunix_programs_III_book = $sunix_frame_III->NoteBook(
	-font          => $arial_notebooks,
	-borderwidth   => $var->{_no_borderwidth},
	-backpagecolor => $var->{_my_purple},
);

my $sunix_model_programs_tab = $sunix_programs_III_book->add( "model programs tab", -label => "model" );

my $sunix_NMO_Vel_Stk_programs_tab = $sunix_programs_III_book->add( "NMO_Vel_Stk programs tab", -label => "NMO_Vel_Stk" );

my $sunix_par_programs_tab = $sunix_programs_III_book->add( "par programs tab", -label => "par", );

my $sunix_picks_programs_tab = $sunix_programs_III_book->add( "picks programs tab", -label => "picks", );

my $sunix_model_programs_listbox = $sunix_model_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_NMO_Vel_Stk_programs_listbox = $sunix_NMO_Vel_Stk_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_par_programs_listbox = $sunix_par_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_picks_programs_listbox = $sunix_picks_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

$sunix_model_programs_listbox->insert( "end", sort @sunix_model_programs, );

$sunix_NMO_Vel_Stk_programs_listbox->insert( "end", sort @sunix_NMO_Vel_Stk_programs, );

$sunix_par_programs_listbox->insert( "end", sort @sunix_par_programs, );

$sunix_picks_programs_listbox->insert( "end", sort @sunix_picks_programs, );

=head2 Notebooks within
sunix_frame_II (top row )

 
=cut 

my $sunix_programs_II_book = $sunix_frame_II->NoteBook(
	-font          => $arial_notebooks,
	-borderwidth   => $var->{_no_borderwidth},
	-backpagecolor => $var->{_my_purple},
);

my $sunix_shapeNcut_programs_tab = $sunix_programs_II_book->add( "shapeNcut programs tab", -label => "shapeNcut", );

my $sunix_shell_programs_tab = $sunix_programs_II_book->add( "shell programs tab", -label => "shell", );

my $sunix_statsMath_programs_tab = $sunix_programs_II_book->add( "statsMath programs tab", -label => "statsMath", );

my $sunix_shapeNcut_programs_listbox = $sunix_shapeNcut_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_shell_programs_listbox = $sunix_shell_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_statsMath_programs_listbox = $sunix_statsMath_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

$sunix_shapeNcut_programs_listbox->insert( "end", sort @sunix_shapeNcut_programs, );

$sunix_shell_programs_listbox->insert( "end", sort @sunix_shell_programs, );

$sunix_statsMath_programs_listbox->insert( "end", sort @sunix_statsMath_programs, );

=head2 Notebooks within 
sunix_frame_I (bottom row )

 
=cut 

my $sunix_programs_I_book = $sunix_frame_I->NoteBook(
	-font          => $arial_notebooks,
	-borderwidth   => $var->{_no_borderwidth},
	-backpagecolor => $var->{_my_purple},
);

my $sunix_transform_programs_tab = $sunix_programs_I_book->add( "transform programs tab", -label => "transform" );

my $sunix_well_programs_tab = $sunix_programs_I_book->add( "well programs tab", -label => "well", );

my $sunix_transform_programs_listbox = $sunix_transform_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

my $sunix_well_programs_listbox = $sunix_well_programs_tab->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_2_lines},
	-width       => $var->{_11_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_no_borderwidth}
);

$sunix_transform_programs_listbox->insert( "end", sort @sunix_transform_programs, );

$sunix_well_programs_listbox->insert( "end", sort @sunix_well_programs, );

=head2 Notebooks within 
sunix_frame_I (bottom row )

 
=cut	             			             			             											

=head2 tied listbox widgets

  to a tool_array
  for easier management
  
  This binding occurs inside L_SU.pm and NOT
  within the current program

=cut

$sunix_data_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'data' ] );
$sunix_datum_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'datum' ] );
$sunix_plot_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'plot' ] );
$sunix_filter_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'filter' ] );
$sunix_header_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'header' ] );
$sunix_inversion_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'inversion' ] );
$sunix_migration_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'migration' ] );

$sunix_model_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'model' ] );
$sunix_NMO_Vel_Stk_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'NMO_Vel_Stk' ] );
$sunix_par_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'par' ] );
$sunix_picks_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'picks' ] );

$sunix_shapeNcut_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'shapeNcut' ] );

# TODO return to 'neutral'
$sunix_shell_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'shell' ] );
$sunix_statsMath_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'statsMath' ] );
$sunix_transform_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'transform' ] );
$sunix_well_programs_listbox->bind( '<1>' => [ \&_L_SU_sunix_bindings, 'sunix_select', 'neutral', 'well' ] );

$sunix_data_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'data' ]    #TODO return to 'neutral'
);
$sunix_datum_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'datum' ]    #TODo return to 'neutral'
);
$sunix_plot_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'plot' ]     #TODo return to 'neutral'
);
$sunix_filter_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'filter' ]    #TODo return to 'neutral'
);

$sunix_header_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'header' ]    #TODo return to 'neutral'
);
$sunix_inversion_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'inversion' ]    #TODo return to 'neutral'
);
$sunix_migration_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'migration' ]    #TODo return to 'neutral'
);
$sunix_model_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'model' ]        #TODo return to 'neutral'
);
$sunix_NMO_Vel_Stk_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'NMO_Vel_Stk' ]    #TODo return to 'neutral'
);
$sunix_par_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'par' ]            #TODo return to 'neutral'
);
$sunix_picks_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'picks' ]          #TODo return to 'neutral'
);

$sunix_shapeNcut_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'shapeNcut' ]      #TODo return to 'neutral'
);
$sunix_shell_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'shell' ]          #TODo return to 'neutral'
);
$sunix_statsMath_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'statsMath' ]      #TODo return to 'neutral'
);
$sunix_transform_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'transform' ]      #TODo return to 'neutral'
);
$sunix_well_programs_listbox->bind(
	'<3>' => [ \&_L_SU_sunix_bindings, 'help', 'neutral', 'well' ]           #TODo return to 'neutral'
);

=head2 parameter_titles label

 immediteley above the parameters frame
 both of which are contained in the work frame
 contains Titles only 

=cut  

my $parameter_titles_label = $parameter_titles_frame->Label(
	-text       => "\t" . 'Parameter Names' . "\t\t\t" . 'Values',
	-font       => $arial_16,
	-height     => $var->{_one_character},
	-border     => $var->{_no_pixel},
	-width      => 0,
	-padx       => 0,
	-background => $var->{_light_gray},
	-relief     => 'groove'
);

=head2 parameters frame

 Parameters from
 Tools and Su Modules


=cut

$parameters_pane = $work_frame->Scrolled(
	"Pane",
	-background => $var->{_my_purple},
	-relief     => 'groove',
	-scrollbars => "e",
	-sticky     => 'ns',

	#-width			=> 400,
	#-padx			=> 10,
);

=head2  input frame

 Contains, left-to-right:

 a parameter_names_frame 
 a stack of radio buttons 
 and a values_frame  

 Choose whether to ignore/deactivate or apply
 the parameter-value pairs later on

 To solicit and modify
 possibly existing
 parameter value input
 
 N.B. widths are controlled within label_box.pm and value_box.pm

=cut

$main_href->{_parameter_values_frame} = $parameters_pane->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => $var->{_my_purple},
	-relief      => 'flat',
);

$main_href->{_parameter_names_frame} = $parameters_pane->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-background  => $var->{_my_black},
	-relief      => 'flat',
);

$main_href->{_parameter_values_button_frame} = $parameters_pane->Frame(
	-borderwidth => $var->{_one_pixel_borderwidth},
	-background  => $var->{_my_purple},
	-relief      => 'flat',
);

=head2 message area 

      to notify user of important events 

=cut

$main_href->{_message_w} = $work_frame->Text(
	-height     => $var->{_3_lines},
	-font       => $arial_16,
	-foreground => $var->{_my_white},
	-background => $var->{_my_black},
);

=head2 workflow_control_frame

 on far right of work frame
 contains scrolled flow listboxes

=cut

$flow_control_frame = $work_frame->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'groove',
	-width       => '250',
	-background  => 'pink',
);

=head2 workflow_control_frame

 two vertically stacked frames 
 each holding two 'Fs

=cut

my $flow_control_frame_names4top_row = $flow_control_frame->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'groove',

	#-width       	=> '400',
	-height     => '1',
	-background => 'purple',
);

my $flow_control_frame_top_row = $flow_control_frame->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'groove',

	#-width       	=> '400',
	-height     => '150',
	-background => 'purple',
);

my $flow_control_frame_names4bottom_row = $flow_control_frame->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'groove',

	#-width       	=> '400',
	-height     => '1',
	-background => 'purple',
);

my $flow_control_frame_bottom_row = $flow_control_frame->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-relief      => 'groove',

	#-width       	=> '400',
	-height     => '150',
	-background => 'purple',
);

=head2 workflow_control_frame

 includes flow names

=cut

$main_href->{_flow_name_grey_w} = $flow_control_frame_names4top_row->Label(

	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-anchor             => 'w',
	-background         => $var->{_my_yellow},
	-border             => $var->{_no_pixel},
	-disabledforeground => $var->{_my_dark_grey},
	-font               => $arial_italic_medium,
	-foreground         => $var->{_my_black},
	-height             => $var->{_one_character},
	-padx               => $var->{_five_pixels},
	-relief             => 'flat',
	-state              => 'disabled',
	-text               => 'grey name',
	-width              => $var->{_14_characters},
);

$main_href->{_flow_name_pink_w} = $flow_control_frame_names4top_row->Label(

	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-anchor             => 'w',
	-background         => $var->{_my_yellow},
	-border             => $var->{_no_pixel},
	-disabledforeground => $var->{_my_dark_grey},
	-font               => $arial_italic_medium,
	-foreground         => $var->{_my_black},
	-height             => $var->{_one_character},
	-padx               => $var->{_five_pixels},
	-relief             => 'flat',
	-state              => 'disabled',
	-text               => 'pink name',
	-width              => $var->{_14_characters},
);

$main_href->{_flow_name_green_w} = $flow_control_frame_names4bottom_row->Label(

	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-anchor             => 'w',
	-background         => $var->{_my_yellow},
	-border             => $var->{_no_pixel},
	-disabledforeground => $var->{_my_dark_grey},
	-font               => $arial_italic_medium,
	-foreground         => $var->{_my_black},
	-height             => $var->{_one_character},
	-padx               => $var->{_five_pixels},
	-relief             => 'flat',
	-state              => 'disabled',
	-text               => 'green name',
	-width              => $var->{_14_characters},
);

$main_href->{_flow_name_blue_w} = $flow_control_frame_names4bottom_row->Label(
	-activeforeground   => $var->{_my_white},
	-activebackground   => $var->{_my_dark_grey},
	-anchor             => 'w',
	-background         => $var->{_my_yellow},
	-border             => $var->{_no_pixel},
	-disabledforeground => $var->{_my_dark_grey},
	-font               => $arial_italic_medium,
	-foreground         => $var->{_my_black},
	-height             => $var->{_one_character},
	-padx               => $var->{_five_pixels},
	-relief             => 'flat',
	-state              => 'disabled',
	-text               => 'blue name',
	-width              => $var->{_14_characters},
);

$main_href->{_flow_listbox_grey_w} = $flow_control_frame_top_row->Scrolled(
	"Listbox",
	-scrollbars       => "osoe",
	-height           => $var->{_7_lines},
	-width            => $var->{_12_characters},
	-selectmode       => "single",
	-borderwidth      => $var->{_one_pixel_borderwidth},
	-foreground       => $var->{_my_black},
	-background       => $var->{_my_light_grey},
	-relief           => 'flat',
	-selectforeground => $var->{_my_white},
	-selectbackground => $var->{_my_dark_grey},
	-state            => 'disabled',
);

$main_href->{_flow_listbox_pink_w} = $flow_control_frame_top_row->Scrolled(
	"Listbox",
	-scrollbars       => "osoe",
	-height           => $var->{_7_lines},
	-width            => $var->{_12_characters},
	-selectmode       => "single",
	-borderwidth      => $var->{_one_pixel_borderwidth},
	-foreground       => $var->{_my_black},
	-background       => $var->{_my_pink},
	-relief           => 'flat',
	-selectforeground => $var->{_my_white},
	-selectbackground => $var->{_my_dark_grey},
	-state            => 'disabled',
);

$main_href->{_flow_listbox_green_w} = $flow_control_frame_bottom_row->Scrolled(
	"Listbox",
	-scrollbars       => "osoe",
	-height           => $var->{_7_lines},
	-width            => $var->{_12_characters},
	-selectmode       => "single",
	-borderwidth      => $var->{_one_pixel_borderwidth},
	-foreground       => $var->{_my_black},
	-background       => $var->{_my_light_green},
	-relief           => 'flat',
	-selectforeground => $var->{_my_white},
	-selectbackground => $var->{_my_dark_grey},
	-state            => 'disabled',
);

$main_href->{_flow_listbox_blue_w} = $flow_control_frame_bottom_row->Scrolled(
	"Listbox",
	-scrollbars  => "osoe",
	-height      => $var->{_7_lines},
	-width       => $var->{_12_characters},
	-selectmode  => "single",
	-borderwidth => $var->{_one_pixel_borderwidth},
	-foreground  => $var->{_my_black},
	-background  => $var->{_my_light_blue},

	-relief           => 'flat',
	-selectforeground => $var->{_my_white},
	-selectbackground => $var->{_my_dark_grey},
	-state            => 'disabled',
);

=head2 tied flow listbox widgets

  to a tool_array
  for easier management
  
  # could also be done in L_SU.pm/param_widgets

=cut

( $main_href->{_flow_listbox_grey_w} )->bind( '<1>' => [ \&_L_SU_flow_bindings, 'flow_select', 'grey' ], );
( $main_href->{_flow_listbox_grey_w} )->bind( '<3>' => [ \&_L_SU_flow_bindings, 'help',        'grey' ] );

( $main_href->{_flow_listbox_pink_w} )->bind( '<1>' => [ \&_L_SU_flow_bindings, 'flow_select', 'pink' ], );
( $main_href->{_flow_listbox_pink_w} )->bind( '<3>' => [ \&_L_SU_flow_bindings, 'help',        'pink' ] );

( $main_href->{_flow_listbox_green_w} )->bind( '<1>' => [ \&_L_SU_flow_bindings, 'flow_select', 'green' ], );
( $main_href->{_flow_listbox_green_w} )->bind( '<3>' => [ \&_L_SU_flow_bindings, 'help',        'green' ] );

( $main_href->{_flow_listbox_blue_w} )->bind( '<1>' => [ \&_L_SU_flow_bindings, 'flow_select', 'blue' ], );
( $main_href->{_flow_listbox_blue_w} )->bind( '<3>' => [ \&_L_SU_flow_bindings, 'help',        'blue' ] );

=head2 Packing Frame widget 
 contianed within L_SU menu frame

=cut     

$top_menu_frame->pack(
	-side => "top",
	-fill => 'x',
);
$top_titles_frame->pack(
	-side => "top",
	-fill => 'x'
);

$side_menu_frame->pack(
	-side => "left",
	-fill => "both"
);

$sunix_frame_top_row->pack(
	-side => "top",
	-fill => "y",
);
$sunix_frame_bottom_row->pack(
	-side => "top",
	-fill => "x",
);

# top menu frame
( $main_href->{_superflow_select} )->pack(
	-side => "left",
	-fill => 'y'
);

( $main_href->{_wipe_plots_button} )->pack(
	-side => "left",
	-fill => 'y'
);

$top_menu_frame_spacer->pack(
	-side => "left",
	-fill => 'y'
);

( $main_href->{_flowNsuperflow_name_w} )->pack(
	-side => "left",
	-fill => 'y'
);

#side menu frame
( $main_href->{_file_menubutton} )->pack(
	-side => "top",
	-fill => 'x'
);

( $main_href->{_run_button} )->pack(
	-side => "top",
	-fill => 'x',
);
( $main_href->{_save_button} )->pack(
	-side => "top",
	-fill => 'x',
);

#$main_href->{_check_code_button}	    ->pack(
#                        -side  	=> "top",
#		    			-fill   => 'x',
#                        );
# within top_titles_frame

=pod
	work frame contains, left-to-right
	a parameters_pane,
	a flow frame (yellow)
	and four listboxes contained in a module-sequences frame on the far right
	The side menu frame is to its far left.
	
=cut	          

( $main_href->{_message_w} )->pack(
	-side => "bottom",
	-fill => 'x',
);

#    # top titles frame
#    # contains only a spacer
#    $top_titles_spacer  	->pack(
#							-side  	=> "left",
#                            );
( $main_href->{_parameter_menu_frame} )->pack(
	-side => "top",
	-fill => "x",
);

# my $add2flow_button_grey = ($main_href->{_add2flow_button_grey});
( $main_href->{_add2flow_button_grey} )->pack( -side => "left", );
( $main_href->{_add2flow_button_pink} )->pack( -side => "left", );
( $main_href->{_add2flow_button_green} )->pack( -side => "left", );
( $main_href->{_add2flow_button_blue} )->pack( -side => "left", );

# $delete_from_flow_button->pack( -side => "right", );
( $main_href->{_flow_item_up_arrow_button} )->pack( -side => "right", );
( $main_href->{_flow_item_down_arrow_button} )->pack( -side => "right", );
( $main_href->{_delete_from_flow_button} )->pack( -side => "right", );

# parameter titles belongs to L_SU frame
# and contains the following
$parameter_titles_frame->pack(
	-side => "top",
	-fill => "x",
);

$parameter_titles_label->pack(
	-side => "left",
	-fill => "x",
);

# work frame belongs to L_SU frame
$work_frame->pack(
	-side => "left",
	-fill => "y",
);

#  work pane contains the following
$parameters_pane->pack(
	-side => "left",
	-fill => "y",

);

$flow_control_frame->pack(
	-side   => "left",
	-fill   => "both",
	-expand => 1,
);

# pack contents of parameters_pane
$sunix_frame_V->pack(
	-side => "left",
	-fill => "y",
);

$sunix_frame_IV->pack(
	-side => "left",
	-fill => "y",
);

$sunix_frame_III->pack(
	-side => "left",
	-fill => "y",
);
$sunix_frame_II->pack(
	-side => "left",
	-fill => "y",
);

$sunix_frame_I->pack(
	-side => "left",
	-fill => "y",
);

# pack Notebooks in 	$sunix_frame_V
$sunix_programs_V_book->pack( -fill => "x", );

#   # pack Notebooks in 	$sunix_frame_IV
$sunix_programs_IV_book->pack( -fill => 'x', );

# pack Notebooks in 	$sunix_frame_III
$sunix_programs_III_book->pack( -fill => 'x', );

# pack Notebooks in 	$sunix_frame_II
$sunix_programs_II_book->pack( -fill => 'x', );

$sunix_programs_I_book->pack( -fill => 'x', );

# pack tabs in Notebook on level 5 (V)
$sunix_data_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);
$sunix_datum_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_plot_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_filter_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

# pack tabs in Notebook level 4 (IV)
$sunix_header_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);
$sunix_inversion_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);
$sunix_migration_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

# pack tabs in Notebook level 3 (III)
$sunix_model_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_NMO_Vel_Stk_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_par_programs_listbox->pack(
	-side => "top",
	-fill => "x",
);

$sunix_picks_programs_listbox->pack(
	-side => "top",
	-fill => "x",
);

# pack tabs in lower Notebook 2 (level II)
$sunix_shapeNcut_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_shell_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);
$sunix_statsMath_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_transform_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

$sunix_well_programs_listbox->pack(
	-side => "left",
	-fill => "x",
);

# within parameters_pane from LtoR we have:
# $parameter_names_frame
# parameter_values_button_frame
# have parameter_values_frame

( $main_href->{_parameter_names_frame} )->pack(
	-side => "left",
	-fill => "both",
);

( $main_href->{_parameter_values_button_frame} )->pack(
	-side => "left",
	-fill => "both",
);

( $main_href->{_parameter_values_frame} )->pack(
	-side => "left",
	-fill => "both",
);

# pack contents of control frame
$flow_control_frame_names4top_row->pack(
	-side   => "top",
	-fill   => "x",
	-expand => 0,
);

$flow_control_frame_top_row->pack(
	-side   => "top",
	-fill   => "x",
	-expand => 0,
);

$flow_control_frame_names4bottom_row->pack(
	-side   => "top",
	-fill   => "x",
	-expand => 0,
);

$flow_control_frame_bottom_row->pack(
	-side   => "top",
	-fill   => "both",
	-expand => 1,
);

( $main_href->{_flow_name_grey_w} )->pack(
	-side => "left",
	-fill => "x",
);

( $main_href->{_flow_name_pink_w} )->pack(
	-side => "right",
	-fill => "x",
);

( $main_href->{_flow_listbox_grey_w} )->pack(
	-side => "left",
	-fill => "x",
);

( $main_href->{_flow_listbox_pink_w} )->pack(
	-side => "left",
	-fill => "x",
);

( $main_href->{_flow_name_green_w} )->pack(
	-side => "left",
	-fill => "x",
);

( $main_href->{_flow_name_blue_w} )->pack(
	-side => "right",
	-fill => "x",
);
( $main_href->{_flow_listbox_green_w} )->pack(
	-side => "left",
	-fill => "y",
);
( $main_href->{_flow_listbox_blue_w} )->pack(
	-fill => "y",
	-side => "left",
);

# send widgets to the L_SU package from the current perl program
# once BUT transfer must ALSO be repeated within each subroutine
# outside MainLoop
$L_SU->set_hash_ref($main_href);
# print("setting up first hash from main\n");

$L_SU->set_param_widgets();    # Initialize screen parameter names and values

MainLoop;

=head2 sub _L_SU_bindings
For help in pre-built superflows and 
for help in user-built listbox flows

color not needed but $self is needed

=cut 

sub _L_SU_bindings {           #

	my ( $self, $set_method ) = @_;

	# print("1 main,_L_SU_bindings ,method:$set_method,\n");
	if ($set_method) {

		$L_SU->set_hash_ref($main_href);

		# print("2 main,_L_SU_bindings,method:$set_method\n");
		$L_SU->$set_method();

		# print("1. main, _L_SU_sunix_bindings: writing gui_history.txt\n");
		# $gui_history->view();

	}
	else {
		print("main, _L_SU_bindings, no method name: $set_method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_bindings_shell

 for any plot(s) in the background

=cut

sub _L_SU_bindings_shell {
	my ( $self, $set_method ) = @_;

	# print("1 main,_L_SU_bindings_shell, method:$set_method,\n");
	if ($set_method) {

		my $button = $set_method;
		$gui_history->set_button($button);
		$main_href = $gui_history->get_defaults();

		$L_SU->set_hash_ref($main_href);

		# print("2 main,_L_SU, _L_SU_bindings_shell,method:$set_method\n");
		$L_SU->$set_method();

		# print("1. main, _L_SU_sunix_bindings_shell: writing gui_history.txt\n");
		# $gui_history->view();

	}
	else {
		print("_L_SU,_L_SU_bindings_shell, no method: $set_method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_sunix_bindings
used for 
	sunix_listbox help (MB3)
	sunix_select		(MB1) 
method='sunix_select'
color='neutral'

=cut

sub _L_SU_sunix_bindings {
	my ( $self, $method, $color, $prog_group ) = @_;

	# print("1 main,_L_SU_sunix_bindings, button:$method, color: $color prog_group: $prog_group \n");
	if ( $method && $color && $prog_group ) {

		_set_prog_group($prog_group);
		my $button = $method;

		# print ("main,_L_SU_sunix_bindings,sunx_listbox:$main_href->{_sunix_listbox}n");

		$gui_history->set_sunix_prog_group($prog_group);
		$gui_history->set_sunix_prog_group_color($color);
		$gui_history->set_button($button);

		# print("1. main, _L_SU_sunix_bindings: writing gui_history.txt\n");
		# $gui_history->view();

		$L_SU->set_hash_ref($main_href);
		$L_SU->user_built_flows($method);

	}

	else {
		print("main, _L_SU_sunix_bindings, no method, color or group : $method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_flow_bindings
used for:
	sunix_listbox help (MB3)
	flow-item selection ('flow_select') (MB1)

Main
	L_SU, user_built_flows
			color_flow, flow_select

N.B. flow_select is activated both here and
independently 
within gui_history by set_button

=cut

sub _L_SU_flow_bindings {
	my ( $self, $method, $color ) = @_;

#	print("1 main,_L_SU_flow_bindings ,method:$method,\n");
	if ( $method && $color ) {

		my $button = $method;

		$gui_history->set_flow_type($user_built);
		# print("2. main, _L_SU_flow_bindings: writing gui_history.txt\n");
		# $gui_history->view();
		
		$gui_history->set_flow_select_color($color);
		# print("1. main,_L_SU_flow_bindings,color:$color\n");
		
		$L_SU->set_hash_ref($main_href);
       # print("2. main,_L_SU_flow_bindings,method:$method\n");

		$L_SU->user_built_flows($method);

	}
	else {
		print("main, _L_SU_flow_bindings, no method, color : $method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_flow_bindings_any_color

 for any colored flow
 use to delete an item from a flow
 'delete_from_flow_button'
 used to move up and down a list of flow items
 'flow_item_up_arrow_button'
 'flow_item_down_arrow_button'

=cut

sub _L_SU_flow_bindings_any_color {
	my ( $self, $method ) = @_;

	# print("1 main,_L_SU_flow_bindings ,method:$method,\n");
	if ($method) {

		my $button = $method;

		$gui_history->set_button($button);

		$main_href = $gui_history->get_defaults();

		$L_SU->set_hash_ref($main_href);

		# print("main,_L_SU_flow_bindings_any_color,method:$method\n");
		# print("main,_L_SU_flow_bindings_any_color,value: any_color\n");
		$L_SU->user_built_flows($method);

		# print("1 main,_L_SU_flow_bindings , print gui_history.txt\n");
		#$gui_history->view();

	}
	else {
		print("main _L_SU_flow_bindings, no method: $method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_superflow_bindings
Redirect user selections to L_SU.pm
for the case of: Help for superflows 
(mouse-button 3 bindings)


=cut

sub _L_SU_superflow_bindings {
	my ( $self, $set_method ) = @_;

	# print("1 main,_L_SU,method:$set_method,\n");
	if ($set_method) {
		$L_SU->set_hash_ref($main_href);

		# print("2 main,_L_SU, superflow_bindings,method:$set_method\n");
		$L_SU->$set_method();

		# print("1 main,_L_SU_bindings , print gui_superflow_bindings, history.txt\n");
		# $gui_history->view();

	}
	else {
		print("main,_L_SU_superflow_bindings, no method: $set_method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU
Invoke a method in L_SU from a button click
in L_SU
	save_button
	run_button
	FileDialog_button with one of 3
	possible values: 'Flow' 'Data' or 'SaveAs'

=cut

sub _L_SU {
	my ( $set_method, $value ) = @_;

	# print("1. main,_L_SU,method:$set_method, ref scalar value:$$value\n");

	if ( $set_method && $value ) {

		my $button = $set_method;
		my $name   = $$value;

		$gui_history->set_button($button);

		if ( $button eq 'FileDialog_button' ) {

			$gui_history->set_FileDialog_type($name);

		}
		else {
			# print("2 main,_L_SU,method:$set_method, deref scalar value:$$value NADA\n");
		}

		$main_href = $gui_history->get_defaults();

		# print("2 main,_L_SU,method:$set_method, deref scalar value:$$value\n");
		$L_SU->set_hash_ref($main_href);

		# print(" main,_L_SU , button=$button, print gui_history.txt\n");
		# $gui_history->view();

		$L_SU->$set_method($value);

	}
	else {
		print("main, _L_SU,no method: $set_method error 1,\n");
	}
	return ();
}

=head2 sub _L_SU_add2flows

  e.g., can call add2flow_button

=cut 

sub _L_SU_add2flows {
	my ( $method, $value ) = @_;

	# print("1 main,_L_SU,method/button:$method, scalar value:$value\n");

	if ( $method && $value ) {

		my $color  = $value;
		my $button = $method;
		$gui_history->set_add2flow_color($color);	# flow_color set 
		$gui_history->set_button($button);	
		$gui_history->set_flow_type($user_built);	
		$main_href = $gui_history->get_defaults();

		$L_SU->set_hash_ref($main_href);
		$L_SU->user_built_flows($method);
		
		# print(" main,_L_SU_add2flows, button=$button, print gui_history.txt\n");
		# $gui_history->view();


		# print("2 main,_L_SU,method:$method, scalar value:$value, method: $method\n");

	}
	else {
		print("main, _L_SU_add2flows, no method: method error 1,\n");
	}

	return ();
}

=head2 sub _L_SU_superflows 

Select pre-built streams or Tools


=cut 

sub _L_SU_superflows {
	my ( $set_method, $value ) = @_;
	if ( $set_method && $value ) {    # value is sref
		# print("main, _L_SU_superflows,set_method,value, $set_method,$$value\n");

		my $tool_name = $$value;

		my $button = 'superflow_select_button';

		$gui_history->set_flow_type($pre_built_superflow);
		$gui_history->set_button($button);
		$gui_history->set_superflow_tool($tool_name);

		$main_href = $gui_history->get_defaults();

		$L_SU->set_hash_ref($main_href);
		$L_SU->$set_method($value);

		# print(" main,_L_SU _superflows, button=$button, print gui_history.txt\n");
		# $gui_history->view();
	}
	else {
		print("main,_L_SU_superflows,no method: $set_method error 1,\n");
	}

	return ();
}

=head2 sub _set_prog_group

=cut

sub _set_prog_group {

	my ($prog_group) = @_;

	if ( $prog_group eq 'data' ) {
		$main_href->{_sunix_listbox} = $sunix_data_programs_listbox;
	}
	elsif ( $prog_group eq 'datum' ) {
		$main_href->{_sunix_listbox} = $sunix_datum_programs_listbox;
	}
	elsif ( $prog_group eq 'plot' ) {
		$main_href->{_sunix_listbox} = $sunix_plot_programs_listbox;
	}
	elsif ( $prog_group eq 'filter' ) {
		$main_href->{_sunix_listbox} = $sunix_filter_programs_listbox;
	}
	elsif ( $prog_group eq 'header' ) {
		$main_href->{_sunix_listbox} = $sunix_header_programs_listbox;
	}
	elsif ( $prog_group eq 'inversion' ) {
		$main_href->{_sunix_listbox} = $sunix_inversion_programs_listbox;
	}
	elsif ( $prog_group eq 'migration' ) {
		$main_href->{_sunix_listbox} = $sunix_migration_programs_listbox;
	}
	elsif ( $prog_group eq 'model' ) {
		$main_href->{_sunix_listbox} = $sunix_model_programs_listbox;
	}
	elsif ( $prog_group eq 'NMO_Vel_Stk' ) {
		$main_href->{_sunix_listbox} = $sunix_NMO_Vel_Stk_programs_listbox;
	}
	elsif ( $prog_group eq 'par' ) {
		$main_href->{_sunix_listbox} = $sunix_par_programs_listbox;
	}
	elsif ( $prog_group eq 'picks' ) {
		$main_href->{_sunix_listbox} = $sunix_picks_programs_listbox;
	}
	elsif ( $prog_group eq 'shapeNcut' ) {
		$main_href->{_sunix_listbox} = $sunix_shapeNcut_programs_listbox;
	}
	elsif ( $prog_group eq 'shell' ) {
		$main_href->{_sunix_listbox} = $sunix_shell_programs_listbox;
	}
	elsif ( $prog_group eq 'statsMath' ) {
		$main_href->{_sunix_listbox} = $sunix_statsMath_programs_listbox;
	}
	elsif ( $prog_group eq 'transform' ) {
		$main_href->{_sunix_listbox} = $sunix_transform_programs_listbox;
	}
	elsif ( $prog_group eq 'well' ) {
		$main_href->{_sunix_listbox} = $sunix_well_programs_listbox;
	}
	else {
		print("main,_set_prog_group, no prog_group\n");
	}

	return ();
}
