#!/bin/bash
version=1.0

#####
# ESSENTIALS
#
# prepare everything this script needs to run.
#####

# function log
# writes given string to logfile
log() {
  logTimestamp=`date +%FT%T`
  echo ${logTimestamp} "$1" >> ${logFile}
}

# function debug
# writes given string to logfile if debug flag is set.
debug() {
  if [ ${debug} -gt 0 ] ; then
    log "DEBUG $1"
  fi
}

#read configfile
#default values for internal variables are configured there.
#configFile=mozilla-test.conf
configFile=test.conf
if [ -f ${configFile} ] ; then
  . ${configFile}
else
  echo "ERROR: cannot find ${configFile}"
  exit 1
fi

#check JMETER_BIN variable
if [ -z "${JMETER_BIN}" ]; then
  echo "ERROR: JMETER_BIN environment variable is not set. Please set JMETER_BIN to <jmeter install>/bin directory." >&2
  exit 1
fi

#####
# / ESSENTIALS
#####


#####
# PREPARATION
#
# prepare everything needed for running tests.
#####

jmeter=${JMETER_BIN}/jmeter

filename=${0##*/}

testDate=`date +%FT%T`

#prepare logging
logDir=log
mkdir -p ${logDir}
logFile=${logDir}/test-${testDate}.log
jmeterLogFile=${logDir}/jmeter-${testDate}.log

#prepare result file
resultDir=results
mkdir -p ${resultDir}
resultFile=${resultDir}/result-${testDate}.csv

#####
# / PREPARATION
#####

#####
# FUNCTIONS
#####

#function usage
usage() {
  cat << EOF
usage: ${filename} [arguments] [-p test.properties]

Example: ${filename} -d

Arguments:
    -h: displays this help text.
    -d: produce debug output
    -g: start jmeter GUI, you'll have to start the test manually
    -j: use jmeter servers instead of local jmeter instance
    -p: propertyfile to use for test run. Default: test.properties
Version: $version
EOF
}

#set internal variables if shellscript is started with parameters
while getopts "dgjhp:" optname
  do
    case "${optname}" in
      "d")
        debug=1
        ;;
      "g")
        withGui=1
        ;;
      "j")
        useJmeterServers=1
        ;;
      "p")
        testProperties=$OPTARG
        ;;
      "h")
        usage
        exit
        ;;
    esac
  done

#####
# / FUNCTIONS
#####


#####
# START TESTING
#####

if [ ! ${useJmeterServers} -eq 0 ] ; then
    #use -r if you use jmeter servers, send properties to servers, save jmeterServerId to result file
    jmeterOptions="${jmeterOptions} -r -G${testProperties} -Jsample_variables=jmeterServerId"
    debug "using jmeter servers"
fi

if [ ${withGui} -eq 0 ] ; then
    #use -n if you use jmeter without GUI
    jmeterOptions="${jmeterOptions} -n"
    debug "starting test without GUI"
fi

if [ ! ${debug} -eq 0 ] ; then
    #log DEBUG messages for jmeter
    jmeterOptions="${jmeterOptions} -LDEBUG"
    debug "starting test with debug logging"
fi

#run test
${jmeter} -t ${testPlan} -l ${resultFile} \
  ${jmeterOptions} -p ${testProperties} \
  -j ${jmeterLogFile} \
  >> ${logFile}

#####
# / START TESTING
#####
