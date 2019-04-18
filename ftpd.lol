HAI 1.4
	CAN HAS STDIO?
	CAN HAS SOCKS?
	CAN HAS STRING?
	
	
	BTW global variables
	
	I HAS A command_socket
	I HAS A command_connection
	I HAS A data_ip ITZ ""
	I HAS A data_port
	I HAS A connection_open ITZ FAIL
	
	
	BTW libraries
	
	O HAI IM dec_hex_converter

		HOW IZ I dec_to_hex YR number
			I HAS A remainder
			I HAS A curr_digit
			I HAS A result ITZ ""
			IM IN YR loop NERFIN YR mom WILE DIFFRINT number AN SMALLR OF number AN 0
				remainder R MOD OF number AN 16
				remainder, WTF?
					OMG 10, curr_digit R "A", GTFO
					OMG 11, curr_digit R "B", GTFO
					OMG 12, curr_digit R "C", GTFO
					OMG 13, curr_digit R "D", GTFO
					OMG 14, curr_digit R "E", GTFO
					OMG 15, curr_digit R "F", GTFO
					OMGWTF, curr_digit R remainder, GTFO
				OIC
				result R SMOOSH curr_digit AN result MKAY
				number R QUOSHUNT OF number AN 16
			IM OUTTA YR loop
			FOUND YR result
		IF U SAY SO
		
		HOW IZ I hex_to_dec YR number
			I HAS A num_length ITZ I IZ STRING'Z LEN YR number MKAY
			I HAS A curr_digit_value
			I HAS A curr_char
			I HAS A result ITZ 0
			IM IN YR loop UPPIN YR i WILE DIFFRINT i AN BIGGR OF i AN num_length
				curr_char R I IZ STRING'Z AT YR number AN YR i MKAY
				curr_char, WTF?
					OMG "A", curr_digit_value R 10, GTFO
					OMG "B", curr_digit_value R 11, GTFO
					OMG "C", curr_digit_value R 12, GTFO
					OMG "D", curr_digit_value R 13, GTFO
					OMG "E", curr_digit_value R 14, GTFO
					OMG "F", curr_digit_value R 15, GTFO
					OMGWTF, curr_digit_value R curr_char, GTFO
				OIC
				result R SUM OF PRODUKT OF 16 AN result AN curr_digit_value
			IM OUTTA YR loop
			FOUND YR result
		IF U SAY SO
	
	KTHX
	
	O HAI IM strings_utilz
	
		BTW last index not inclusive
		HOW IZ I substring YR string AN YR start AN YR end
			I HAS A cursor ITZ start
			I HAS A result ITZ ""
			I HAS A curr_char ITZ ""
			
			BTW assuming parameters are correct
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

		BTW acts as a generator of tokens by returning the token at the given position on the given string using the given separator. There's a known bug: 2 consecutive separator in the string will return FAIL. Works only if string ends with ":)", ":(D)" or separator
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
								I HAS A result ITZ strings_utilz IZ substring YR string AN YR last_token_start_index AN YR last_token_end_index MKAY
								FOUND YR result
							NO WAI
						OIC
						tokens_counter R SUM OF tokens_counter AN 1
						last_token_start_index R SUM OF last_token_end_index AN 1
					NO WAI
				OIC
			IM OUTTA YR loop
			FOUND YR FAIL
		IF U SAY SO
	
	KTHX
	
	O HAI IM socks_utilz
	
		BTW binds sockets
		command_socket R I IZ SOCKS'Z BIND YR "0.0.0.0" AN YR 21 MKAY
		
		BTW sends a reply on the command socket
		HOW IZ I send_command YR reply
			socks_utilz IZ send YR reply AN YR command_socket AN YR command_connection MKAY
			VISIBLE "REPLY IZ " AN reply
		IF U SAY SO
		
		BTW sends a reply on the data socket
		HOW IZ I send_data YR reply
			I HAS A data_socket ITZ I IZ SOCKS'Z BIND YR "0.0.0.0" AN YR 0 MKAY
			I HAS A data_connection ITZ I IZ SOCKS'Z KONN YR data_socket AN YR data_ip AN YR data_port MKAY
			socks_utilz IZ send YR reply AN YR data_socket AN YR data_connection MKAY
			I IZ SOCKS'Z CLOSE YR data_connection MKAY
			I IZ SOCKS'Z CLOSE YR data_socket MKAY
		IF U SAY SO
	
		BTW reads a reply on the data socket
		HOW IZ I read_data
			I HAS A data_socket ITZ I IZ SOCKS'Z BIND YR "0.0.0.0" AN YR 0 MKAY
			I HAS A data_connection ITZ I IZ SOCKS'Z KONN YR data_socket AN YR data_ip AN YR data_port MKAY
			I HAS A incoming_data ITZ I IZ SOCKS'Z GET YR data_socket AND YR data_connection AN YR 102400 MKAY
			I IZ SOCKS'Z CLOSE YR data_connection MKAY
			I IZ SOCKS'Z CLOSE YR data_socket MKAY
			FOUND YR incoming_data
		IF U SAY SO
		
		BTW send a reply on a socket
		HOW IZ I send YR reply AN YR socket AN YR connection
			I IZ SOCKS'Z PUT YR socket AND YR connection AN YR SMOOSH reply AN ":)" MKAY MKAY
		IF U SAY SO
	
	KTHX

	O HAI IM file_utilz

		BTW reads a file and returns its content
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
					content R I IZ STDIO'Z LUK YR open_file AN YR 102400 MKAY
					I IZ STDIO'Z CLOSE YR open_file MKAY
			OIC
			FOUND YR content
		IF U SAY SO
		
		BTW writes on a file with the given permissions
		HOW IZ I write_file YR file_name AN YR file_content AN YR permission
			I HAS A file ITZ I IZ STDIO'Z OPEN YR file_name AN YR permission MKAY
			I IZ STDIO'Z SCRIBBEL YR file AN YR file_content MKAY
			I IZ STDIO'Z CLOSE YR file MKAY
		IF U SAY SO

	KTHX
	
	O HAI IM ftp_utilz
	
		BTW decodes an FTP PORT command
		HOW IZ I decode_hex_port YR first_port_number AN YR second_port_number
			I HAS A first_hex ITZ dec_hex_converter IZ dec_to_hex YR first_port_number MKAY
			I HAS A second_hex ITZ dec_hex_converter IZ dec_to_hex YR second_port_number MKAY
			I HAS A hex_port ITZ SMOOSH first_hex AN second_hex MKAY
			dec_hex_converter IZ hex_to_dec YR hex_port MKAY
		IF U SAY SO
		
		BTW stores an FTP file
		HOW IZ I store_file YR incoming_command AN YR permission
			
			BTW gets the file name
			I HAS A file_name ITZ strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR 1 MKAY
			I HAS A current_token
			IM IN YR loop UPPIN YR i
			
				BTW skips the first tokens
				DIFFRINT i AN BIGGR OF i AN 2
				O RLY?
					YA RLY
					NO WAI,
						BTW adds the next token to the string if present or stops
						current_token R strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR i MKAY
						
						current_token, O RLY?
							YA RLY,
								file_name R SMOOSH file_name AN " " AN current_token MKAY
							NO WAI,
								GTFO
						OIC
					OIC	
			IM OUTTA YR loop
			
			BTW stores the actual file
			socks_utilz IZ send_command YR "150 CAN HAS FIEL?" MKAY
			I HAS A content ITZ socks_utilz IZ read_data MKAY
			file_utilz IZ write_file YR file_name AN YR content AN YR permission MKAY
			socks_utilz IZ send_command YR "226 AWSOME THX" MKAY
		IF U SAY SO
		
		BTW returns the first message if the first parameter is the same allowed, otherwise returns the second one
		HOW IZ I allow_only YR valid_parameter AN YR incoming_command AN YR message_ok AN YR message_ko
			I HAS A actual_parameter ITZ strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR 1 MKAY
				BOTH SAEM actual_parameter AN valid_parameter
				O RLY?
					YA RLY,
						socks_utilz IZ send_command YR message_ok MKAY
						GTFO
					NO WAI,
						socks_utilz IZ send_command YR message_ko MKAY
						GTFO
				OIC
		IF U SAY SO
		
		BTW lists files in the main directory
		HOW IZ I list_files
			I HAS A list ITZ file_utilz IZ read YR "whitelist.lul" MKAY
			list, O RLY?
				YA RLY,
					socks_utilz IZ send_command YR "150 PUTTIN MA LIST INTO YR DOOR" MKAY
					socks_utilz IZ send_data YR list MKAY
					socks_utilz IZ send_command YR "226 LIST PUTTED MKAY" MKAY
				NO WAI,
					socks_utilz IZ send_command YR "421 O NOES MA LIST" MKAY
				OIC
		IF U SAY SO
		
	KTHX
	

	BTW command handler
	
	HOW IZ I handle_command YR incoming_command
		strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR 0 MKAY
		WTF?
			OMG "QUIT"
				connection_open R FAIL
				socks_utilz IZ send_command YR "221 BUH-BYE" MKAY
				GTFO
			OMG "RETR"
				I HAS A file_name ITZ strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR 1 MKAY
				I HAS A file ITZ file_utilz IZ read YR file_name MKAY
				file, O RLY?
					YA RLY,
						socks_utilz IZ send_command YR "150 CAN HAS FIEL?" MKAY
						socks_utilz IZ send_data YR file MKAY
						socks_utilz IZ send_command YR "226 AWSOME THX" MKAY
					NO WAI,
						socks_utilz IZ send_command YR "421 O NOES" MKAY
				OIC
				GTFO
			OMG "PORT"
				BTW builds the given IP (smoosh to fix stripped last :) )
				I HAS A port_argument ITZ SMOOSH strings_utilz IZ tokenizer_generator YR incoming_command AN YR " " AN YR 1 MKAY AN ":)" MKAY
				
				data_ip R ""
				IM IN YR loop UPPIN YR i TIL BOTH SAEM i AN 4
					data_ip R SMOOSH data_ip AN strings_utilz IZ tokenizer_generator YR port_argument AN YR "," AN YR i MKAY MKAY
					BOTH SAEM i AN 3
					O RLY?
						YA RLY
						NO WAI, data_ip R SMOOSH data_ip AN "." MKAY
					OIC
				IM OUTTA YR loop
				
				BTW builds the given port from hexadecimal
				I HAS A first_port_number ITZ strings_utilz IZ tokenizer_generator YR port_argument AN YR "," AN YR 4 MKAY
				I HAS A second_port_number ITZ strings_utilz IZ tokenizer_generator YR port_argument AN YR "," AN YR 5 MKAY
				
				data_port R ftp_utilz IZ decode_hex_port YR first_port_number AN YR second_port_number MKAY
							
				socks_utilz IZ send_command YR "200 IS TAT A DOOR" MKAY
				GTFO
			OMG "TYPE"
				BTW only ASCII allowed
				ftp_utilz IZ allow_only YR "A" AN YR incoming_command AN YR "200 OH YA SENDIN LETTERZ, COOL" AN YR "504 PLZ SEND LETTERZ" MKAY
				GTFO
			OMG "MODE"
				BTW only STREAM allowed
				ftp_utilz IZ allow_only YR "S" AN YR incoming_command AN YR "200 OIC ITZ LIEK WATER" AN YR "504 TAT A BRICK?" MKAY
				GTFO
			OMG "LIST"
				ftp_utilz IZ list_files MKAY
				GTFO
			OMG "NLST"
				ftp_utilz IZ list_files MKAY
				GTFO
			OMG "STOR"
				ftp_utilz IZ store_file YR incoming_command AN YR "w+" MKAY
				GTFO
			OMG "APPE"
				ftp_utilz IZ store_file YR incoming_command AN YR "a+" MKAY
				GTFO
			OMG "STRU"
				socks_utilz IZ send_command YR "200 U BUILT TIS?" MKAY
				GTFO
			OMG "USER"
				socks_utilz IZ send_command YR "202 OH HAI ANON" MKAY
				GTFO
			OMG "PASS"
				socks_utilz IZ send_command YR "202 ITZ OKAI" MKAY
				GTFO
			OMG "PASV"
				socks_utilz IZ send_command YR "202 NO U" MKAY
				GTFO
			OMG "PWD"
				socks_utilz IZ send_command YR "257 :"/LUL:" GOTCHA YR FOLDR" MKAY
				GTFO
			OMG "NOOP"
				socks_utilz IZ send_command YR "200 U DED?" MKAY
				GTFO
			OMG "ACCT"
				socks_utilz IZ send_command YR "202 ANON ONLY" MKAY
				GTFO
			OMG "CDUP"
				socks_utilz IZ send_command YR "202 NOTHIN UP" MKAY
				GTFO
			OMG "SMNT"
				socks_utilz IZ send_command YR "202 SOUNDZ LIEK MUCH WORK" MKAY
				GTFO
			OMG "REIN"
				socks_utilz IZ send_command YR "200 BIP BOP BUP MKAY" MKAY
				GTFO
			OMG "STOU"
				socks_utilz IZ send_command YR "202 DUPES OK" MKAY
				GTFO
			OMG "FEAT"
				socks_utilz IZ send_command YR "211 I" MKAY
				GTFO
			OMG "SYST"
				socks_utilz IZ send_command YR "215 LOL ITZ I" MKAY
				GTFO
			OMG "CWD"
				socks_utilz IZ send_command YR "502 WERE U GOIN" MKAY
				GTFO
			OMG "REST"
				socks_utilz IZ send_command YR "350 WATCHA WAITIN FOR" MKAY
				GTFO
			OMG "ALLO"
				socks_utilz IZ send_command YR "202 CANT MATH" MKAY
				GTFO
			OMG "RNFR"
				socks_utilz IZ send_command YR "502 U NO LIEK?" MKAY
				GTFO
			OMG "RNTO"
				socks_utilz IZ send_command YR "502 U NO LIEK?" MKAY
				GTFO
			OMG "ABOR"
				socks_utilz IZ send_command YR "226 STAHPPD" MKAY
				GTFO
			OMG "DELE"
				socks_utilz IZ send_command YR "502 CANT DELET" MKAY
				GTFO
			OMG "RMD"
				socks_utilz IZ send_command YR "502 CANT DELET" MKAY
				GTFO
			OMG "MKD"
				socks_utilz IZ send_command YR "502 CANT MAEK" MKAY
				GTFO
			OMG "SITE"
				socks_utilz IZ send_command YR "200 https://www.youtube.com/watch?v=wZZ7oFKsKzY" MKAY
				GTFO
			OMG "STAT"
				socks_utilz IZ send_command YR "211 GOOD THX" MKAY
				GTFO
			OMG "HELP"
				socks_utilz IZ send_command YR "211 PLZ" MKAY
				GTFO
			OMGWTF
				socks_utilz IZ send_command YR "502 WAT" MKAY
				GTFO
		OIC
	IF U SAY SO
	
	
	BTW main loop
	
	IM IN YR connection_loop
	
		BTW listens for a connection
		command_connection R I IZ SOCKS'Z LISTN YR command_socket MKAY
		
		BTW welcome message
		socks_utilz IZ send_command YR "220 TIS WORKIN? U LISTENIN?:)" MKAY
		connection_open R WIN
		
		IM IN YR session_loop NERFIN YR mom TIL NOT connection_open

			BTW reads the next command and reply
			I HAS A incoming_command ITZ I IZ SOCKS'Z GET YR command_socket AN YR command_connection AN YR 1024 MKAY
			
			BTW checks if the incoming command is empty
			BOTH SAEM incoming_command AN ""
			O RLY?
				YA RLY,
					GTFO
				NO WAI,
					VISIBLE "CMD IZ " AN incoming_command
					I IZ handle_command YR incoming_command MKAY
			OIC
	
		IM OUTTA YR session_loop
		
		BTW closes the connection
		I IZ SOCKS'Z CLOSE YR command_connection MKAY
		
	IM OUTTA YR connection_loop
	
KTHXBYE