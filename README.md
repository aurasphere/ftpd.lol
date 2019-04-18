# ftpd.lol
Simple Unix FTP server written in LOLCODE. This server is a minimum implementation of the [RFC-959](https://tools.ietf.org/html/rfc959).

## Running
To run it you first have to compile and install the [LOLCODE lci compiler](https://github.com/justinmeza/lci/tree/future). The project requires the future branch since it uses 1.4 features. Instructions on how to install the compiler are provided in its repository.

Once installed, the server can be run with the command:

    sudo lci ftpd.lol

A shell script is provided to generate the file whitelist (read the limitations section for more info). 

## Features
In order to be considered a valid minimum implementation, this program supports the following features:

### Transport Specifications
- TYPE = ASCII Non-print
- MODE = Stream
- STRUCTURE = File, Record

### Supported Commands
- USER
- QUIT
- PORT
- TYPE
- MODE
- STRU
- RETR
- STOR
- NOOP

### Additional Features
Apart from the minimum implementation features, the following commands are also supported (supported meaning that the returned reply is not a 4xx or 5xx):
 - APPE
 - PWD
 - REIN
 - SYST
 - REST
 - ABOR
 - STAT
 - HELP
 - SITE
 - ALLO
 - FEAT
 - SMNT
 - ACCT
 - NLST

## Limitations
 - File upload maximum size = 1449 bytes.
 - File transfer mode = active only. Passive is not supported due to the single-thread nature of the LOLCODE language.
 - Files are parsed using LOLCODE. This means that some specific character sequences are automatically converted while transferring files. These includes for example the sequence ":)" which is translated to a whitespace.
 - The server supports only one user at the time, due to the single-thread nature of the LOLCODE language.
 - Since LOLCODE doesn't have any directory listing function, this server relies on a file called whitelist.lul which contains a list of files visible to the clients (populated using a given script). This means that any uploaded file won't be visible unless added to this file.
 - The server runs only on UNIX systems since LOLCODE 1.4 sockets' work only there.
 - If you are using an FTP client you can't save a file after editing. Instead you have to download it, edit it and then reupload it. This is not really a limitation but more of a feature not included into the RFC specification. It has been put here since it's probably a widely used feature.
 - Remember that this server does not support binary files transfer.
 
 ## Tests
 This code has been tested using [WinSCP](https://winscp.net/eng/download.php) FTP client. Other clients may not work (and probably won't).
 
 ## Contributing
 Open an issue for questions, comments and so forth but keep in mind that I won't probably add any new features to this project.
 
 # KTHXBYE

<sub>Copyright (c) 2019 Donato Rimenti</sub>
