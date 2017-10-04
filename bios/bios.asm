;    Copyright (C) 2017 Nicolas Sauzede <nsauzede@laposte.net>
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Simple 8088 BIOS to demonstrate a bug of FLAGS update after a repz cmpsb in the CPU86 free IP implementation,
; compared to behaviour on real silicium, or even on QEMU execution

; on real x86 :
; repz cmspb 1,61,61 : 002 => 046 (PF ZF)
; repz cmspb 1,61,6f : 002 => 002 ()
; int main(){
; char si[]="o", di[]="a";
; asm volatile("inc %%rcx\n"
; "repz cmpsb\n"
; :: "D"(di), "S"(si), "c"(0));
; return 0;
; }

org 0

; on cpu86 :
; repz cmspb 1,61,61 : 002 => 046 (PF ZF)
; repz cmspb 1,61,6f : 002 => 046 (PF ZF) BUGBUGBUG!!!
bits 16
cpu 8086

times (65536 - (end - start)) db 0x90

start:

boot:

;from intel 8086 family user manual 1979 :
; cpu state following reset :
; flags 				clear
; instrucion pointer	0000
; cs register			ffff
; ds register			0000
; ss register			0000
; es register			0000
; queue					empty

;from QEMU :
;at boot, DS=SI=DI=CX=0, CS=F000, IP=FFF0
;call here1
;here1:
;pop si
;call here2
;here2:
;pop di
dec si		; => f096 (PF AF SF)
mov ds,si
mov es,si
inc si
inc cx
inc di		; => f002 ()
repz cmpsb	; => 
jmp $

boot_end:

times (16 - (boot_end - boot)) db 0xff

end:
