#!/bin/bash

SCRIPT_DIR=`dirname "${BASH_SOURCE[0]}"`
cd "${SCRIPT_DIR}/.."

TMPSCRIPT="${TMPDIR}gureumbuild"

if [ -e $TMPSCRIPT ]; then
    echo "unexpected existing file: ${TMPSCRIPT}"
    exit 255
fi

xcodebuild -workspace 'Gureum.xcworkspace' -scheme 'ScriptSupport' -configuration 'Debug' | grep export > $TMPSCRIPT
. ${TMPSCRIPT} &> /dev/null
rm ${TMPSCRIPT}

XCVERSION=`cat OSX/Version.xcconfig`
PACKAGE_NAME=Gureum-${XCVERSION#VERSION = }

if [ ! $CONFIGURATION ]; then
	CONFIGURATION='Debug'
fi

if [ "${PRODUCT_NAME}" != "Gureum" ]; then
    echo 'something wrong'
    exit 255
fi
