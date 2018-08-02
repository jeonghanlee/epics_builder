#!/bin/bash
#  Copyright (c) 2017 - Present  Jeong Han Lee
#  Copyright (c) 2017 - 2018  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
# 
#   Shell   : setEpicsEnv.bash
#   Author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Thursday, August  2 01:28:12 CEST 2018
#
#   version : 1.1.0


# the following function drop_from_path was copied from
# the ROOT build system in ${ROOTSYS}/bin/, and modified
# a little to return its result
# Wednesday, July 11 23:19:00 CEST 2018, jhlee 
function drop_from_path
{
    #
    # Assert that we got enough arguments
    if test $# -ne 2 ; then
	echo "drop_from_path: needs 2 arguments"
	return 1
    fi

    local p=$1
    local drop=$2

    local new_path=`echo $p | sed -e "s;:${drop}:;:;g" \
                 -e "s;:${drop};;g"   \
                 -e "s;${drop}:;;g"   \
                 -e "s;${drop};;g";`
    echo ${new_path}
}


function set_variable
{
    if test $# -ne 2 ; then
	echo "set_variable: needs 2 arguments"
	return 1
    fi

    local old_path="$1"
    local add_path="$2"

    local new_path=""
    local system_old_path=""

    if [ -z "$old_path" ]; then
	new_path=${add_path}
    else
	system_old_path=$(drop_from_path ${old_path} ${add_path})
	if [ -z "$system_old_path" ]; then
	    new_path=${add_path}
	else
	    new_path=${add_path}:${system_old_path}
	fi
   
    fi

    echo "${new_path}"
    
}


unset EPICS_PATH
unset EPICS_BASE
unset EPICS_MODULES
unset EPICS_EXTENSIONS
unset EPICS_APPS
unset EPICS_HOST_ARCH

# In case, ESS E3 is configured.

unset E3_REQUIRE_NAME
unset E3_REQUIRE_VERSION
unset E3_REQUIRE_LOCATION
unset E3_REQUIRE_BIN
unset E3_REQUIRE_LIB
unset E3_REQUIRE_INC
unset E3_REQUIRE_DB
unset E3_SITEMODS_PATH
unset E3_SITELIBS_PATH
unset E3_SITEAPPS_PATH
unset EPICS_DRIVER_PATH
unset SCRIPT_DIR


THIS_SRC=${BASH_SOURCE[0]}
SRC_PATH="$( cd -P "$( dirname "$THIS_SRC" )" && pwd )"
SRC_NAME=${THIS_SRC##*/}
REAL_SRC_PATH="/builder/tools"


if [[ $SRC_PATH == *${REAL_SRC_PATH}* ]]; then
    
    printf "\nPlease do not source %s directly\n" "${SRC_NAME}"
    printf "Your attempt is forwarding to .... %s\n"  ${SRC_PATH}/../../;
    sleep 5
    cd  ${SRC_PATH}/../../
    source ${SRC_NAME}

else

    EPICS_PATH=${SRC_PATH}
    EPICS_BASE=${EPICS_PATH}/epics-base
    EPICS_HOST_ARCH=$("${EPICS_BASE}/startup/EpicsHostArch.pl")
    EPICS_EXTENSIONS=${EPICS_PATH}/extensions
    EPICS_MODULES=${EPICS_PATH}/epics-modules
    EPICS_APPS=${EPICS_PATH}/epics-Apps

    export EPICS_PATH
    export EPICS_BASE
    export EPICS_EXTENSIONS
    export EPICS_MODULES
    export EPICS_APPS
    export EPICS_HOST_ARCH

    old_path=${PATH}
    new_PATH="${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"
    PATH=$(set_variable "${old_path}" "${new_PATH}")

    ext_path="${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}"
    PATH=$(set_variable "${PATH}" "${ext_path}")
    export PATH

    old_ld_path=${LD_LIBRARY_PATH}
    new_LD_LIBRARY_PATH="${EPICS_BASE}/lib/${EPICS_HOST_ARCH}"

    LD_LIBRARY_PATH=$(set_variable "${old_ld_path}" "${new_LD_LIBRARY_PATH}")

    export LD_LIBRARY_PATH

    printf "\nSet the EPICS Environment as follows:\n";
    printf "THIS Source NAME    : %s\n" "${SRC_NAME}"
    printf "THIS Source PATH    : %s\n" "${SRC_PATH}"
    printf "EPICS_BASE          : %s\n" "${EPICS_BASE}"
    printf "EPICS_HOST_ARCH     : %s\n" "${EPICS_HOST_ARCH}"
    printf "EPICS_MODULES       : %s\n" "${EPICS_MODULES}"
    printf "PATH                : %s\n" "${PATH}"
    printf "LD_LIBRARY_PATH     : %s\n" "${LD_LIBRARY_PATH}"
    printf "\n";
    printf "Enjoy Everlasting EPICS!\n";

fi
