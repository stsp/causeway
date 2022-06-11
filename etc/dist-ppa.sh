#!/bin/bash
# Create Debian source package.  Public domain.

set -e
case "$DEBSIGN_KEYID" in
  '') signing=("-us" "-uc");;
  *)  signing=("-k$DEBSIGN_KEYID");;
esac
# If no target Ubuntu distribution is specified, obtain the code name for
# whatever Linux distribution we are running on, or fall back on a wild
# guess.
if test 0 = $#; then
  distro="`lsb_release -c -s || :`"
  if [ -z "$distro" ]; then
    distro="`sed -n '/^DISTRIB_CODENAME=[[:alnum:]]\+$/ { s/^.*=//; p; q; }' \
		 /etc/lsb-release || :`"
  fi
  if [ -z "$distro" ]
    then distro=xenial; fi
  set -- "$distro"
fi
if test \! -f debian/changelog.in; then
  echo 'no debian/changelog.in!' >&2
  exit 1
fi
trap 'rm -f debian/changelog' ERR EXIT TERM QUIT
for distro in "$@"; do
  sed "s/@distro@/$distro/g" debian/changelog.in >debian/changelog
  debuild --no-tgz-check -i -S -rfakeroot -d ${signing[@]}
done
