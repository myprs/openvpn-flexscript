#!/bin/bash

#
# This script is used to run under the supervision of checkinstall

SCRIPTNAME01="openvpn-flexinit"
SCRIPTNAME02="openvpn-flexscript"
#BASHCOMPFILE="openvpn-flexinit"


# location of the installation sources
DEVDIR=".."
PACKDIR="$DEVDIR/packaging"
SRCDIR="$DEVDIR/source"

# location of the instalation target directories
ETCDIR="/etc"
CONFDIR="$ETCDIR/openvpn-flexscript"
SUDODIR="$ETCDIR/sudoers.d"
SUDOFILE="$SUDODIR/openvpn-flexscript"
#DEFAULTDIR="$ETCDIR/default"
BASHCOMPDIR="/usr/share/bash-completion/completions"



INSTALLDIR="/usr/sbin"

pushd . >/dev/null 

cd "$PACKDIR"

function cleanup () {

	popd >/dev/null

}


# copy scripts to scriptdir

# install script 01 (openvpn-flexinit)
echo "DEBUG: install init script"
[ -x "$INSTALLDIR" ] || mkdir "$INSTALLDIR"
cp -r "$SRCDIR$INSTALLDIR/$SCRIPTNAME01" $INSTALLDIR/.
chown -R root:root $INSTALLDIR/$SCRIPTNAME01
chmod -R u=rwx,g=,o= $INSTALLDIR/$SCRIPTNAME01

# install script 02
echo "DEBUG: install init script"
[ -x "$INSTALLDIR" ] || mkdir "$INSTALLDIR"
cp -r "$SRCDIR$INSTALLDIR/$SCRIPTNAME02" $INSTALLDIR/.
chown -R root:root $INSTALLDIR/$SCRIPTNAME02
chmod -R u=rwx,g=rx,o=rx $INSTALLDIR/$SCRIPTNAME02

# create sudo  structures
[ -x "$SUDODIR" ] || mkdir -p "$SUDODIR"

echo "DEBUG: create /etc/sudoers.d structures"
cp -r "$SRCDIR/$SUDOFILE" $SUDOFILE
chown -R root:root $SUDOFILE
chmod -R u=r,g=r,o= $SUDOFILE



#echo "DEBUG: copy config"

#cp -r "$SRCDIR$CONFDIR/"* "$CONFDIR/."
#chown root:root "$CONFDIR/"*  
#chmod u=rwx,g=rx,o=rx "$CONFDIR/"*  



# install bash completion
#[ -x "$BASHCOMPDIR" ] || mkdir $BASHCOMPDIR
#echo "install Bash completion"
#cp -r "$SRCDIR$BASHCOMPDIR/pfsensesshconnect" $BASHCOMPDIR/.
#chown -R root:root $BASHCOMPDIR/pfsensesshconnect
#chmod -R u=rwx,g=rx,o=rx $BASHCOMPDIR/pfsensesshconnect



echo "DEBUG: cleanup"
cleanup


