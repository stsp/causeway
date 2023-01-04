goto a
# Copyright (c) 2023 TK Chia
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

:a
cwl
if errorlevel 2 goto x
dual
if errorlevel 1 goto x
fdsetup\bin\jemm386 load
if errorlevel 1 goto x
cwl
if errorlevel 2 goto x
dual
if errorlevel 1 goto x
cwsdpmi -p -s-
if errorlevel 1 goto x
set CAUSEWAY=DPMI
cwl
if errorlevel 2 goto x
dual
if errorlevel 1 goto x
@echo === Tests OK ===
:x
fdsetup\bin\fdapm poweroff
