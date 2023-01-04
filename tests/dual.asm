; Copyright (c) 2023 TK Chia
;
; Permission is hereby granted, free of charge, to any person obtaining a
; copy of this software and associated documentation files (the "Software"),
; to deal in the Software without restriction, including without limitation
; the rights to use, copy, modify, merge, publish, distribute, sublicense,
; and/or sell copies of the Software, and to permit persons to whom the
; Software is furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

MGROUP	group	HEADER,TEXT

HEADER		segment para
hstart:
	db	'3P'			; signature
					; 3P module size
tsize	equ	offset TEXT:tend-offset TEXT:tstart
msize	equ	offset MGROUP:tend
ssize	equ	1000h
	dd	msize			; 3P module size
	dd	tsize			; program image size
	dd	tsize+ssize		; memory required
	dw	2			; no. of segment definitions
	dd	0			; no. of relocations
	dd	offset TEXT:tstart	; initial cs:eip
	dw	0
	dd	ssize			; initial ss:esp
	dw	1
					; executable flags: 16-bit interrupt
					; stack frame, use LDT, 16-bit
					; default data size, dual mode
	dd	(1 shl 0)+(1 shl 7)+(1 shl 14)+(1 shl 16)
	dd	0			; automatic stack size
	dw	0			; no. of automatic data segments + 1
	dd	0			; length of EXPORT section
	dd	0			; length of IMPORT section
	dd	0			; no. of IMPORT modules
	db	10 dup (?)		; reserved
	; segment definition for TEXT
	dd	0			; start offset
					; length & type: code, D = 0
	dd	tsize+(0 shl 21)+(1 shl 25)
	; segment definition for STACK
	dd	tsize			; start offset
					; length & type: data, D = 0
	dd	ssize+(1 shl 21)+(1 shl 25)
hend:
HEADER		ENDS

TEXT		segment para
tstart:
	mov	ax,4c00h
	int	21h
tend:
TEXT		ends

	end
