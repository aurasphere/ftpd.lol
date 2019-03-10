	HAI 1.4
	CAN HAS STDIO?
	CAN HAS SOCKS?
	CAN HAS STRING?
	
	BTW variables
	I HAS A command_socket
	I HAS A command_connection
	I HAS A data_socket
	I HAS A data_connection
	I HAS A incoming_command
	I HAS A connection_open ITZ FAIL
	
	BTW dec-hex converter
	O HAI IM dec_hex_converter
		BTW use string and charat
		I HAS A hex0 ITZ "0"
		I HAS A hex1 ITZ "1"
		I HAS A hex2 ITZ "2"
		I HAS A hex3 ITZ "3"
		I HAS A hex4 ITZ "4"
		I HAS A hex5 ITZ "5"
		I HAS A hex6 ITZ "6"
		I HAS A hex7 ITZ "7"
		I HAS A hex8 ITZ "8"
		I HAS A hex9 ITZ "9"
		I HAS A hex10 ITZ "A"
		I HAS A hex11 ITZ "B"
		I HAS A hex12 ITZ "C"
		I HAS A hex13 ITZ "D"
		I HAS A hex14 ITZ "E"
		I HAS A hex15 ITZ "F"
		
		I HAS A dec0 ITZ "0"
		I HAS A dec1 ITZ "1"
		I HAS A dec2 ITZ "2"
		I HAS A dec3 ITZ "3"
		I HAS A dec4 ITZ "4"
		I HAS A dec5 ITZ "5"
		I HAS A dec6 ITZ "6"
		I HAS A dec7 ITZ "7"
		I HAS A dec8 ITZ "8"
		I HAS A dec9 ITZ "9"
		I HAS A decA ITZ "10"
		I HAS A decB ITZ "11"
		I HAS A decC ITZ "12"
		I HAS A decD ITZ "13"
		I HAS A decE ITZ "14"
		I HAS A decF ITZ "15"
		
		BTW ---- tested OK
		HOW IZ I dec_to_hex YR number
			I HAS A remainder
			I HAS A result ITZ ""
			IM IN YR loop NERFIN YR mom WILE DIFFRINT number AN SMALLR OF number AN 0
				remainder R MOD OF number AN 16
				I HAS A digit_var_name ITZ SMOOSH "hex" AN remainder MKAY
				VISIBLE digit_var_name
				result R SMOOSH ME'Z SRS digit_var_name AN result MKAY
				number R QUOSHUNT OF number AN 16
			IM OUTTA YR loop
			FOUND YR result
		IF U SAY SO
		
		HOW IZ I hex_to_dec YR number
			I HAS A num_length ITZ I IZ STRING'Z LEN YR number MKAY
			I HAS A curr_digit
			I HAS A result ITZ 0
			IM IN YR loop UPPIN YR i WILE DIFFRINT i AN BIGGR OF i AN num_length
				curr_digit R I IZ STRING'Z AT YR number AN YR i MKAY
				I HAS A digit_var_name ITZ SMOOSH "dec" AN curr_digit MKAY
				result R SUM OF PRODUKT OF 16 AN result AN ME'Z SRS digit_var_name
			IM OUTTA YR loop
			FOUND YR result
		IF U SAY SO
	
	KTHX
	
	BTW binds sockets
	command_socket R I IZ SOCKS'Z BIND YR "0.0.0.0" AN YR 21 MKAY
	data_socket R I IZ SOCKS'Z BIND YR "0.0.0.0" AN YR 101 MKAY
	
	BTW ------------- substring (last index not inclusive) tested OK
	HOW IZ I substring YR string AN YR start AN YR end
		I HAS A cursor ITZ start
		I HAS A result ITZ ""
		I HAS A curr_char ITZ ""
		
		BTW assuming parameters are correct for the moment
		IM IN YR loop UPPIN YR cursor TIL BOTH SAEM cursor AN end
			DIFFRINT cursor AN BIGGR OF cursor AN start
			O RLY?
				YA RLY
				NO WAI,
					curr_char R I IZ STRING'Z AT YR string AN YR cursor MKAY
					result R SMOOSH result AN curr_char MKAY
			OIC
		IM OUTTA YR loop
		FOUND YR result
	IF U SAY SO
	BTW ------------- substring
	
	BTW ------------- tokenizer generator (bug: 2 consecutive tokens return FAIL) tested OK
	HOW IZ I tokenizer_generator YR string AN YR separator AN YR position
		I HAS A tokens_counter ITZ 0
		I HAS A curr_char ITZ ""
		I HAS A last_token_start_index ITZ 0
		I HAS A last_token_end_index ITZ 0
		I HAS A str_length ITZ I IZ STRING'Z LEN YR string MKAY
		
		BTW position to the current token 
		IM IN YR loop UPPIN YR i TIL BOTH SAEM i AN str_length
			curr_char R I IZ STRING'Z AT YR string AN YR i MKAY
			ANY OF BOTH SAEM curr_char AN ":)" AN BOTH SAEM curr_char AN ":(D)" AN BOTH SAEM curr_char AN separator MKAY
			O RLY?
				YA RLY
					BTW last token is the separator since it's not inclusive
					last_token_end_index R i
					BOTH SAEM tokens_counter AN position
						O RLY?
							YA RLY
								FOUND YR I IZ substring YR string AN YR last_token_start_index AN YR last_token_end_index MKAY
							NO WAI
						OIC
					tokens_counter R SUM OF tokens_counter AN 1
					last_token_start_index R SUM OF last_token_end_index AN 1
				NO WAI
			OIC
		IM OUTTA YR loop
		FOUND YR FAIL
	IF U SAY SO
	BTW ------------- tokenizer generator
	
	BTW ------------- send a reply on the command socket
	HOW IZ I send_command YR reply
		I IZ send YR reply AN YR command_socket AN YR command_connection MKAY
	IF U SAY SO
	BTW ------------- send a reply on the command socket
	
	BTW ------------- send a reply on the data socket
	HOW IZ I send_data YR reply
		I IZ send YR reply AN YR data_socket AN YR data_connection MKAY
	IF U SAY SO
	BTW ------------- send a reply on the data socket

	BTW ------------- send a reply on a socket
	HOW IZ I send YR reply AN YR socket AN YR connection
		I IZ SOCKS'Z PUT YR socket AND YR connection AN YR SMOOSH reply AN ":)" MKAY MKAY
		VISIBLE "REPLY IZ " AN reply
	IF U SAY SO
	BTW ------------- send a reply on a socket

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
	
	BTW ------------- decode hex port
	HOW IZ I decode_hex_port YR first_port_number AN YR second_port_number
		I HAS A first_hex ITZ I IZ dec_to_hex MKAY
	IF U SAY SO
	BTW ------------- decode hex port
	
	BTW ------------- handle command
	HOW IZ I handle_command
		I HAS A first_token ITZ I IZ tokenizer_generator YR incoming_command AN YR " " AN YR 0 MKAY
		first_token, WTF?
			OMG "USER"
				I IZ send_command YR "202 OH HAI ANON" MKAY
				GTFO
			OMG "PASS"
				I IZ send_command YR "202 NAH ITZ OKAI" MKAY
				GTFO
			OMG "PASV"
				I IZ send_command YR "227 I GONNA DO IT" MKAY
				GTFO
			OMG "PWD"
				I IZ send_command YR "257 :"/LUL:" GOTCHA YR FOLDR" MKAY
				GTFO
			OMG "QUIT"
				connection_open R FAIL
				I IZ send_command YR "221 BUH-BYE" MKAY
				GTFO
			OMG "TYPE"
				BTW todo check type, currently I
BTW				reply_command R "504 WATZ TTAT"
				I IZ send_command YR "200 OH YA SENDIN PICS, COOL" MKAY
				GTFO
			OMG "PORT"
				BTW builds the given IP
				I HAS A port_argument ITZ I IZ tokenizer_generator YR incoming_command AN YR " " AN YR 1 MKAY
				I HAS A final_ip
				IM IN YR loop UPPIN YR i TIL BOTH SAEM i AN 4
					final_ip R SMOOSH final_ip AN I IZ tokenizer_generator YR port_argument AN YR "," AN YR i MKAY MKAY
					BOTH SAEM i AN 3
					O RLY?
						YA RLY
						NO WAI, final_ip R SMOOSH final_ip AN "." MKAY
					OIC
				IM OUTTA YR loop
				
				BTW builds the given port from hexadecimal
				I HAS A first_port_number ITZ I IZ tokenizer_generator YR port_argument AN YR "," AN YR 4 MKAY
				I HAS A second_port_number ITZ I IZ tokenizer_generator YR port_argument AN YR "," AN YR 5 MKAY
				
				I HAS A final_port ITZ I IZ decode_hex_port YR first_port_number AN YR second_port_number MKAY
				
				BTW connects to the given data port
				data_connection R I IZ SOCS'Z KONN YR data_socket AN YR final_ip AN YR final_port MKAY
							
				I IZ send_command YR "200 IS TAT A DOOR" MKAY
				GTFO
			OMG "LIST"
				I HAS A list ITZ I IZ read YR "whitelist.lul" MKAY
				list, O RLY?
						YA RLY,
							I IZ send_command YR "150 Opening" MKAY
							I IZ send_data YR list MKAY
							I IZ send_command YR "226 fin" MKAY
						NO WAI,
								I IZ send_command YR "421 O NOES MA LIST" MKAY
					OIC
				GTFO
			OMG "FEAT"
				I IZ send_command YR "502 WAT" MKAY
				GTFO
			OMG "SYST"
				I IZ send_command YR "215 LOL I AM" MKAY
				GTFO
			OMG "CWD"
				I IZ send_command YR "250 WERE U GOIN" MKAY
				GTFO
			OMG "REST"
				I IZ send_command YR "350 WATCHA WAITIN FOR" MKAY
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
				I IZ send_command YR "200 YA SLEEPN?" MKAY
				GTFO
			OMGWTF
				I IZ send_command YR "502 WAT" MKAY
				GTFO
		OIC
	IF U SAY SO
	BTW ------------- handle command
	
	dec_hex_converter IZ hex_to_dec YR "FE" MKAY
	VISIBLE IT
	
	BTW connection loop
	IM IN YR connection_loop
	
		BTW listens for a connection
		command_connection R I IZ SOCKS'Z LISTN YR command_socket MKAY
		
		BTW welcome message
		I IZ send_command YR "220 TIS WORKIN? U LISTENIN?:)" MKAY
		connection_open R WIN
		
		IM IN YR session_loop NERFIN YR mom TIL NOT connection_open

			BTW reads the next command and reply
			incoming_command R I IZ SOCKS'Z GET YR command_socket AN YR command_connection AN YR 1024 MKAY
			VISIBLE "CMD IZ " AN incoming_command
			I IZ handle_command MKAY
	
		IM OUTTA YR session_loop
		
		BTW closes the connection
		I IZ SOCKS'Z CLOSE YR command_connection MKAY
		
	IM OUTTA YR connection_loop
	
	BTW closes the socket
    I IZ SOCKS'Z CLOSE YR command_socket MKAY
	
KTHXBYE