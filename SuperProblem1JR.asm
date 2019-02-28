COMMENT*
		Julio Rosario 4/6/17
		
		Super problem #1 Java Insert
*COMMENT

Include Irvine32.inc
x textequ<DL>
y textequ<DH>
clearScreen textequ<call Clrscr>

.data
prompt1 byte "Enter a string:  ",0
prompt2 byte "Enter what you want to insert: ",0
prompt3 byte  "What is the location of the insert: ",0

str1 byte 21 DUP(0)
count1 dword ?

str2 byte 21 DUP(0)
count2 dword ?

location DWORD ?
space byte " ",0


.code 
main PROC

	call getStr1
	call getStr2
	call getLocation 

	clearScreen

	MOV x,10
	MOV y,5
     call displayStr2

	MOV x,10
	MOV y,10
	call displayStr1
	
	call movStr2To9
	call movToInsertPoint

	call displayChar
     call insert
exit
main ENDP

;-----------------------------------
;Get the first string from the user.
;_____________________________________
getStr1 PROC USES EDX ECX EAX
	
	;Display message
	MOV EDX,offset prompt1
	call writestring

	;Read input
	MOV EDX,offset str1
	MOV  ECX,SIZEOF str1		
	call readString
	call crlf
	MOV count1, EAX		;number of character enter by user.
ret
getStr1 ENDP

;-----------------------------------
;Get the second string from the user.
;___________________________________
getStr2 PROC USES EDX ECX EAX

	;Display message
	MOV EDX,offset prompt2
	call writestring

	;Read input
	MOV EDX,offset str2
	MOV  ECX,SIZEOF str2		
	call readString
	call crlf
	MOV count2, EAX	;number of character enter by user.
ret
getStr2 ENDP

;-------------------------------
;Get the location of the insert.
;________________________________
getLocation PROC

	;Display message
	MOV EDX,offset prompt3
	call writeString

	;Read input.
	call readdec
	MOV location,EAX
ret
getLocation ENDP

;----------------------------
;Display string # 2
;_________________________________
displayStr2 PROC USES EDX
	
	call gotoXY
	MOV EDX, offset str2
	call writeString
ret
displayStr2 ENDP

;---------------------------------
;Display string # 1
;_________________________________
displayStr1 PROC USES EDX
	
	call gotoXY
	MOV EDX, offset str1
	call writeString
ret
displayStr1 ENDP

;------------------------------------
;repaint with space
;____________________________________
repaint PROC USES EDX 
	MOV EDX,offset space
	call writestring
ret
repaint ENDP

;-------------------------------------
;Move string # 2 to position (10,9)
;_____________________________________
movStr2To9 PROC USES EAX ECX EDX 

	MOV EAX,1000				;Delay 1 second.

	;Go back to position of str2
	MOV x,10                  
	MOV y,5

	;put str2 at position 10,9
	MOV ECX,4
	L1:
		call gotoXY
		call repaint
	     inc y

		call displayStr2
		call delay
	LOOP L1
ret
movStr2To9 ENDP

;--------------------------------
;Move string # 2 to location
;________________________________
movToInsertPoint proc USES  EAX ECX EDX 

	MOV EAX,1000				;Delay 1 second.

	;Go back to position of str2
	MOV x,9                  
	MOV y,9

	;put str2 at position 10,9
	MOV ECX,location
	L1:
		
		call gotoXY
		call repaint

		inc x
		call displayStr2
		call delay
	LOOP L1

ret
movToInsertPoint ENDP
displayChar PROC USES  EDX ESI ECX EAX EBX

	MOV EAX,1000					;For delay
	;point to coordinate of location
	MOV EBX, location
	MOV x,9
	add x,BL
	MOV y,10
	call gotoXY

	call delay
	;Create space for location
	MOV EDX, offset space
	call writestring
	
	MOV ESI,offset str1   ;Create pointer to string # 1
	add ESI,location     ;Start pointer from location 
	dec ESI

	MOV ECX,count1      ;Store the number of characters into ECX
	inc ECX             
	sub ECX,location    ;Subtract location from the length of str1
	L1:
	     MOV EAX,[ESI]
	     call writechar
	     inc ESI
	LOOP L1
	call crlf
	
	ret
displayChar ENDP

insert PROC USES EDX EBX EAX

    ;Put the insert where it belongs
	MOV EAX,1000		;Set the delay to 1 second.

	MOV EBX,0
	MOV EBX,location

	MOV x,9
	add x,BL
	MOV y,9
	call gotoXY
	call repaint

	inc y
	call gotoXY
	
	MOV ESI, offset str2
	MOV ECX,count2
	L1:
		MOV AL,[ESI]
		call writechar
		inc ESI
	LOOP L1
	call crlf

ret
insert ENDP


END main