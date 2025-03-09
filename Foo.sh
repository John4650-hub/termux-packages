#!/bin/bash
pkg install openjdk-21
jlink --module-path $JAVA_HOME/jmods --add-modules java.base --output output/custom-jre

