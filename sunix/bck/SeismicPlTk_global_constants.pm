package L_SU_global_constants;

use Moose;

=head2 Default Tk settings 

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 

=cut

my $alias_superflow_names_h = {
    fk                => 'Sudipfilt',
    ProjectVariables  => 'Project_Variables',
    SetProject        => 'SetProject',
    iPick             => 'iPick',
    iSpectralAnalysis => 'iSpectralAnalysis',
    iVelAnalysis      => 'iVA',
    iTopMute          => 'iTopMute',
    iBottomMute       => 'iBottomMute',
    Project           => 'Project',
    Synseis           => 'Synseis',
    Sseg2su           => 'Sseg2su',
    Sucat             => 'Sucat',
    temp              => 'temp',                # make last
};

my $alias_superflow_spec_names_h = {
    fk                => 'Sudipfilt',
    ProjectVariables  => 'Project_Variables',
    SetProject        => 'SetProject',
    iPick             => 'iPick',
    iSpectralAnalysis => 'iSpectralAnalysis',
    iVelAnalysis      => 'iVA',
    iTopMute          => 'iTopMute',
    iBottomMute       => 'iBottomMute',
    Project           => 'Project',
    Synseis           => 'Synseis',
    Sseg2su           => 'Sseg2su',
    Sucat             => 'Sucat',
    temp              => 'temp',                # make last
};

#print("my constants, alias for fk: $alias_h->{fk}\n");

my $superflow_names_h = {
    _fk                => 'fk',
    _ProjectVariables  => 'ProjectVariables',
    _iPick             => 'iPick',
    _SetProject        => 'SetProject',
    _iSpectralAnalysis => 'iSpectralAnalysis',
    _iVelAnalysis      => 'iVelAnalysis',
    _iTopMute          => 'iTopMute',
    _iBottomMute       => 'iBottomMute',
    _Project           => 'Project',
    _Synseis           => 'Synseis',
    _Sseg2su           => 'Sseg2su',
    _Sucat             => 'Sucat',
    _temp              => 'temp',                # make last
};

=head2

 as shown in gui

=cut

my @superflow_names_gui;
$superflow_names_gui[7]  = 'fk';
$superflow_names_gui[3]  = 'iSpectralAnalysis';
$superflow_names_gui[4]  = 'iVelAnalysis';
$superflow_names_gui[5]  = 'iTopMute';
$superflow_names_gui[6]  = 'iBottomMute';
$superflow_names_gui[0]  = 'Project';
$superflow_names_gui[8]  = 'Synseis';
$superflow_names_gui[1]  = 'Sseg2su';
$superflow_names_gui[2]  = 'Sucat';
$superflow_names_gui[9]  = 'iPick';
$superflow_names_gui[10] = 'temp';                # make last

my @superflow_names;
$superflow_names[0]  = 'fk';
$superflow_names[1]  = 'ProjectVariables';
$superflow_names[2]  = 'SetProject';
$superflow_names[3]  = 'iSpectralAnalysis';
$superflow_names[4]  = 'iVelAnalysis';
$superflow_names[5]  = 'iTopMute';
$superflow_names[6]  = 'iBottomMute';
$superflow_names[7]  = 'Project';
$superflow_names[8]  = 'Synseis';
$superflow_names[9]  = 'Sseg2su';
$superflow_names[10] = 'Sucat';
$superflow_names[11] = 'iPick';
$superflow_names[12] = 'temp';                # make last

my @alias_superflow_names;
$alias_superflow_names[0]  = 'Sudipfilt';
$alias_superflow_names[1]  = 'SetProject';
$alias_superflow_names[2]  = 'SetProject';
$alias_superflow_names[3]  = 'iSpectralAnalysis';
$alias_superflow_names[4]  = 'iVA';
$alias_superflow_names[5]  = 'iTopMute';
$alias_superflow_names[6]  = 'iBottomMute';
$alias_superflow_names[7]  = 'Project';
$alias_superflow_names[8]  = 'Synseis';
$alias_superflow_names[9]  = 'Sseg2su';
$alias_superflow_names[10] = 'Sucat';
$alias_superflow_names[11] = 'iPick';
$alias_superflow_names[12] = 'temp';                # make last

my @superflow_config_names;
$superflow_config_names[0]  = 'fk';
$superflow_config_names[1]  = 'ProjectVariables';
$superflow_config_names[2]  = 'ProjectVariables';
$superflow_config_names[3]  = 'iSpectralAnalysis';
$superflow_config_names[4]  = 'iVelAnalysis';
$superflow_config_names[5]  = 'iTopMute';
$superflow_config_names[6]  = 'iBottomMute';
$superflow_config_names[7]  = 'Project';
$superflow_config_names[8]  = 'Synseis';
$superflow_config_names[9]  = 'Sseg2su';
$superflow_config_names[10] = 'Sucat';
$superflow_config_names[11] = 'iPick';
$superflow_config_names[12] = 'temp';                # make last

my @alias_superflow_config_names;
$alias_superflow_config_names[0]  = 'Sudipfilt';
$alias_superflow_config_names[1]  = 'Project_Variables';
$alias_superflow_config_names[2]  = 'Project# make last_Variables';
$alias_superflow_config_names[3]  = 'iSpectralAnalysis';
$alias_superflow_config_names[4]  = 'iVA';
$alias_superflow_config_names[5]  = 'iTopMute';
$alias_superflow_config_names[6]  = 'iBottomMute';
$alias_superflow_config_names[7]  = 'Project';
$alias_superflow_config_names[8]  = 'Synseis';
$alias_superflow_config_names[9]  = 'Sseg2su';
$alias_superflow_config_names[10] = 'Sucat';
$alias_superflow_config_names[11] = 'iPick';
$alias_superflow_config_names[12] = 'temp';                          # make last

my @alias_FileDialog_button_label;
$alias_FileDialog_button_label[0] = 'Data';
$alias_FileDialog_button_label[1] = 'Flow';
$alias_FileDialog_button_label[2] = 'SaveAs';

my @file_dialog_type;
$file_dialog_type[0] = 'Data';
$file_dialog_type[1] = 'Path';                                       #
$file_dialog_type[2] = 'Flow';
$file_dialog_type[3] = 'SaveAs';

my $file_dialog_type_h = {
    _Data   => 'Data',
    _Path   => 'Path',                                               #
    _Flow   => 'Flow',
    _SaveAs => 'SaveAs',
    _Save   => 'Save',
};

my @flow_type;
$flow_type[0] = 'user_built';
$flow_type[1] = 'pre_built_superflow';

my $flow_type_h = {
    _user_built          => 'user_built',
    _pre_built_superflow => 'pre_built_superflow',
};

my $purpose = { _geopsy => 'geopsy', };

my $var = {
    _14_characters  => '14',
    _13_characters  => '13',
    _12_characters  => '12',
    _11_characters  => '11',
    _8_characters   => '8',
    _10_characters  => '10',
    _15_characters  => '15',
    _20_characters  => '20',
    _30_characters  => '30',
    _32_characters  => '32',
    _35_characters  => '35',
    _40_characters  => '40',
    _45_characters  => '45',
    _base_file_name => 'base_file_name',
    _box_position   => '870x650+12+12',

    #_box_position        => '890x660+12+12',
    _clear_text                    => '',
    _eight_characters              => '8',
    _empty_string                  => '',
    _failure                       => -1,
    _false                         => 0,
    _data_name                     => 'data_name',
    _base_file_name                => 'base_file_name',
    _five_pixels                   => '5',
    _five_pixel_borderwidth        => 5,
    _five_lines                    => '5',
    _1_line                        => '1',
    _2_lines                       => '2',
    _3_lines                       => '3',
    _4_lines                       => '4',
    _8_lines                       => '8',
    _7_lines                       => '7',
    _24_pixels                     => '24',
    _12_pixels                     => '12',
    _18_pixels                     => '18',
    _five_characters               => '5',
    _flow                          => 'frame',
    _half_tiny_width               => '6',
    _hundred_characters            => '100',
    _large__width                  => '200',
    _light_gray                    => 'gray90',
    _literal_empty_string          => '\'\'',
    _l_suplot_box_positionNsize    => '600x800+1000+1000',
    _l_suplot_width                => '500',
    _l_suplot_height               => '300',
    _medium_width                  => '100',
    _my_arial                      => "-*-arial-normal-r-*-*-*-120-*-*-*-*-*-*",
    _my_purple                     => 'MediumPurple1',
    _my_white                      => 'white',
    _my_yellow                     => 'LightGoldenrod1',
    _my_dark_grey                  => 'DarkGrey',
    _my_black                      => 'black',
    _my_light_green                => 'LightGreen',
    _my_light_grey                 => 'LightGrey',
    _my_pink                       => 'pink',
    _my_light_blue                 => 'LightBlue',
    _no_pixel                      => '0',
    _no_borderwidth                => '0',
    _nu                            => 'nu',
    _no                            => 'no',
    _on                            => 'on',
    _off                           => 'off',
    _one_character                 => '1',
    _one_pixel                     => '1',
    _one_pixel_borderwidth         => '1',
    _program_title                 => 'L_SU V0.3.8',
    _l_suplot_title                => 'L_suplot',
    _project_selector_title        => 'Project Selector',
    _project_selector_box_position => '600x600+100+100',
    _null_sunix_value              => '',
    _superflow                     => 'menubutton',
    _small_width                   => '50',
    _string2startFlowSetUp  => '->clear\(\);',    # for regex in perl_flow
    _string2endFlowSetUp    => '->Step\(\);',     # for regex in perl_flow
    _standard_width         => '20',
    _ten_characters         => '10',
    _eleven_characters      => '11',
    _five_characters        => '5',
    _thirty_characters      => '30',
    _thirty_five_characters => '35',
    _tiny_width             => '12',
    _true                   => 1,
    _us_per_s               => 1000000,
    _twenty_characters      => '20',
    _very_small_width       => '25',
    _very_large_width       => '500',
    _yes                    => 'yes',
    _white                  => 'white',

};

=pod
    _length = (max number of entries + 1)

=cut

my $param = {
    _max_entry_num   => 60,
    _first_entry_num => 0,
    _first_entry_idx => 0,
    _final_entry_num => 60,
    _final_entry_idx => 60,
    _default_index   => 0,
    _length          => 61,    # max number of allowable parameters in GUI
};

# Locate environment variables automatically
my $L_SU = '/usr/local/pl';    # default

my $global_libs = {
    _param        => $L_SU . '/configs/',
    _superflows   => $L_SU . '/big_streams/',
    _images       => $L_SU . '/images/',
    _default_path => './',
};

$L_SU = $ENV{'L_SU'};

if ( $L_SU ne $var->{_empty_string} ) {  # must empty sting is predefined herein

    $global_libs = {
        _param        => $L_SU . '/configs/',
        _superflows   => $L_SU . '/big_streams/',
        _images       => $L_SU . '/images/',
        _default_path => './',
    };

}
else {
    print("L_SU_global_constants, L_SU is missing\n");
}

my @developer_categories;

$developer_categories[0] 	= 'data';
$developer_categories[1] 	= 'datum';
$developer_categories[2] 	= 'plot';
$developer_categories[3] 	= 'filter';
$developer_categories[4] 	= 'header';
$developer_categories[5] 	= 'inversion';
$developer_categories[6] 	= 'migration';
$developer_categories[7] 	= 'model';
$developer_categories[8] 	= 'NMO_Vel_Stk';
$developer_categories[9] 	= 'par';
$developer_categories[10] 	= 'picks';
$developer_categories[11] 	= 'shapeNcut';
$developer_categories[12] 	= 'shell';
$developer_categories[13] 	= 'statsMath';
$developer_categories[14] 	= 'transform';
$developer_categories[15] 	= 'well';
$developer_categories[16] 	= '.'; # Tools. have no subdirectory
$developer_categories[17] 	= '';

my @sunix_data_programs = (
    "data_in",
    "data_out",
    "segyread",
    "segywrite",

    #            "swapbytes",
    #            "segyhdrs",
    #            "segyclean",
    #            "supaste",
    #            "suchw",
);

my @sunix_datum_programs = ( "sudatumk2dr", );

my @sunix_filter_programs = ( "sufilter", "sudipfilt", "supef");


my @sunix_header_programs = (
    "segyhdrs",
    "segyclean",
    "suaddhead",
    "suchw",
    "sugethw",
    "sushw",

    #            "sucountkey",
    "surange",

    #            "supaste",
    "sustatic",
    "sustrip",
);

my @sunix_inversion_programs = ( );

my @sunix_migration_programs = ( "sustolt", );
my @sunix_shell_programs     = ( "evince" );

=pod

"cpall"
"xk"

=cut

my @sunix_model_programs = ( "suplane", "susynlv", "unif2", "suea2df", "sufdmod1","sufdmod2");

=pod

elamodel
elaray
elasyn
elatriuni
gbbeam
normray
raydata
suaddevent
suaddnoise
sudgwaveform
sufctanismod
sufdmod2l.pm
sugoupillaud
sugoupillaudpo
suimp2d
suimp3d
suimpedance
sujitter
sukdsyn2d
sunhmospike
sunull
surandspike
surandstat
suremac2d
suremel2dan
suspike
susyncz
susynlvcw
susynlvfti
susynlv
susynvxzcs
susynvxz
sutetraray
suvibro
suwaveform
sxplot
sxplot.xtri
tetramod
tri2uni
trimodel
trip
triray
triseis
uni2trielacheck

=cut

my @sunix_NMO_Vel_Stk_programs = ( "sunmo", "sustack", "suttoz", "suvelan", );

my @sunix_par_programs = ( "a2b", "b2a", "mkparfile", "makevel", "unisam");

=pod
a2i
addrvl3d
bhedtopar
cellauto
cpftrend
cshotplot
dzdv
farith
float2ibm
ftnunstrip
grm
h2b
hti2stiff
hudson
i2a
ibm2float
kaperture
linrort
list
lorenz

=cut

my @sunix_picks_programs = (

);

my @sunix_plot_programs = ( "pswigb", "pswigp", "supswigb", "supswigp", "suximage", "suxgraph", "suxwigb", "suxmovie", 
"xgraph", "ximage", "xmovie","xwigb", );
  
=head2 Remaining to incorporate into L_SU
elaps
lcmap
lprop
psbbox
pscontour
pscubecontour
pscube
psepsi
psgraph
psimage
pslabel
psmanager
psmerge
psmovie
pswigb
pswigp
scmap
spsplot
supscontour
supscubecontour
supscube
supsgraph
supsimage
supsmax
supsmovie
supswigb
supswigp
suxcontour
suxmovie
suxpicker
suxwigb
viewer3
xcontour
xepsb
xepsp
xmovie
xpicker
xpsp
=cut

my @sunix_shapeNcut_programs = ( "sukill", "sumute", "sugain","sugprfb","susort", "suwind", "suxmax",);

my @sunix_statsMath_programs = (

    #			"smooth2",
    # 			"suconv"
    "suacor",
    "suattributes",
    "sumax",
    #			"sunormalize",
    "suinterp",
    #			"sumean",
    #			"suhistogram",
    #			"supolar",
    #			"sumath",
    "sumix",
    "suop",
    "suop2",
    "suxcor",
);

my @sunix_transform_programs = (
    "suamp",  "succepstrum", "sucepstrum", "sucwt",
    "succwt", "sufft",       "sugabor",    "suicepstrum",
    "suphasevel",  "suspecfk",   "suspecfx",
    "sutaup",
);

my @sunix_well_programs = ( "las2su", );

$var->{_sunix_data_programs}        = \@sunix_data_programs;
$var->{_sunix_datum_programs}       = \@sunix_datum_programs;
$var->{_sunix_plot_programs}        = \@sunix_plot_programs;
$var->{_sunix_filter_programs}      = \@sunix_filter_programs;
$var->{_sunix_inversion_programs}   = \@sunix_inversion_programs;
$var->{_sunix_header_programs}      = \@sunix_header_programs;
$var->{_sunix_migration_programs}   = \@sunix_migration_programs;
$var->{_sunix_shell_programs}       = \@sunix_shell_programs;
$var->{_sunix_model_programs}       = \@sunix_model_programs;
$var->{_sunix_NMO_Vel_Stk_programs} = \@sunix_NMO_Vel_Stk_programs;
$var->{_sunix_par_programs}         = \@sunix_par_programs;
$var->{_sunix_picks_programs}       = \@sunix_picks_programs;
$var->{_sunix_shapeNcut_programs}   = \@sunix_shapeNcut_programs;
$var->{_sunix_statsMath_programs}   = \@sunix_statsMath_programs;
$var->{_sunix_transform_programs}   = \@sunix_transform_programs;
$var->{_sunix_well_programs}        = \@sunix_well_programs;

sub alias_superflow_names_h {
    my ($self) = @_;
    return ($alias_superflow_names_h);
}

sub alias_FileDialog_button_label_aref {    # array ref
                                            #my 	$self = @_;
    return ( \@alias_FileDialog_button_label );
}

sub alias_superflow_names_aref {

    return ( \@alias_superflow_names );

}

sub alias_superflow_spec_names_h {

    return ($alias_superflow_spec_names_h);
}

sub developer_categories {
	
	return (\@developer_categories);
	
}

sub file_dialog_type_aref {

    return ( \@file_dialog_type );
}

sub file_dialog_type_href {

    return ($file_dialog_type_h);
}

sub flow_type_aref {

    return ( \@flow_type );
}

sub flow_type_href {

    return ($flow_type_h);
}

sub alias_superflow_config_names_aref {
    return ( \@alias_superflow_config_names );
}

sub superflow_config_names_aref {
    return ( \@superflow_config_names );
}

sub superflow_names_aref {
    return ( \@superflow_names );
}

sub superflow_names_gui_aref {

    return ( \@superflow_names_gui );

}

sub global_libs {
    return ($global_libs);
}

sub purpose {
    return ($purpose);
}

sub superflow_names_h {
    return ($superflow_names_h);
}

sub var {
    return ($var);
}

sub param {
    return ($param);
}

1;