#!/bin/bash

	#=======================================================================
	#
	#          FILE:  setup.sh
	#
	#         USAGE:  setup projet
	#
	#   DESCRIPTION:  Install the projet in debian
	# 	Copyright (C) 2016 Teeknofil
	#       OPTIONS:  ---
	#  REQUIREMENTS:  ---
	#          BUGS:  ---
	#         NOTES:  Contact teeknofil.dev@gmail.com for bug.
	#        AUTHOR:  Teeknofil
	#       COMPANY:  Anonymous freelance.
	#       VERSION:  1.1
	#       CREATED:  18/07/2016 05:42:31 CEST
	#      REVISION:  ---
	#=======================================================================


	## Debug
	#set -x
	
	BOLD="\033[01;01m"     # Highlight
	RED="\033[01;31m"      # Issues/Errors
	GREEN="\033[01;32m"    # Success
	YELLOW="\033[01;33m"   # Warnings/Information
	RESET="\033[00m"       # Normal

	# Print Banner

	echo "                                                            r;;
		                                                        ,,
		                                                       ,
	                           				  ., .,.
	                   					 ,;,...
	   ;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,;                  ....:;:,,
	2rriSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSirrs              .,:,;;,,::
	XsS552222222222222222222222222222Siirs            ,::;;,;:
	X5XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX222ii		 ..;;;,:,
	X2XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXSi		,:;;::S
	X5XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXSi        $  .,;:::
	X5XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXSi        B  ::r;.
	Xi522222222222XXXXXXXXXXX22222222222si         i  .,
	2S5222222222252XXXXXXXXX2XXXX2222225Ss            . 9                                 ;;r;r;;@
	   :XXXXXX2@S55XXXXXXX2X2;;3XXXXX;               ..AA                               rrrisiS5252
		     S5XXXXXXXXX2X                      X  , @iB                           srssi522X22X
		     i52XXXXXXXX25                     :   : S@r9                         rssS2XXXXXX2X
		     i52XXXXXXXX5S                  A,   ,,,  h#rrXM                     rsS2XXXXXXXX2X
		     i52XXXXXXX2Si                ;      3 ,:  G@srrsh                  rs5XXXXXXXXXX2X
		     i52XXXXXXX2Si             M.       9; .r   H@iisrr2M              ri2XXXXXXXXXXX2X
		     i52XXXXXXX2Si           B       .s9;  , G   @HS5SirrSM            iSXXXXXXXXXXXX2X
		     i52XXXXXXX2Si          ,      ;GG;    : ,A  ,@2225SirrX          sS2XXXXXXXXX255S2
		     i52XXXXXXX2Si        H      iH2.     .;, ;G  @B52222Siri         iSXXXXXXXXX22225X
		     i52XXXXXXX2Si       M     r#i       ;,:S  Si S@S222225Sri        iSXXXXXXXX222i
		     i52XXXXXXX2Si            AA       .s; ,h;  $  @222XX222Srh       iSXXXXXXX22#
		     i52XXXXXXX2Si      A    B2      :rr,  , $, ;X @hS2XXX222is       iSXXXXXXX52
		     i52XXXXXXX2Si      r   5G     rhr     ,  A  H @HS2XXXX225rB      iSXXXXXXX5S
		     i52XXXXXXX2Si      ;   @     MX       i  :h S.@Mi2XXXXX22sA      iSXXXXXXXSi
		     i52XXXXXXX2Si      r  ,#    @r      ,rri  $ ;r@Bi2XXXXXX2sH      iSXXXXXXXSi
		     i52XXXXXXX2Si          @   iX      rA  3, 5;;i@Ai2XXXXXX2i       iSXXXXXXXSi
		     i52XXXXXXX2Si          2h  A.     ,#  .;A i2i2@9S2XXXXXX52       iSXXXXXXXSi
		     i52XXXXXXX2Si           @:  s     X:  ,.@ ih5h@252XXXXX2i        iSXXXXXXXSi
		     i52XXXXXXX2Si        $   @ .@     A   , @ 2Ar@@i22XXXX2S#        iSXXXXXXXSi
		     i52XXXXXXX2Si             $  @    Mr  ..@ HS:@ i2XX22S2          iSXXXXXXXSi
		     i52XXXXXXX2Si           i  3:M@   .@   s  $;p@i5222S5A           iSXXXXXXXSi
		     i52XXXXXXX2Si             r ::i@;  s@  @;X#@@5iSiSXB             iSXXXXXXXSi
		     iS2X22222X2ii               GXs;2S, s5sBG@@@srS3H                ii2222222iS
		     X2222222222XX                   hM##AB@#@@#AB#                   2222222222X"


	echo " "
	echo "Press a key for continue"
	read

	# Global Variables
	#runuser= "$(whoami)";

	SetupTor()
	{

		if [ ! -f /usr/sbin/tor  ]; then			
			apt-get install tor
			systemctl start tor
			systemctl enable tor
		fi

	}

	SetupFiles()
	{
		echo -e "Copy the files \n"
		chmod +x deb-src/usr/bin/*
		chmod +x deb-src/etc/default/*		
		cp  -R deb-src/etc/* /etc/
		cp -R deb-src/usr/bin/* /usr/bin/
		updatedb
	}

	CheckRoot() 
	{
		if [ $(id -u) -ne 0 ]; then
			echo "[!] This script must be run as root!" >&2
			exit 1
		fi
	}

	SetupProxy()
	{	
		if ! grep -q "#Anonymous Hacker Proxy" /root/.bashrc;
		then
			echo "#Anonymous Hacker Proxy" >> /root/.bashrc
			echo '#export ftp_proxy="127.0.0.1:9050"' >> /root/.bashrc
			echo '#export http_proxy="127.0.0.1:9050"' >> /root/.bashrc
			echo '#export https_proxy="127.0.0.1:9050"' >> /root/.bashrc
			echo '#export socks_proxy="127.0.0.1:9050"'>> /root/.bashrc
		fi
	}

	InstallDependance()
	{
		apt-get update --fix-missing

		if [ ! -f /usr/sbin/virt-what ]; then
			apt-get install -y virt-what
		fi

		if [ ! -f /usr/bin/bleachbit ]; then

			apt-get install -y bleachbit
		fi	
		
	}


################################# 
#                               #
#     Main                      #
#                               # 
#################################
	
CheckRoot
SetupTor
SetupFiles
InstallDependance


