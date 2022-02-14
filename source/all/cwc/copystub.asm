	.model tiny
	option oldstructs
	option proc:private

CWCStackSize	equ	1024	; cannot exceed EXECopyStubLen size (1135 bytes)

	.code

var_struc	struc
;	db 100h-10h dup (0)
	db CWCStackSize-10h dup (0)

var_SourceSeg	dw ?
var_CopyLen	dw ?
var_EntryIP	dw 0
var_EntryCS	dw ?
var_ImageLen	dw ?,?
var_EntryES	dw ?
var_struc	ends

b	equ	byte ptr
w	equ	word ptr
d	equ	dword ptr
f	equ	fword ptr

start:	cli
	push	ss		;make data addressable.
	pop	ds
	mov	ax,es:[2]		;Get highest address.

;	sub	ax,10h
	sub	ax,(CWCStackSize/10h)

	mov	ss,ax
	sti
	push	es
	push	ss
	pop	es
;	mov	si,100h-10h
	mov	si,CWCStackSize-10h

	mov	di,si
	mov	cx,10h
	rep	movsb
	pop	es
	mov	ss:w[var_EntryES],es	;need this for program entry.
	;
	;Setup destination copy address.
	;
	mov	bx,ax
	mov	dx,cs
	add	dx,ss:w[var_SourceSeg]
	mov	bp,ss:w[var_CopyLen]
	;
	;Do the copy.
	;
	std
@@0:	mov	ax,bp
	cmp	ax,1000h
	jbe	@@1
	mov	ax,1000h
@@1:	sub	bp,ax
	sub	dx,ax
	sub	bx,ax
	mov	ds,dx
	mov	es,bx
	mov	cl,3
	shl	ax,cl
	mov	cx,ax
	shl	ax,1
	dec	ax
	dec	ax
	mov	si,ax
	mov	di,ax
	rep	movsw
	or	bp,bp
	jnz	@@0
	;
	;Point to the data to decompress.
	;
	mov	si,es
	mov	ds,si
	xor	si,si
	mov	di,cs
	mov	es,di
	xor	di,di
	;
	;Setup the decompressor entry address.
	;
	mov	ax,ds
	add	ss:w[var_EntryCS],ax
	;
	;Jump into the decompressor code.
	;
	jmp	ss:dword ptr[var_EntryIP]

IFNDEF CONTRIB
	db 1056 dup (0)
ELSE
        ifndef ENGLISH
ENGLISH equ     0
        endif
        ifndef SPANISH
SPANISH equ     0
        endif

code_end:
        db (512-32)-($-start) dup (0)

        ;MS-DOS 1.x rounds the .exe header size up to a 512-byte boundary,
        ;and will start running the program here.  -- tkchia
dos1_start:
        call @@9
        db "CauseWay error 04 : "
        if ENGLISH
        db 'DOS 3.1 or better required.',13,10,'$'
        elseif SPANISH
        db "DOS 3.1 o superior requerido.",13,10,"$"
        endif
@@9:
        pop dx
        push cs
        pop ds
        mov ah,9
        int 21h
        push es
        xor ax,ax
        push ax
        retf

        db 1056-($-code_end) dup (0)
ENDIF

	end	start

