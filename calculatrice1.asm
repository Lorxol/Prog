				org			$0
vector_000      dc.l		$ffb500
vector_001		dc.l		Main
				org			$500	

;Main			movea.l		#String2,a0
;				jsr			Convert

Main			lea			String,a0
				move.b		#24,d1
				move.b		20,d2
				jsr Print

				illegal
				
Print			movem.l		d0/d1/a0,-(a7)

\loop			move.l		(a0)+,d0
				beq			\quit
				
				jsr PrintChar
				addq.b		#1,d1
				bra			\loop
				
\quit			movem.l		(a7)+,d0/d1/a0
				rts



PrintChar		incbin		"PrintChar.bin"

sTest			dc.b		"Hello World",0










RemoveSpace
				movem.l		d0/a0/a1,-(a7)
				
				
				movea.l		a0,a1
				
				
\loop		
				move.b		(a0)+,d0
				
				cmpi.b		#' ',d0
				beq			\loop
				
				
				move.b		d0,(a1)+
				bne			\loop
				
\quit
				movem.l		(a7)+,d0/a0/a1
				rts
				
Convert
				tst.b		(a0)
				beq			\false
				
				jsr			IsCharError
				beq			\false
				
				jsr			Atoui
				
\true			ori.b		#%00000100,ccr
				rts
				
\false			andi.b		#%11111011,ccr
				rts


IsCharError
				movem.l		d0/a0,-(a7)

\loop
				move.b		(a0)+,d0
				beq			\false
				
				cmpi.b		#'0',d0
				blo			\true
				
				cmpi.b		#'9',d0
				bls			\loop
				
\true			ori.b		#%00000100,ccr
				bra			\quit
				
\false			andi.b		#%11111011,ccr

\quit			movem.l		(a7)+,d0/a0
				rts
				
				
Atoui			movem.l		d1/a0,-(a7)
				clr.l		d0
				clr.l		d1
				
\loop			move.b		(a0)+,d1
				beq			\quit
				
				
				subi.b		#'0',d1
				mulu.w		#10,d0
				add.l		d1,d0
				bra			\loop
				
\quit			movem.l		(a7)+,d1/a0
				rts
				
String			dc.b		"Il y a 7 espaces dans cette chaine",0
String2			dc.b		"666666",0
