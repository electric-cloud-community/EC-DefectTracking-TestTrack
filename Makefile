#
# Makefile responsible for building the EC-DefectTracking-TestTrack plugin
#
# Copyright (c) 2005-2012 Electric Cloud, Inc.
# All rights reserved

SRCTOP=..

include $(SRCTOP)/build/vars.mak

STAGINGLIB = $(OUTDIR)/staging/lib

build: buildJavaPlugin

unittest:

systemtest: start-selenium test-setup test-run stop-selenium

NTESTFILES  ?= systemtest

test-setup:
	$(INSTALL_PLUGINS) EC-DefectTracking EC-DefectTracking-TestTrack

test-run: systemtest-run

include $(SRCTOP)/build/rules.mak
