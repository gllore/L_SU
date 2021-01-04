# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#! /bin/bash -f

# AUTHOR: Juan Lorenzo
# Date: August 1 2015
#  July 15  1 2016
#  Nov 15   1 2019
# Sept 2020

umask 002

# limit filesize unlimited
ulimit -S -s unlimited

# LIMIT HISTORY FILE SIZE
unset HISTFILESIZE
HISTSIZE=50

# prevents overwriting files
# allows overwriting files
set +o noclobber

#--------------------------------------------
#         Set my favorite prompt
# historycommand user@hostname:workingdirectoryfullpath %
#--------------------------------------------
PS1="\! \u@\h:\w % "

##### SET SOME GENERAL  VARIABLES
export LOCAL=/usr/local	

# for local binary directory
export BIN_PUB=$LOCAL/bin

# for su
export CWPROOT=$LOCAL/cwp_su_all_44R18

#for Perl

# for sioseis
export SIOSEIS=$LOCAL/sioseis

# for su binaries
export PATH=$PATH:$CWPROOT/bin

# for Sfio binaries in Third Party software for CWP
export PATH=$PATH:$CWPROOT/src/Sfio/bin

# for local perl directories
export PL=$LOCAL/pl 

# for L_SU
export L_SU=$PL/L_SU
export PERL5LIB=$L_SU/configs
export PERL5LIB=$PERL5LIB:$L_SU/specs
export PERL5LIB=$PERL5LIB:$L_SU/sunix

for category in big_streams data datum plot filter header \
	inversion migration model \
	NMO_Vel_Stk par picks shapeNcut shell statsMath transform \
	well
do
    export PERL5LIB=$PERL5LIB:$L_SU/configs/$category
    export PERL5LIB=$PERL5LIB:$L_SU/specs/$category

done

for category in data datum plot filter header \
        inversion migration model \
        NMO_Vel_Stk par picks shapeNcut shell statsMath transform \
        well
do
    export PERL5LIB=$PERL5LIB:$L_SU/sunix/$category

done

export PERL5LIB=$PERL5LIB:$L_SU/gmt:$L_SU/R:$L_SU/big_streams:$L_SU/messages
export PERL5LIB=$PERL5LIB:$L_SU/misc
export PERL5LIB=$PERL5LIB:$L_SU/reqs:$L_SU/specs:$L_SU/sqlite:$L_SU/streams:$L_SU/geopsy:$L_SU/images

# for executable L_SU-related Perl scripts
export PATH=$PATH:$L_SU
export PATH=$PATH:$L_SU/big_streams

# for executable L_SU-related compiled and linked programs 
export PATH=$PATH:$L_SU/fortran/bin
export PATH=$PATH:$L_SU/c/bin
