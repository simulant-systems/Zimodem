!--------------------------------------------------
!- Sunday, May 14, 2017 10:00:41 PM
!- Import of : 
!- c:\src\zimodem\cbm8bit\cbmbbs64-128.prg
!- Commodore 64
!--------------------------------------------------
1 REM CBMBBS64/128  1200B 1.8+
2 REM UPDATED 03/11/2017 03:54P
10 POKE254,PEEK(186):IFPEEK(65532)=61THENPOKE58,254:CLR
15 OPEN5,2,0,CHR$(8):DIMPP$(25):P$="ok":POKE186,PEEK(254)
20 CR$=CHR$(13):PRINTCHR$(14);:SY=PEEK(65532):POKE53280,254:POKE53281,246
30 PRINT"{light blue}":IFSY=226THENML=49152:POKE665,73:POKE666,3
40 IFSY=226ANDPEEK(ML)<>76THENCLOSE5:LOAD"pml64.bin",PEEK(186),1:RUN
50 IFSY=61THENML=4864:POKE981,15:P=PEEK(215)AND128:IFP=128THENSYS30643
60 IFSY=61ANDPEEK(ML)<>76THENCLOSE5:LOAD"pml128.bin",PEEK(186),1:RUN
70 TM=ML+2000
80 I=TM
90 READA%:IFA%>=0THENPOKEI,A%:I=I+1:GOTO90
100 REM
101 REM
102 REM
110 P$="a"
120 PRINT"{clear}{down*2}C= BBS v1.0":PRINT"Requires 64Net WiFi firmware 1.8+"
130 PRINT"1200 baud version"
140 PRINT"By Bo Zimmerman (bo@zimmers.net)":PRINT:PRINT
197 REM --------------------------------
198 REM GET STARTED                    !
199 REM -------------------------------
200 UN=PEEK(254)
201 PH=0:PT=0:MV=ML+18:CR$=CHR$(13)+CHR$(10):QU$=CHR$(34)
202 PRINT "Initializing modem...";:GOSUB6000
203 GET#5,A$:IFA$<>""THEN203
205 PRINT#5,CR$;CR$;"athz0e0";CR$;
206 GOSUB900:IFP$<>"ok"THEN203
208 GET#5,A$:IFA$<>""THEN208
210 PRINT".";:PRINT#5,CR$;"ate0n0r0v1f3";CR$;
220 GOSUB900:IFP$<>"ok"THEN208
230 PRINT".";:PRINT#5,"ate0v1x1q0f3";CR$;CHR$(19);
240 GOSUB900:IFP$<>"ok"THENPRINT"Zimodem init failed: ";P$:STOP
250 PRINT"!":DIM HO$(30):DIM PO(30)
251 HO$(0)="cottonwoodbbs.dyndns.org":PO(0)=6502:HZ=1
252 HO$(1)="borderlinebbs.dyndns.org":PO(1)=6400:HZ=2
253 HO$(2)="centronian.servebeer.com":PO(2)=6400:HZ=3
260 OPEN1,UN,15:OPEN8,UN,8,"bbsphonebook,s,r"
270 INPUT#1,E:IFE<>0THENCLOSE8:CLOSE1:GOTO300
280 INPUT#8,HZ:FORI=1TOHZ:INPUT#8,HO$(I-1):INPUT#8,PO(I-1):NEXT
290 CLOSE8:CLOSE1
300 GOTO 1000
897 REM --------------------------------
898 REM GET E$ FROM MODEM, OR ERROR    !
899 REM -------------------------------
900 E$=""
910 SYSML
920 IFE$<>""ANDP$<>E$THENPRINT"{reverse on}{red}Comm error. Expected ";E$;", Got ";P$;"{light blue}{reverse off}"
925 RETURN
997 REM --------------------------------
998 REM THE MAIN LOOP                  !
999 REM -------------------------------
1000 PRINT:PRINT"{light blue}Main Menu:"
1010 PRINT" 1) Dial from Phonebook"
1020 PRINT" 2) Modify Phonebook"
1030 PRINT" 3) Quick Connect"
1035 PRINT" 4) Terminal mode"
1040 PRINT" 9) Quit"
1050 PRINT:PRINT"Enter a number: {reverse on} {reverse off}{left}";
1060 GOSUB5000:IFP$=""THEN1000
1070 P=VAL(P$):IFP=9THENCLOSE5:END
1080 IFP<1ORP>4THEN1050
1090 PRINT
1100 IFP=1THENGOSUB2000:GOTO1000
1110 IFP=2THENGOSUB3000:GOTO1000
1120 IFP=3THENGOSUB4000:GOTO1000
1124 IFP=4THENPRINT"{reverse on}{light green}Terminal mode. ";:GOSUB2430:GOTO1000
1130 PRINT"?!":GOTO1000
2000 PRINT:PRINT"{down}Dial from Phonebook:"
2020 FORI=1TOHZ
2030 PRINT STR$(I)+") ";HO$(I-1);":";MID$(STR$(PO(I-1)),2)
2080 NEXTI:PRINT:PRINT"Enter a number or RETURN: ";
2090 GOSUB5000:IFP$=""THENRETURN
2100 X=VAL(P$):IFX<1ORX>HZTHEN2000
2110 HO$=HO$(X-1):PO=PO(X-1)
2300 PRINT"{reverse on}{light green}Connecting to ";HO$;":";MID$(STR$(PO),2);"...{reverse off}{light blue}"
2310 GET#5,A$:IFA$<>""THEN2310
2320 PRINT#5,CR$;"athc";QU$;HO$;":";MID$(STR$(PO),2);QU$;CR$;
2330 GOSUB900:IFLEN(P$)>7ANDLEFT$(P$,7)="connect"THEN2400
2340 PRINT"{reverse on}{red}Unable to connect to ";HO$;":";MID$(STR$(PO),2)
2350 RETURN
2400 PRINT"{reverse on}{light green}* Connected. ";
2420 PRINT#5,CR$;"ato";CR$;
2430 IFSY=226THENPRINT"Hit F1 to exit.{light gray}"
2440 IFSY=61THENPRINT"Hit ESC to exit.{light gray}"
2450 POKE53280,0:POKE53281,0:SYSTM:POKE53280,254:POKE53281,246:
2460 PRINT:PRINT"{reverse off}{light blue}Hanging up...";:GOSUB6000
2470 PRINT:FORI=1TO100:GET#5,A$:NEXTI
2480 GET#5,A$:IFA$<>""THEN2480
2490 RETURN
3000 PRINT:PRINT"{down}Modify Phonebook:"
3020 FORI=1TOHZ
3030 PRINT STR$(I)+") ";HO$(I-1);":";MID$(STR$(PO(I-1)),2):NEXTI
3040 PRINTSTR$(HZ+1)+") Add New Entry"
3080 PRINT:PRINT"Enter a number or RETURN: ";
3090 GOSUB5000:IFP$=""THENRETURN
3100 X=VAL(P$):IFX<1ORX>HZ+1THEN3000
3110 PRINT"Enter hostname/ip: ";:GOSUB5000:H$=P$:IFP$=""THEN3000
3120 PRINT"Enter port number (23): ";:GOSUB5000:HP=VAL(P$):IFHP<=0THENHP=23
3130 HO$(X-1)=H$:PO(X-1)=HP:IFX=HZ+1THENHZ=HZ+1
3140 OPEN1,UN,15:OPEN8,UN,8,"@0:bbsphonebook,s,w"
3150 INPUT#1,E:IFE<>0THENCLOSE8:CLOSE1:GOTO300
3160 PRINT#8,HZ:FORI=1TOHZ:PRINT#8,HO$(I-1):PRINT#8,PO(I-1):NEXTI
3170 CLOSE8:GOTO 3000
4000 PRINT:PRINT"Enter hostname/ip: ";:GOSUB5000:H$=P$:IFP$=""THENRETURN
4010 PRINT"Enter port number (23): ";:GOSUB5000:HP=VAL(P$):IFHP<=0THENHP=23
4020 HO$=H$:PO=HP:GOTO2300
4999 STOP
5000 P$=""
5005 PRINT"{reverse on} {reverse off}{left}";
5010 GETA$:IFA$=""THEN5010
5020 A=ASC(A$):IFA=13THENPRINT" {left}":RETURN
5025 IFA=34THENPRINTA$;A$;"{left}{reverse on} {reverse off}{left}";:P$=P$+A$:GOTO5010
5030 IFA<>20THENPRINTA$;"{reverse on} {reverse off}{left}";:P$=P$+A$:GOTO5010
5040 IFP$=""THEN5010
5050 P$=LEFT$(P$,LEN(P$)-1):PRINT" {left*2} {left}{reverse on} {reverse off}{left}";:GOTO5010
6000 IF(PEEK(56577)AND16)=0THENRETURN
6010 FORI=1TO4:TT=TI+100:PRINT#5,"+";
6020 IFTI<TTTHEN6020
6030 PRINT".";:NEXTI:PRINT#5,"ath":TT=TI+200
6040 SYSML+12:IFTI<TTTHEN6040
6050 RETURN
39999 STOP
40000 OPEN1,8,15:OPEN8,8,8,"telnetml.bin,p,r":LN=41000:DN=0
40010 INPUT#1,E:IFE<>0THENCLOSE8:CLOSE1:STOP
40020 GET#8,A$:IFST>0THENCLOSE8:END
40030 IFA$=""THENA$=CHR$(0)
40035 A=ASC(A$):A$=MID$(STR$(A),2)
40040 IFDN=0THENPRINTMID$(STR$(LN),2);" data ";A$;:DN=DN+1:GOTO40020
40060 PRINT",";A$;:DN=DN+1
40070 IFDN=18THENPRINT:DN=0:LN=LN+10
40080 GOTO 40020
41000 DATA 162,5,32,198,255,32,228,255,201,0,240,7,201,10,240,3
41010 DATA 32,210,255,162,0,32,198,255,32,228,255,201,0,240,225,201,133,240
41020 DATA 4,201,27,208,4,32,204,255,96,72,162,5,32,201,255,104,32,210
41030 DATA 255,162,0,32,201,255,162,255,208,194,234
41999 DATA -1
49999 STOP
50000 OPEN5,2,0,CHR$(8)
50010 GET#5,A$:IFA$<>""THENPRINTA$;
50020 GETA$:IFA$<>""THENPRINT#5,A$;
50030 GOTO 50010
55555 F$="cbmbbs64-128":OPEN1,8,15,"s0:"+F$:CLOSE1:SAVE(F$),8:VERIFY(F$),8
