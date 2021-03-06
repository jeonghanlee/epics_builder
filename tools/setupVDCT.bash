#!/bin/bash
#  Copyright (c) 2016 - Present  Jeong Han Lee
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

#  Shell   : setupVDCT.bash
#  Author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com
#  Date    : Monday, August 13 23:54:33 CEST 2018
#  version : 0.2.0


wget_options="wget -c"


function pushd { builtin pushd "$@" > /dev/null; }
function popd  { builtin popd  "$@" > /dev/null; }

function die
{
    error=${1:-1}
    ## exits with 1 if error number not given
    shift
    [ -n "$*" ] &&
	printf "%s%s: %s\n" "$scriptname" ${version:+" ($version)"} "$*" >&2
    exit "$error"
}



make_vdct()
{
    local vdct_version="2.7.0"
    local vdct_name="VisualDCT-${vdct_version}"
    local vdct_filename="${vdct_name}-distribution.zip"
    local vdct_jar="${vdct_name}.jar"
    local vdct_target_jar="VisualDCT.jar"
    local vdct_full_path="${EPICS_EXTENSIONS}/src"

    local vdct_bin=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}/vdct
    local vdct_home=${vdct_full_path}/${vdct_name}
    local vdct_script=${vdct_home}/vdct.bash
  
    local temp_downloads=${SRC_PATH}/.tmp

    mkdir -p ${temp_downloads}
    
    pushd ${temp_downloads}
    
    $wget_options https://github.com/epics-extensions/VisualDCT/releases/download/v${vdct_version}/${vdct_filename} ||  die 1 "${FUNCNAME[*]} : Failed at wget: Please check it" ;

    # Force (-o option) to overwrite when the target files are in the target directory,
    # so it will prevent the duplicated entries in the below sed procedure.
    #
    unzip -oq -d ${vdct_full_path} ${vdct_filename} ||  die 1 "${FUNCNAME[*]} : Fail unzip : Please check it" ;

    popd

    # unzip directory has ${vdct_name}

    cat > ${vdct_script} <<EOF
#!/bin/sh -e

java -cp ${vdct_home}/${vdct_jar} -DEPICS_DB_INCLUDE_PATH=\$EPICS_DB_INCLUDE_PATH com.cosylab.vdct.VisualDCT \$*

EOF
    
    #
    # add the execute permission for runScript
    #
    chmod +x ${vdct_script}
    #
    # force to make a symbolic link for vdct in vdct_bin
    #
    ln -sf ${vdct_script} ${vdct_bin}
 }



THIS_SRC=${BASH_SOURCE[0]}
SRC_PATH="$( cd -P "$( dirname "$THIS_SRC" )" && pwd )"
SRC_NAME=${THIS_SRC##*/}
REAL_SRC_PATH="/builder/tools"



if [[ $SRC_PATH == *${REAL_SRC_PATH}* ]]; then
    
    printf "\nPlease do not run %s directly\n" "${SRC_NAME}"
    printf "Your attempt is forwarding to .... %s\n"  ${SRC_PATH}/../../;
    sleep 5
    cd  ${SRC_PATH}/../../
    source setEpicsEnv.bash
else
    source ${SRC_PATH}/setEpicsEnv.bash
fi


make_vdct

# do we need to clean? 
#rm -rf ${temp_downloads}

exit;







