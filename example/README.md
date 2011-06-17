# Example: mozilla.com #

This example configuration tests seven pages on mozilla.com.
(One of the tested pages actually does not work and produces a 404)

## Contents ##
    mozillaDataFile -> contains the URLs
    mozilla-result.csv -> example CSV output of a test run
    mozilla-test.conf -> configuration for the test.sh script
    mozilla-test.properties -> configuration for the JMeter test

## Usage ##

  * Move the files "mozilla-test.properties" and "mozillaDataFile" up one directory level.
  * if using test.sh to start the test: set variable `configFile` to `mozilla-test.conf` inside the script.
