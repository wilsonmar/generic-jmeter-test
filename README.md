What is it?
===========

I put together a simple jmeter test framework with start scripts for Linux/Unix/Solaris and Windows.

**It's easy to use and easily configurable.**

All you need is a host to test and at least one URL list.

All settings can be individually set for all threadgroups so that one threadgroup could test articles, one channel pages and another one images.
Currently, ten threadgroups are implemented.

You can start the test locally or remotely on JMeter servers if you want to.

This test (with the properties) also works with the [maven-jmeter-plugin](https://github.com/Ronnie76er/jmeter-maven-plugin)

Preparation
-----------

### Software

Download and extract [JMeter](http://jakarta.apache.org/jmeter/)

All files that you need for testing are in the main directory, the mozilla test files are in the "example" directory.

    afranken@braun~/development/generic-jmeter-test $ ll ./*
    -rw-r--r-- 1 afranken afranken  470 2011-04-06 15:43 ./test.conf
    -rw-r--r-- 1 afranken afranken   21 2011-03-22 16:33 ./testDataFile
    -rw-r--r-- 1 afranken afranken  78K 2011-04-06 13:45 ./test.jmx
    -rw-r--r-- 1 afranken afranken 8.1K 2011-04-05 17:35 ./test.properties
    -rwxr-xr-x 1 afranken afranken 2.5K 2011-04-06 14:03 ./test.sh*

    ./example:
    total 24K
    drwxr-xr-x  2 afranken afranken 4.0K 2011-04-06 15:46 ./
    drwxr-xr-x 11 afranken afranken 4.0K 2011-04-06 15:47 ../
    -rw-r--r--  1 afranken afranken   79 2011-03-22 17:59 mozillaDataFile
    -rw-r--r--  1 afranken afranken  632 2011-03-23 14:51 mozilla-result.csv
    -rw-r--r--  1 afranken afranken  478 2011-04-06 15:46 mozilla-test.conf
    -rw-r--r--  1 afranken afranken 3.6K 2011-03-22 18:41 mozilla-test.properties

    ./windows:
    total 16K
    drwxr-xr-x  2 afranken afranken 4.0K 2011-04-06 14:00 ./
    drwxr-xr-x 11 afranken afranken 4.0K 2011-04-06 15:47 ../
    -rw-r--r--  1 afranken afranken  914 2011-04-06 14:00 test.cmd
    -rw-r--r--  1 afranken afranken  914 2011-04-06 14:00 test-noGUI.cmd
    -rw-r--r--  1 afranken afranken  914 2011-04-06 14:00 test-noGUI-remote.cmd

Set the environment variable `JMETER_BIN` to the bin directory of the jmeter installation you just extracted.

### Linux/Unix

A shell script is included that is tested thoroughly and which supports all modes (remote jmeter servers, local with GUI, local without GUI)

You can either modify the config file `test.conf` to fit your needs, or pass all parameters via command line:

    afranken@braun~/development/generic-jmeter-test $ ./test.sh -h
    usage: test.sh [arguments] [-p test.properties]

    Example: test.sh -d

    Arguments:
        -h: displays this help text.
        -d: produce debug output
        -g: start jmeter GUI, you'll have to start the test manually
        -j: use jmeter servers instead of local jmeter instance
        -p: propertyfile to use for test run. Default: test.properties
    Version: 1.0

### Windows

Two cmd executables are included:

  * `test.cmd` - starts the JMeter GUI and loads the test and properties

  * `test-noGUI.cmd` - starts JMeter without the GUI

URL lists
---------

The URLs in the file have to be relative to the hostname.
You can set a URL prefix for the whole test (e.g. "/servlet") and a URL prefix for each threadgroup (e.g. "/code", "/images").

You could use a tool like [Xenu's link sleuth](http://home.snafu.de/tilman/xenulink.html) to generate a URL list for your test content.

test.properties
---------------

Here, you can set all properties necessary for running the test.
Please take a look at the file, it's commented and should be self-explanatory.
