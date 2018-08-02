#!/bin/bash

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"



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



function usage
{
    {
	echo "";
	echo "Usage    : $0 [-n <ioc name>]  " ;
	echo "";
	echo ""
	
    } 1>&2;
    exit 1; 
}




options=":n:"

while getopts "${options}" opt; do
    case "${opt}" in
	n)
	    iocname="1";
	    IOC_NAME=${OPTARG} ;
	    ;;
	*)
	    usage
	    ;;
    esac
done
shift $((OPTIND-1))


if [ -z "${iocname}" ] ; then
    usage
fi

mkdir -p ${IOC_NAME}
cd ${IOC_NAME}
makeBaseApp.pl -t ioc ${IOC_NAME}
makeBaseApp.pl -i -t ioc ${IOC_NAME}


