#******************************************************************************#
#*                                                                            *#
#*                                                                            *#
#*          Title:                                                            *#
#*                                                                            *#
#*                                                                            *#
#*                                                                            *#
#*                                                                            *#
#*  ************************************************************************  *#
#*                                                                            *#
#* Filename : Makefile                                                        *#
#*                                                                            *#
#* Author   : Carlos Kassab                                                   *#
#*                                                                            *#
#* Date     : May/12/2025                                                     *#
#*                                                                            *#
#* Description  : Makefile for XsltTransform program.                         *#
#*                                                                            *#
#*                                                                            *#
#******************************************************************************#

#JAVAC  = javac -Xlint
JAVAC  = javac
JAR = jar

JARFILE = XsltTransform.jar
MAINCLASS = XsltTransform
MANIFEST = manifest.txt


all: compile jar

compile:
	$(JAVAC) -d classes src/*.java

jar: compile
	$(JAR) cvfm $(JARFILE) $(MANIFEST) -C classes .

clean:
	rm -rf classes $(JARFILE)

