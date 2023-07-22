#	Permission is hereby granted, free of charge, to any person
#	obtaining a copy of this software and associated documentation files
#	(the "Software"), to deal in the Software without restriction,
#	including without limitation the rights to use, copy, modify, merge,
#	publish, distribute, sublicense, and/or sell copies of the Software,
#	and to permit persons to whom the Software is furnished to do so,
#	subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be
#	included in all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#	NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
#	BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
#	ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#	SOFTWARE.

# Makefile for GNU make + JWasm to cross-assemble the CauseWay DOS extender
# with default configuration settings, on a Un*x system.  -- tkchia

CFLAGS = -O2 -Wall
INSTALL = install -c
prefix ?= /usr
exec_prefix = $(prefix)/i386-pc-msdos
bindir = $(exec_prefix)/bin
exec_prefix2 = $(prefix)/ia16-elf
bindir2 = $(exec_prefix2)/bin

CWMAIN = source/all/cw32.asm
CWSRCS = $(CWMAIN) source/all/raw_vcpi.asm source/all/interrup.asm \
	 source/all/ldt.asm source/all/memory.asm source/all/api.asm \
	 source/all/int10h.asm source/all/int21h.asm source/all/int33h.asm \
	 source/all/decode_c.asm source/all/exceptn.asm \
	 source/all/loadle/loadle.asm \
	 source/all/strucs.inc source/all/cw.inc
CWDEPS = $(CWSRCS)

CWCDEPS =

CWLMAIN	= source/all/cwl/cwl.asm
CWLOBJ	= $(CWLMAIN:.asm=.o)
CWLSRCS	= $(CWLMAIN) source/all/cwl/cwl.inc
CWLDEPS	= $(CWLSRCS)

CWDMAIN	= source/all/cwd/cwd.asm
CWDSRCS	= $(CWDMAIN) source/all/cwd/equates.asm source/all/cwd/macros.asm \
	  source/all/strucs.inc
CWDDEPS	= $(CWDSRCS)

CWDVMAIN = source/all/cwd/cwd-ovl.asm
CWDVOBJ  = $(CWDVMAIN:.asm=.o)
CWDVSRCS = $(CWDVMAIN) source/all/cwd/macros.inc source/all/cw.inc \
	   source/all/strucs.inc source/all/cwd/disas.inc \
	   source/all/cwd/generr.asm source/all/cwd/files.asm \
	   source/all/cwd/print.asm source/all/cwd/getkeys.asm \
	   source/all/cwd/win.asm source/all/cwd/evaluate.asm \
	   source/all/cwd/disas.asm source/all/cwd/fpu.asm
CWDVDEPS = $(CWDVSRCS)

CWLIB	  = cw.lib
CWLIBSRCS = source/all/cwlib/cw.asm/_apndstr.asm \
	    source/all/cwlib/cw.asm/apndstr.asm \
	    source/all/cwlib/cw.asm/bdrwlin.asm \
	    source/all/cwlib/cw.asm/_beep.asm \
	    source/all/cwlib/cw.asm/beep.asm \
	    source/all/cwlib/cw.asm/_bin2dec.asm \
	    source/all/cwlib/cw.asm/bin2dec.asm \
	    source/all/cwlib/cw.asm/_bin2hex.asm \
	    source/all/cwlib/cw.asm/bin2hex.asm \
	    source/all/cwlib/cw.asm/bitfrec.asm \
	    source/all/cwlib/cw.asm/bitmaps.asm \
	    source/all/cwlib/cw.asm/blitbit.asm \
	    source/all/cwlib/cw.asm/blitw.asm \
	    source/all/cwlib/cw.asm/bmxflp.asm \
	    source/all/cwlib/cw.asm/bmyflp.asm \
	    source/all/cwlib/cw.asm/_bord.asm \
	    source/all/cwlib/cw.asm/bord.asm \
	    source/all/cwlib/cw.asm/bsetpix.asm \
	    source/all/cwlib/cw.asm/_buffile.asm \
	    source/all/cwlib/cw.asm/buffile.asm \
	    source/all/cwlib/cw.asm/calsplts.asm \
	    source/all/cwlib/cw.asm/_closef.asm \
	    source/all/cwlib/cw.asm/closef.asm \
	    source/all/cwlib/cw.asm/_closew.asm \
	    source/all/cwlib/cw.asm/closew.asm \
	    source/all/cwlib/cw.asm/_command.asm \
	    source/all/cwlib/cw.asm/command.asm \
	    source/all/cwlib/cw.asm/_copystr.asm \
	    source/all/cwlib/cw.asm/copystr.asm \
	    source/all/cwlib/cw.asm/_crbtmp.asm \
	    source/all/cwlib/cw.asm/crbtmp.asm \
	    source/all/cwlib/cw.asm/_createf.asm \
	    source/all/cwlib/cw.asm/createf.asm \
	    source/all/cwlib/cw.asm/_delay.asm \
	    source/all/cwlib/cw.asm/delay.asm \
	    source/all/cwlib/cw.asm/_deletef.asm \
	    source/all/cwlib/cw.asm/deletef.asm \
	    source/all/cwlib/cw.asm/_dlgbtwn.asm \
	    source/all/cwlib/cw.asm/dlgbtwn.asm \
	    source/all/cwlib/cw.asm/_dlgdraw.asm \
	    source/all/cwlib/cw.asm/dlgdraw.asm \
	    source/all/cwlib/cw.asm/_dlggtbd.asm \
	    source/all/cwlib/cw.asm/dlggtbd.asm \
	    source/all/cwlib/cw.asm/_dlggtbw.asm \
	    source/all/cwlib/cw.asm/dlggtbw.asm \
	    source/all/cwlib/cw.asm/_dlggtbx.asm \
	    source/all/cwlib/cw.asm/dlggtbx.asm \
	    source/all/cwlib/cw.asm/_dlggtby.asm \
	    source/all/cwlib/cw.asm/dlggtby.asm \
	    source/all/cwlib/cw.asm/_dlggtd.asm \
	    source/all/cwlib/cw.asm/dlggtd.asm \
	    source/all/cwlib/cw.asm/_dlggtst.asm \
	    source/all/cwlib/cw.asm/dlggtst.asm \
	    source/all/cwlib/cw.asm/_dlggtw.asm \
	    source/all/cwlib/cw.asm/dlggtw.asm \
	    source/all/cwlib/cw.asm/dlg_oc.asm \
	    source/all/cwlib/cw.asm/_dlgstst.asm \
	    source/all/cwlib/cw.asm/dlgstst.asm \
	    source/all/cwlib/cw.asm/_dlgwhch.asm \
	    source/all/cwlib/cw.asm/dlgwhch.asm \
	    source/all/cwlib/cw.asm/drwlin.asm \
	    source/all/cwlib/cw.asm/_filesel.asm \
	    source/all/cwlib/cw.asm/filesel.asm \
	    source/all/cwlib/cw.asm/fillrct.asm \
	    source/all/cwlib/cw.asm/fillw.asm \
	    source/all/cwlib/cw.asm/_flmknm.asm \
	    source/all/cwlib/cw.asm/flmknm.asm \
	    source/all/cwlib/cw.asm/_free.asm \
	    source/all/cwlib/cw.asm/free.asm \
	    source/all/cwlib/cw.asm/_getdrv.asm \
	    source/all/cwlib/cw.asm/getdrv.asm \
	    source/all/cwlib/cw.asm/_getdrvs.asm \
	    source/all/cwlib/cw.asm/getdrvs.asm \
	    source/all/cwlib/cw.asm/_getkey.asm \
	    source/all/cwlib/cw.asm/getkey.asm \
	    source/all/cwlib/cw.asm/_getpath.asm \
	    source/all/cwlib/cw.asm/getpath.asm \
	    source/all/cwlib/cw.asm/ldbm.asm \
	    source/all/cwlib/cw.asm/_ldfont.asm \
	    source/all/cwlib/cw.asm/ldfont.asm \
	    source/all/cwlib/cw.asm/_ldgif.asm \
	    source/all/cwlib/cw.asm/ldgif.asm \
	    source/all/cwlib/cw.asm/_ldiff.asm \
	    source/all/cwlib/cw.asm/ldiff.asm \
	    source/all/cwlib/cw.asm/_ldimage.asm \
	    source/all/cwlib/cw.asm/ldimage.asm \
	    source/all/cwlib/cw.asm/ldpcx.asm \
	    source/all/cwlib/cw.asm/_ldtga.asm \
	    source/all/cwlib/cw.asm/ldtga.asm \
	    source/all/cwlib/cw.asm/_lnstr.asm \
	    source/all/cwlib/cw.asm/lnstr.asm \
	    source/all/cwlib/cw.asm/_makflst.asm \
	    source/all/cwlib/cw.asm/makflst.asm \
	    source/all/cwlib/cw.asm/_malloc.asm \
	    source/all/cwlib/cw.asm/malloc.asm \
	    source/all/cwlib/cw.asm/mdelst.asm \
	    source/all/cwlib/cw.asm/_messw.asm \
	    source/all/cwlib/cw.asm/messw.asm \
	    source/all/cwlib/cw.asm/_mgetpos.asm \
	    source/all/cwlib/cw.asm/mouse.asm \
	    source/all/cwlib/cw.asm/_msetype.asm \
	    source/all/cwlib/cw.asm/null.asm \
	    source/all/cwlib/cw.asm/_openf.asm \
	    source/all/cwlib/cw.asm/openf.asm \
	    source/all/cwlib/cw.asm/openw.asm \
	    source/all/cwlib/cw.asm/printw.asm \
	    source/all/cwlib/cw.asm/_prntstr.asm \
	    source/all/cwlib/cw.asm/prntstr.asm \
	    source/all/cwlib/cw.asm/_readf.asm \
	    source/all/cwlib/cw.asm/readf.asm \
	    source/all/cwlib/cw.asm/regclipw.asm \
	    source/all/cwlib/cw.asm/_regsbit.asm \
	    source/all/cwlib/cw.asm/regsbit.asm \
	    source/all/cwlib/cw.asm/_regupw.asm \
	    source/all/cwlib/cw.asm/regupw.asm \
	    source/all/cwlib/cw.asm/_relsbit.asm \
	    source/all/cwlib/cw.asm/relsbit.asm \
	    source/all/cwlib/cw.asm/_remallo.asm \
	    source/all/cwlib/cw.asm/remallo.asm \
	    source/all/cwlib/cw.asm/_remsbit.asm \
	    source/all/cwlib/cw.asm/remsbit.asm \
	    source/all/cwlib/cw.asm/_renfile.asm \
	    source/all/cwlib/cw.asm/renfile.asm \
	    source/all/cwlib/cw.asm/_rmsbits.asm \
	    source/all/cwlib/cw.asm/rmsbits.asm \
	    source/all/cwlib/cw.asm/_setdacs.asm \
	    source/all/cwlib/cw.asm/setdacs.asm \
	    source/all/cwlib/cw.asm/_setdrv.asm \
	    source/all/cwlib/cw.asm/setdrv.asm \
	    source/all/cwlib/cw.asm/_setmode.asm \
	    source/all/cwlib/cw.asm/setmode.asm \
	    source/all/cwlib/cw.asm/_setpal.asm \
	    source/all/cwlib/cw.asm/setpal.asm \
	    source/all/cwlib/cw.asm/_setpath.asm \
	    source/all/cwlib/cw.asm/setpath.asm \
	    source/all/cwlib/cw.asm/_setpix.asm \
	    source/all/cwlib/cw.asm/setpix.asm \
	    source/all/cwlib/cw.asm/_setposf.asm \
	    source/all/cwlib/cw.asm/setposf.asm \
	    source/all/cwlib/cw.asm/_srchrgb.asm \
	    source/all/cwlib/cw.asm/srchrgb.asm \
	    source/all/cwlib/cw.asm/_srtflst.asm \
	    source/all/cwlib/cw.asm/srtflst.asm \
	    source/all/cwlib/cw.asm/startup.asm \
	    source/all/cwlib/cw.asm/_strlnpx.asm \
	    source/all/cwlib/cw.asm/strlnpx.asm \
	    source/all/cwlib/cw.asm/svbm.asm \
	    source/all/cwlib/cw.asm/_svgif.asm \
	    source/all/cwlib/cw.asm/svgif.asm \
	    source/all/cwlib/cw.asm/_sviff.asm \
	    source/all/cwlib/cw.asm/sviff.asm \
	    source/all/cwlib/cw.asm/_svimage.asm \
	    source/all/cwlib/cw.asm/svimage.asm \
	    source/all/cwlib/cw.asm/_svtga.asm \
	    source/all/cwlib/cw.asm/svtga.asm \
	    source/all/cwlib/cw.asm/_sys2hrd.asm \
	    source/all/cwlib/cw.asm/sys2hrd.asm \
	    source/all/cwlib/cw.asm/_ulflist.asm \
	    source/all/cwlib/cw.asm/ulflist.asm \
	    source/all/cwlib/cw.asm/_upchr.asm \
	    source/all/cwlib/cw.asm/upchr.asm \
	    source/all/cwlib/cw.asm/_upprstr.asm \
	    source/all/cwlib/cw.asm/upprstr.asm \
	    source/all/cwlib/cw.asm/_vesa.asm \
	    source/all/cwlib/cw.asm/vesa.asm \
	    source/all/cwlib/cw.asm/_video.asm \
	    source/all/cwlib/cw.asm/video.asm \
	    source/all/cwlib/cw.asm/_waitkey.asm \
	    source/all/cwlib/cw.asm/waitkey.asm \
	    source/all/cwlib/cw.asm/wdrwlin.asm \
	    source/all/cwlib/cw.asm/_whichw.asm \
	    source/all/cwlib/cw.asm/whichw.asm \
	    source/all/cwlib/cw.asm/windows.asm \
	    source/all/cwlib/cw.asm/_writef.asm \
	    source/all/cwlib/cw.asm/writef.asm \
	    source/all/cwlib/cw.asm/wsetpix.asm
CWLIBOBJS = $(CWLIBSRCS:%.asm=%.o)
CWLIBDEPS = source/all/cwlib/cwlib.inc source/all/cwlib/cw.asm/palette.inc

# If we already have JWasm &/or the Watcom Linker (wlink) &/or JWlink
# installed, use those.  Otherwise, download & build JWasm & JWlink.
# JWlink is used for bootstrapping the CauseWay Linker (TODO).
GIT = git
ifneq "" "$(shell jwasm '-?' 2>/dev/null)"
    ASM = jwasm
else
    ASM = ./jwasm
    CWDEPS += $(ASM)
    CWCDEPS += $(ASM)
    CWLDEPS += $(ASM)
    CWDDEPS += $(ASM)
    CWDVDEPS += $(ASM)
    CWLIBDEPS += $(ASM)
endif
ifneq "" "$(shell wlink '-?' 2>/dev/null </dev/null)"
    LINK = wlink
else
ifneq "" "$(shell jwlink '-?' 2>/dev/null </dev/null)"
    LINK = jwlink
else
    LINK = ./jwlink
    CWLDEPS += $(LINK)
endif
endif
ifneq "" "$(shell xlib.ladsoft 2>/dev/null </dev/null)"
    XLIB = xlib.ladsoft
else
    XLIB = ./xlib
    CWLIBDEPS += $(XLIB)
endif
# Use UPX rather than CauseWay's own compressor to compress the CauseWay
# loader stub, if we can.
ifneq "" "$(shell upx -V 2>/dev/null)"
    UPX = upx
else
    UPX =
endif
ifneq "" "$(shell which lfanew 2>/dev/null)"
    LFANEW = lfanew
else
    LFANEW = ./lfanew
    CWDEPS += $(LFANEW)
endif
RM = rm -f

# If dosemu is installed, then use it to run CauseWay programs.  (Assume
# dosemu version >= 2.)  Otherwise, use dosbox.
#
# In the future it might be useful to have some sort of loader that can
# directly launch protected mode code from U*ix systems.
ifneq "" "$(shell dosemu --version)"
    run-dos = TERM=vt220 dosemu -td -K . -E "$1"
else
    run-dos = TERM=vt220 dosbox -c 'mount c .' -c 'c:' -c "$1" -c exit \
				>/dev/null
endif
comma = ,
# dosbox creates files with upper-case file names.  Work around this by
# first creating empty target files with the correct case before linking. :-|
define cw-link
	: >"$4"
	: >"$5"
	$(call run-dos,$(subst /,\\,$1) $2 \
		       $(subst /,\\,$3$(comma)$4$(comma)$5))
	test -s "$4" || ($(RM) "$4" "$5" && exit 1)
endef
define cw-compress
	cp "$3" "$4"
	$(call run-dos,$(subst /,\\,$1) $2 $(subst /,\\,$4))
	# Ugh.  Under dosbox, we get CWC.EXE & CWD.OVL instead of cwc.exe &
	# cwd.ovl.  dosemu is OK though.
	if test -f $4; \
	then	:; \
	else	u="`export LC_ALL=C && echo $4 | tr a-z A-Z`"; \
		mv "$$u" $4; \
	fi
	test -s "$4" -a "`LC_ALL=C wc -c <$4`" -lt "`LC_ALL=C wc -c <$3`" || \
	    ($(RM) "$4" && exit 1)
endef

OUTS = cwc-wat cw32.exe cwstub.exe cwstubfa.exe cwl.exe cwd.exe cwd.ovl cwc.exe

# Various phony targets.

default: $(OUTS)
.PHONY: default

install: $(OUTS)
	$(INSTALL) -d $(DESTDIR)$(bindir) $(DESTDIR)$(bindir2)
	$(INSTALL) $^ $(DESTDIR)$(bindir)
	$(RM) -r $(^:%=$(DESTDIR)$(bindir2)/%)
	ln -s -r $(^:%=$(DESTDIR)$(bindir)/%) $(DESTDIR)$(bindir2) || \
	    $(INSTALL) $^ $(DESTDIR)$(bindir2)
.PHONY: install

clean: mostlyclean
	$(RM) -r JWasm.build JWlink.build xlib.build lfanew.build jwasm \
		 jwlink xlib lfanew *.zip
.PHONY: clean

mostlyclean:
	$(RM) -r *.o *.obj *.exe *.com *.ovl *.lib *.gh *.map *.sym *.lst \
		 *.err *.3p *.tmp mkcode cwc-wat copystub.inc decstub.inc \
		 tests/tmp source/all/*/*.o \
		 source/all/*/*/*.lst source/all/*/*/*.o
	find . -name '*~' -exec $(RM) '{}' ';'
.PHONY: mostlyclean

check: cwl.exe FD12FLOPPY.zip csdpmi7b.zip dual.exe tests/autoexec.bat
	$(RM) -r tests/tmp
	mkdir tests/tmp
	unzip -j -dtests/tmp FD12FLOPPY.zip FLOPPY.img
	unzip -j -dtests/tmp csdpmi7b.zip bin/CWSDPMI.EXE
	mdel -i tests/tmp/FLOPPY.img ::FDSETUP/BIN/GREP.EXE
	mcopy -o -i tests/tmp/FLOPPY.img cwl.exe tests/tmp/CWSDPMI.EXE \
					 dual.exe tests/autoexec.bat ::
	qemu-system-i386 -nographic -fda tests/tmp/FLOPPY.img \
	  | tee tests/tmp/tests.log
	@echo  # make sure we start on a new line after QEMU session
	grep -q '=== Tests OK ===' tests/tmp/tests.log
.PHONY: check

# Various pattern rules.

%.o: %.asm $(CWLDEPS) $(CWDVDEPS) $(CWLIBDEPS)
	$(ASM) -DENGLISH=1 -DCONTRIB=1 -Fo$@.tmp -Fl$(@:.o=.lst) $<
	mv $@.tmp $@
.PRECIOUS: %.o

%.gh: %.com mkcode
	./mkcode -b $< $@.tmp
	mv $@.tmp $@
.PRECIOUS: %.gh

%.inc: %.gh
	sed 's/0x\(..\),/0\1h,/g; s/^/db /; s/,$$//' $< >$@.tmp
	mv $@.tmp $@
.PRECIOUS: %.inc

%.com: source/all/cwc/%.asm $(CWCDEPS)
	$(ASM) -bin -DENGLISH=1 -DCONTRIB=1 -Fo$@.tmp -Fl$(@:.com=.lst) $<
	mv $@.tmp $@
.PRECIOUS: %.com

# Rule to build an uncompressed CauseWay loader stub.
cw32.exe: $(CWDEPS)
	$(ASM) -mz -DENGLISH=1 -DCONTRIB=1 -Fo$@.tmp -Fl$(@:.exe=.lst) \
	    $(CWMAIN)
	mv $@.tmp $@
.PRECIOUS: cw32.exe

# Rule to build a compressed CauseWay loader stub.
#
# To compress the loader stub, either
#   * use UPX if present, or
#   * use Watcom's cwc.c.
# CauseWay's original source/all/cwc/cwc.asm may work on DOS systems, but
# Watcom's cwc.c is written in C and thus is usable even on a non-MS-DOS
# build machine.  Meanwhile, UPX yields smaller stubs.
ifneq "" "$(UPX)"
cwstub.exe: cw32.exe $(CWDEPS)
	$(UPX) --8086 --no-reloc --all-methods -9 -o $@.tmp $<
else
cwstub.exe: cw32.exe cwc-wat $(CWDEPS)
	./cwc-wat $< $@.tmp
endif
	mv $@.tmp $@
.PRECIOUS: cwstub.exe

# Rule to transform a compressed CauseWay loader stub into one which has a
# .e_lfanew field in its MZ header.  This may be useful for some purposes.
cwstubfa.exe: cwstub.exe $(CWDEPS)
	$(LFANEW) -o $@.tmp $<
	mv $@.tmp $@
.PRECIOUS: cwstubfa.exe

# Rules to build the CauseWay linker.  Use JWlink or wlink to build a
# stage-1 linker (cwl-pre.exe) which will contain a Linear Executable (LE)
# payload, then use that to build the final linker which will contain a 3P
# payload.
#
# We need to manually append the compressed stub to cwl.exe, to avoid using
# the stub in cwl-pre.exe.  cwl-pre.exe's stub will have been doctored by
# wlink, & may fail to properly locate the 3P payload.
cwl.exe: cwl-pre.exe $(CWLOBJ) cwstub.exe
	$(call cw-link,$<, \
		       /flat /nostub,$(CWLOBJ),$(@:.exe=.tmp),$(@:.exe=.map))
	cat cwstub.exe $(@:.exe=.tmp) >$@.tmp
	mv $@.tmp $@
	$(RM) $(@:.exe=.tmp)
.PRECIOUS: cwl.exe

cwl-pre.exe: $(CWLOBJ) cwstub.exe
	$(LINK) format os2 le op stub=cwstub.exe file $< name $@.tmp
	mv $@.tmp $@
.PRECIOUS: cwl-pre.exe

$(CWLOBJ): $(CWLMAIN) $(CWLDEPS)

# Rules to build Watcom's rewrite of the CauseWay Compressor.  This is
# apparently only useful for compressing the stub.
cwc-wat: watcom/cwc.c copystub.gh decstub.gh \
    watcom/watcom.h watcom/bool.h watcom/exedos.h watcom/pushpck1.h \
    watcom/poppck.h
	$(CC) $(CPPFLAGS) -Iwatcom -I. $(CFLAGS) $(LDFLAGS) $< -o $@ $(LDLIBS)
.PRECIOUS: cwc

mkcode: watcom/mkcode.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $< -o $@ $(LDLIBS)
.PRECIOUS: mkcode

# Rules to build Michael Devore's original CauseWay Compressor.  This can
# compress the 3P payload & has a number of other features not in Watcom's
# compressor.
cwc.exe: cwc-pre.exe
	$(call cw-compress,cwc-pre.exe,/l245,cwc-pre.exe,cwc.exe)
.PRECIOUS: cwc.exe

cwc-pre.exe: source/all/cwc/cwc.o cw.lib cwl.exe
	$(call cw-link,cwl.exe,/flat,$<,$@,$(@:.exe=.map))
.PRECIOUS: cwc-pre.exe

source/all/cwc/cwc.o: source/all/cwc/cwc.asm copystub.inc decstub.inc

# Rules to build the CauseWay debugger driver executable.
cwd.exe: $(CWDDEPS)
	$(ASM) -mz -DENGLISH=1 -DCONTRIB=1 -Fo$@.tmp -Fl$(@:.exe=.lst) \
	    $(CWDMAIN)
	mv $@.tmp $@
.PRECIOUS: cwd.exe

# Rules to build the CauseWay debugger overlay file.
cwd.ovl: cwd-pre.ovl cwc.exe
	$(call cw-compress,cwc.exe,/l245,$<,$@)
.PRECIOUS: cwd.ovl

cwd-pre.ovl: $(CWDVOBJ) cwl.exe
	$(call cw-link,cwl.exe,,$<,$@,$(@:.ovl=.map))
.PRECIOUS: cwd-pre.ovl

$(CWDVOBJ): $(CWDVDEPS)

# Rules to build the test program for dual mode.
dual.exe: cwstub.exe dual.3p
	cat $^ >$@.tmp
	mv $@.tmp $@

dual.3p: tests/dual.asm $(CWDEPS)
	$(ASM) -bin -Fo$@.tmp -Fl$(@:.3p=.lst) $<
	mv $@.tmp $@
.PRECIOUS: dual.3p

# Rules to build CauseWay's utility library from sources.
$(CWLIB): $(CWLIBOBJS)
	$(RM) $@
	$(XLIB) $@ $(CWLIBOBJS:%=+%)
.PRECIOUS: $(CWLIB)

# Rule to build JWasm.
./jwasm:
	$(RM) -r JWasm.build
	$(GIT) submodule update --init JWasm.src
	cp -a JWasm.src JWasm.build
	mkdir -p JWasm.build/build/GccUnixR
	$(MAKE) -C JWasm.build -f GccUnix.mak
	cp JWasm.build/build/GccUnixR/jwasm $@.tmp
	mv $@.tmp $@
.PRECIOUS: ./jwasm

# Rules to build JWlink.  JWlink currently only works properly if long is
# 32-bit & pointers are at most 32 bits...
./jwlink : export CC := $(CC) -O2 -static $(shell \
	if (echo '#ifdef __LP64__'; echo '#error'; echo '#endif') | \
	    $(CC) -E -dM -x c - -o /dev/null >/dev/null 2>/dev/null; \
		then :; \
		else echo ' -m32'; \
	fi)
./jwlink:
	$(RM) -r JWlink.build
	$(GIT) submodule update --init JWlink.src
	cp -a JWlink.src JWlink.build
	$(MAKE) -C JWlink.build/dwarf/dw -f GccUnix.mak
	$(MAKE) -C JWlink.build/orl -f GccUnix.mak
	$(MAKE) -C JWlink.build/sdk/rc/wres -f GccUnix.mak
	$(MAKE) -C JWlink.build -f GccUnix.mak
	cp JWlink.build/GccUnixR/jwlink $@.tmp
	mv $@.tmp $@
.PRECIOUS: ./jwlink

# Rule to patch & build David Lindauer's xlib.
./xlib:
	$(RM) -r xlib.build xlib.zip
	$(GIT) submodule update --init xlib.src
	cp -a xlib.src xlib.build
	set -e; \
	cd xlib.build/xlib; \
	for f1 in *.[cHP]; do \
		f2="`echo "$$f1" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ \
				      abcdefghijklmnopqrstuvwxyz`"; \
		sed -e 's,\.\.\\,../,g' -e '/\/\* STATIC \*\// s,^,//,' \
		    -e '/^static BOOL ReadArgs/ '` \
		       `'s/^/static BOOL ReadResponse(char *, int *, int *);/'\
		    -e '/^void BoolSetup/ s/^/static /' \
		    -e '/^#include <dos\.h>/ s,^,//,' \
		    -e '/^#include <windows\.h>/ s,^,//,' \
		    -e 's/\*p++ = (char)toupper(\*p)/p++/' \
		    "$$f1" >"$$f2".tmp; \
		mv "$$f2".tmp "$$f2"; \
	done
	set -e; \
	cd xlib.build/xlib; \
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -DMSDOS \
	    allocate.c args.c dict.c error.c ext.c fatal.c hash.c import.c \
	    lib.c list.c module.c unmangle.c usage.c xlib.c \
	    -o '$(abspath $@)' $(LDLIBS)
.PRECIOUS: ./xlib

# Rule to build lfanew.
./lfanew:
	$(RM) -r lfanew.build
	mkdir lfanew.build
	cd lfanew.build && ../lfanew.src/configure
	$(MAKE) -C lfanew.build
	cp lfanew.build/lfanew $@
.PRECIOUS: ./lfanew

# Rules to download various programs and disk images for tests.

FD12FLOPPY.zip:
	rm -f $@.tmp
	wget -O $@.tmp https://archive.org/download/FD12FLOPPY/FD12FLOPPY.zip
	mv $@.tmp $@
.PRECIOUS: FD12FLOPPY.zip

csdpmi7b.zip:
	wget -O $@.tmp http://sandmann.dotster.com/cwsdpmi/csdpmi7b.zip
	mv $@.tmp $@
.PRECIOUS: csdpmi7b.zip
