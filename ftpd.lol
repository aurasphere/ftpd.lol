HAI 1.4
	CAN HAS STDIO?
	CAN HAS SOCKS?
	CAN HAS STRING?
	
	BTW variables
	I HAS A sock
	I HAS A conn
	I HAS A incoming_command
	I HAS A connection_open ITZ FAIL
	
	BTW binds a socket to port 22
	sock R I IZ SOCKS'Z BIND YR "127.0.0.1" AN YR 22 MKAY
	
	BTW ------------- reads a file and returns content
	HOW IZ I read YR file
		I HAS A content ITZ ""
		I HAS A open_file ITZ I IZ STDIO'Z OPEN YR file AN YR "r" MKAY
		I IZ STDIO'Z DIAF YR open_file MKAY
		O RLY?
			YA RLY
				BTW error
				VISIBLE "FIEL " AN file AN " FOUNDNT"
			NO WAI
				BTW read file content and close it
				content R I IZ STDIO'Z LUK YR open_file AN YR 10240 MKAY
				I IZ STDIO'Z CLOSE YR open_file MKAY
		OIC
		FOUND YR content
	IF U SAY SO
	BTW ------------- reads a file and returns content
	
	BTW ------------- gets first token, TESTED OK TODO: tokenizza invece e torna un BUKKIT (considera 1 elemento contiene lunghezza array se lenght non disponibile
	HOW IZ I get_first_token YR command
		I HAS A char
		I HAS A first_token ITZ ""
		I HAS A i ITZ 0
		I HAS A str_length ITZ I IZ STRING'Z LEN YR command MKAY
		IM IN YR loop UPPIN YR i TIL BOTH SAEM i AN str_length  
			char R I IZ STRING'Z AT YR command AN YR i MKAY
			ANY OF BOTH SAEM char AN " " AN BOTH SAEM char AN ":)" AN BOTH SAEM char AN ":(D)" MKAY, O RLY?
				YA RLY, FOUND YR first_token
				NO WAI, first_token R SMOOSH first_token AN char MKAY
			OIC
		IM OUTTA YR loop
		FOUND YR first_token
	IF U SAY SO
	BTW ------------- gets first token
	
	BTW ------------- builds replies
	HOW IZ I reply
		I HAS A reply_command
		I HAS A first_token ITZ I IZ get_first_token YR incoming_command MKAY
		first_token, WTF?
			OMG "USER"
				reply_command R "202 OH HAI ANON"
				GTFO
			OMG "PASS"
				reply_command R "202 NAH ITZ OKAI"
				GTFO
			OMG "PASV"
				reply_command R "227 I GONNA DO IT"
				GTFO
			OMG "PWD"
				reply_command R "257 :"/LUL:" GOTCHA YR FOLDR"
				GTFO
			OMG "QUIT"
				connection_open R FAIL
				reply_command R "221 BUH-BYE"
				GTFO
			OMG "TYPE"
				BTW todo check type, currently I
BTW				reply_command R "504 WATZ TTAT"
				reply_command R "200 OH YA SENDIN PICS, COOL"
				GTFO
			OMG "PORT"
				reply_command R "200 IS TAT A DOOR"
				GTFO
			OMG "LIST"
				I HAS A list ITZ I IZ read YR "whitelist.lul" MKAY
				VISIBLE "MA LIST " AN list
				list, O RLY?
						YA RLY,reply_command R SMOOSH "150-OP:)" AN list AN ":)150 END:)226 FIUU" MKAY
						NO WAI,reply_command R "421 O NOES MA LIST"
					OIC
				GTFO
			OMG "MODE"
				
				GTFO
			OMG "STRU"
				
				GTFO
			OMG "RETR"
				
				GTFO
			OMG "STOR"
				
				GTFO
			OMG "NOOP"
				reply_command R "200 YA SLEEPN?"
				GTFO
			OMGWTF
				reply_command R "502 WAT"
				GTFO
		OIC
		FOUND YR reply_command
	IF U SAY SO
	BTW ------------- builds replies
	
	BTW connection loop
	IM IN YR connection_loop
	
		BTW listens for a connection
		conn R I IZ SOCKS'Z LISTN YR sock MKAY
		
		BTW welcome message
		I IZ SOCKS'Z PUT YR sock AND YR conn AN YR "220 TIS WORKIN? U LISTENIN?:)" MKAY
		VISIBLE "220 TIS WORKIN? U LISTENIN?"
		connection_open R WIN
		
		IM IN YR session_loop NERFIN YR mom TIL NOT connection_open

			BTW reads the next command
			incoming_command R I IZ SOCKS'Z GET YR sock AN YR conn AN YR 1024 MKAY
			VISIBLE "CMD IZ " AN incoming_command
		
			BTW reply
			I HAS A reply_command ITZ I IZ reply MKAY
			I IZ SOCKS'Z PUT YR sock AND YR conn AN YR SMOOSH reply_command AN ":)" MKAY MKAY
			VISIBLE "REPLY IZ " AN reply_command
	
		IM OUTTA YR session_loop
		
		BTW closes the connection
		I IZ SOCKS'Z CLOSE YR conn MKAY
		
	IM OUTTA YR connection_loop
	
	BTW closes the socket
    I IZ SOCKS'Z CLOSE YR sock MKAY
	
KTHXBYE