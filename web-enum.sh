#!/bin/bash

getPath=$(pwd)
#insert hackTheBox machine
read -p 'HackTheBox: ' htbVar

#variable will be used to execute
#feroxbuster scans
#ffuf subdomain enum
#nikto scans
#whatweb scans

enum_web (){

#enumerating directories recursively Medium List
feroxbuster -u http://$htbVar.htb -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -x "txt,html,php,asp,aspx,jsp,bak,git,tar" -v -k -n --depth 2 2>&1 | tee $getPath/$htbVar/ferox_medium.txt &
feroxbuster -u https://$htbVar.htb -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -x "txt,html,php,asp,aspx,jsp,bak,git,tar" -v -k -n --depth 2 2>&1 | tee $getPath/$htbVar/https_ferox_medium.txt &

##enumerating directories recursively Big List
feroxbuster -u http://$htbVar.htb -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-big.txt -x "txt,html,php,asp,aspx,jsp,bak,git,tar" -v -k -n --depth 2 2>&1 | tee $getPath/$htbVar/ferox_big.txt &
feroxbuster -u https://$htbVar.htb -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-big.txt -x "txt,html,php,asp,aspx,jsp,bak,git,tar" -v -k -n --depth 2 2>&1 | tee $getPath/$htbVar/https_ferox_big.txt &


#sub domain enumeration
#ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -u http://$htbVar -H "HOST:FUZZ.$htbVar" -v -fc 302 2>&1 | tee subdomain_ffuf.txt &
#ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -u https://$htbVar -H "HOST:FUZZ.$htbVar" -v -fc 302 2>&1 | tee https_subdomain_ffuf.txt &
#ffuf -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-110000.txt -u http://horizontall.htb -H "HOST:FUZZ.horizontall.htb" -v -fc 301,302 2>&1 | tee subdomain_ffuf.txt
#nikto scan
nikto -h $htbVar.htb 2>&1 | tee $getPath/$htbVar/nikto.txt &
nikto -h https://$htbVar.htb 2>&1 | tee $getPath/$htbVar/https_nikto.txt &
#whatWeb
whatweb $htbVar.htb -v 2>&1 | tee $getPath/$htbVar/whatweb.txt &
whatweb https://$htbVar.htb -v 2>&1 | tee $getPath/$htbVar/https_whatweb.txt &
}
enum_web

exit 0 
done
