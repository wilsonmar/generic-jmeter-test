# Generic JMeter test #

I put together a simple jmeter test framework with start scripts for Linux/Unix/Solaris/OSX and Windows.

It consists of a JMeter test JMX (XML) which is configured using a properties file.
The Test supports 10 threadgroups which can be configured individually using many JMeter features like Asserts,

The main goal is to save time using the JMX file out-of-the-box and only change the properties file since modifying the JMX file is tedious work.

## Why should you use it? ##

 * It's easy to use and easily configurable.
 * Everything you will have to do is adapt the `test.properties`
 * You won't have to change the test if you want to test different websites/web applications.
 * All you need is a host to test and at least one URL list.
 * All settings can be individually set for all threadgroups so that one threadgroup could test articles, one overview pages and another one images.
    Currently, ten different threadgroups are implemented.
 * You can start the test locally or remotely on JMeter servers if you want to.
 * This test (with the properties) also works with the [maven-jmeter-plugin](https://github.com/Ronnie76er/jmeter-maven-plugin)

## Contents ##

 * `example/` -> contains an example configuration for a test agains mozilla.com
 * `windows-scripts/` -> contains command line scripts for Windows
 * `test.conf` -> configuration for the test.sh script
 * `test.jmx` -> the JMeter XML test definition
 * `test.properties` -> configuration blueprint for the JMeter test
 * `testDataFile` -> contains the URLs

## Preparation ##

### Software ###

 * Download and extract [JMeter](http://jakarta.apache.org/jmeter/)
 * Set the environment variable `JMETER_BIN` to the bin directory of the jmeter installation you just extracted.

### Linux/Unix

A shell script is included that is tested thoroughly and which supports all modes (remote jmeter servers, local with GUI, local without GUI)

You can either modify the config file `test.conf` to fit your needs, or pass all parameters via command line:

    bash$ ./test.sh -h
    usage: test.sh [arguments] [-p test.properties]

    Example: test.sh -d

    Arguments:
        -h: displays this help text.
        -d: produce debug output
        -g: start jmeter GUI, you'll have to start the test manually
        -j: use jmeter servers instead of local jmeter instance
        -p: propertyfile to use for test run. Default: test.properties
    Version: 1.0

The shell script will automatically generate `log/` and `report/` folders and output files.

### Windows

See scripts and description in `windows-scripts/` folder.

## URL lists ##

The URLs in the file have to be relative to the hostname.
You can set a URL prefix for the whole test (e.g. "/servlet") and a URL prefix for each threadgroup (e.g. "/code", "/images") in the `test.properties`.

You could use a website crawler/broken link checker to generate a URL list for your test content. Possible tools:

 * Windows/Linux (using Wine): [Xenu's link sleuth](http://home.snafu.de/tilman/xenulink.html)
 * Mac OSX: [Integrity](http://peacockmedia.co.uk/integrity/)

## Using JMeter GUI ##

**first draft, pics are missing:**

 * If you run the test with GUI, the results will NOT be written to the result.csv file automatically.

In GUI mode, you have several options.

### There are four Result Processors which are deactivated: ###

 * `Results Tree` -> Show each request, with response, status, assertions ...
 * `Summary Report` -> Shows just a summary across all requests
 * `Simple Data Writer` -> Writes the results to a csv file
 * `Graph Results` -> Shows the requests as dots, with average. Can be saved as a picture.

You can easily enable each of the processors by right clicking on the node and selecting **enable**

If you changed something like activating a Request Processor:

**After you are done testing and you close JMeter, do not save changes to the test file as it suggests!**