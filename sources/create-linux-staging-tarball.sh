#! /bin/bash 
if [[ ! "${1}" ]]; then
	echo "Please give version number as parameter"
	exit 1
fi

tmpdir="$(mktemp -td $(basename ${0}).XXXXXXXXX)"
targetdir=`dirname $0`

# assume this script is called from qubes-builder/qubes-src/kernel-VER/linux-VER, after make 'prep'
echo copying files from qubes kernel tree
cp -r . ${tmpdir}/linux-staging-${1}

# fixme:
# * error handling completely missing
# * remove tmpdir on abortion
pushd ${tmpdir}/ > /dev/null

# drivers/video/sis/vgatypes.h needed for FB_XGI
tar -cjf ${targetdir}/linux-staging-${1}.tar.bz2 linux-staging-${1}/COPYING linux-staging-${1}/drivers/staging/ linux-staging-${1}/drivers/video/sis/
rm -rf linux-staging-${1}/
popd > /dev/null
rmdir ${tmpdir}
echo done: ${targetdir}/linux-staging-${1}.tar.bz2


