#!/bin/bash
#
#
# Shell  : epics_vdct.sh
# Author : Jeong Han Lee
# email  : jeonghan.lee@gmail.com
# Date   : Friday, September  2 13:04:24 CEST 2016
# version : 0.1.0


wget_options="wget -c"

temp_downloads=""
	   
make_vdct()
{
    local vdct_version="2.7.0"
    local vdct_filename=VisualDCT-${vdct_version}-distribution.zip
    local vdct_full_path="${EPICS_EXTENSION}/VisualDCT"
    local run_script=""
    local vdct_jar="VisualDCT.jar"
    local vdct_bin=""

    $wget_options https://github.com/epics-extensions/VisualDCT/releases/download/${vdct_filename}

    # Force (-o option) to overwrite when the target files are in the target directory,
    # so it will prevent the duplicated entries in the below sed procedure.
    #
    unzip -oq -d ${vdct_full_path} ${vdct_filename}

    vdct_home=${vdct_full_path}/${vdct_version}
    run_script=${vdct_home}/runScript
    vdct_bin=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}/vdct

    #
    # fix the path for VisualDCT.jar location in runScript
    # in order to run it globally.
    #
    sed -i "s|${vdct_jar_name}|${vdct_home}/${vdct_jar_name}|g" ${run_script}
    #
    # add the execute permission for runScript
    #
    chmod +x ${run_script}
    #
    # force to make a symbolic link for vdct in vdc_target/bin
    #
    ln -sf ${run_script} ${vdct_bin}
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

temp_downloads=${SRC_PATH}/.tmp

mkdir -p ${temp_downloads}

pushd ${temp_downloads}
make_vdct
popd

rm -rf ${temp_downloads}







