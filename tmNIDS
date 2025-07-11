#!/bin/bash

#############################
#   Define all the tests    #
#############################

# Let's start naming them

test_uid_name="Linux UID"
test_basicauth_name="HTTP Basic Authentication"
test_useragent_name="HTTP Malware User-Agent"
test_badcas_certs_name="Bad Certificates & CAs"
test_tor_name="Tor .onion DNS response and known IPs connection"
test_exe_name="EXE or DLL download over HTTP"
test_pdf_name="PDF download with Embedded File"
test_22scan_name="Simulate SSH Outbound Scan"
test_miscdns_name="Miscellaneous domains (TLD's, Sinkhole, DDNS, etc)"
test_filesharing_name="Anonymous filesharing website"
test_external_ip_lookup_name="External IP Address Lookup"
test_url_shortener_name="URL Shortener"
test_gaming_name="Policy Violation - Gaming"
test_adware_pup_name="Adware PUP"
test_malware_c2_beacon_name="Malware - Command & Control - Beacon"

# Define the actual tests

test_uid () {
  curl -s http://testmynids.org/uid/index.html > /dev/null
}

test_basicauth () {
  curl -s -H "Authorization: Basic cm9vdDpyb290" testmynids.org > /dev/null
}

test_useragent () {
  curl -s -A "BlackSun" testmynids.org > /dev/null
  curl -s -A "HttpDownload" testmynids.org > /dev/null
  curl -s -A "agent" testmynids.org > /dev/null
  curl -s -A "MSIE" testmynids.org > /dev/null
  curl -s -A "JEDI-VCL" testmynids.org > /dev/null
}

test_badcas_certs () {
  curl -s https://edellroot.badssl.com/ > /dev/null # sid: 2022134
  curl -s https://superfish.badssl.com/ > /dev/null # sid: 2020493
  echo Q | openssl s_client -showcerts -servername example.livehost.live -connect example.livehost.live:443 > /dev/null 2>&1 # sid: 2029345, 2029346
  echo Q | openssl s_client -showcerts -servername analiticsweb.site -connect analiticsweb.site:443 > /dev/null 2>&1 # sid: 2033098
  echo Q | openssl s_client -showcerts -servername adguard.clroot.io -connect adguard.clroot.io:443 > /dev/null 2>&1 # sid: 2045597
  echo Q | openssl s_client -showcerts -servername cryptpad.disroot.org -connect cryptpad.disroot.org:443 > /dev/null 2>&1 # sid: 2053979
  echo Q | openssl s_client -showcerts -servername beetrootculture.com -connect beetrootculture.com:443 > /dev/null 2>&1 # sid: 2054198, 2054200
  curl -s https://analiticsweb.site/ > /dev/null # sid: 2033098
  curl -s https://adguard.clroot.io/ > /dev/null # sid: 2045597
  curl -s https://cryptpad.disroot.org/ > /dev/null # sid: 2053979
  curl -s https://beetrootculture.com/ > /dev/null # sid: 2054198, 2054200
  curl -s testmynids.org/content_for_tests/2021941.txt > /dev/null # sid: 2021941
}

test_tor () {
  # Sample response with .onion
  dig a 3wzn5p2yiumh7akj.onion @8.8.8.8 > /dev/null

  # Retrieve Tor IP list and connect to 10
  curl -s https://raw.githubusercontent.com/SecOps-Institute/Tor-IP-Addresses/master/tor-nodes.lst -o /tmp/tor.list >/dev/null 2>&1
  # Randomize it
  sort --random-sort /tmp/tor.list > /tmp/randomtor.list
  # Connect to them
  head -n10 /tmp/randomtor.list | while read line; do nc -z -w 4 $line 443 2>&1; done
  # Clean temporary files
  rm /tmp/tor.list
  rm /tmp/randomtor.list
}

test_exe () {
  curl -s http://testmynids.org/exe/calc.exe -o /tmp/calc.exe
  rm /tmp/calc.exe
}

test_pdf () {
  curl -s testmynids.org/pdf/pdf.pdf -o /tmp/tmnidspdf.pdf 
  rm /tmp/tmnidspdf.pdf
}

test_22scan () {
  nc testmynids.org 22 -w3 > /dev/null
}

test_miscdns () {
  dig sinkhole.cert.pl @8.8.8.8 > /dev/null
  dig nic.su @8.8.8.8 > /dev/null
  dig invalid.no-ip.com @8.8.8.8 > /dev/null
}

test_filesharing () {
  echo Q | openssl s_client -connect fromsmash.com:443 > /dev/null 2>&1
}

test_external_ip_lookup () {
  curl -s api.ipify.org > /dev/null # sid: 2021997, 2047702, 2047703
  curl -s ipinfo.io > /dev/null # sid: 2020716, 2025331
  curl -s icanhazip.com > /dev/null # sid: 2036304, 2017398
  curl -s ifconfig.io > /dev/null # sid: 2844906
  curl -s checkip.amazonaws.com > /dev/null # sid: 2052027, 2814787
  curl -s ip-api.com > /dev/null # sid: 2022082
}

test_url_shortener () {
  curl -s zshorten.com > /dev/null # sid: 2038992
  curl -s cutt.ly > /dev/null # sid: 2038568
  curl -s lk.tc > /dev/null # sid: 2035742
}

test_gaming () {
  curl -s -H "User-Agent: (Nintendo Wii; U; ; 2047-12; en)" testmynids.org > /dev/null # sid: 2014718
  curl -s testmynids.org/Second_Life_Setup.exe > /dev/null #sid: 2013910
}

test_adware_pup () {
  curl -s testmynids.org/php/rpc_uci.php > /dev/null # sid: 2003060
  curl -s "testmynids.org/keywords/kyf?partner_id=123" > /dev/null # sid: 2002001
  curl -s testmynids.org/protector.exe > /dev/null # sid: 2002092
}

test_malware_c2_beacon () {
   curl -s -X POST testmynids.org -H 'Content-Type: application/txt' -d '=eyJHVUlEIjoi=IlR5cGUiOJUeXBlIj' > /dev/null # sid: 2027793
   curl -s testmynids.org/somepage.html?1234567890 -H 'User-Agent: sleep 20, Mozilla/5.0' > /dev/null # sid: 2016568
}


##############################
#     Interactive Mode       #
##############################

# No arguments assumes interactive mode
if [ -z "$*" ]; then

while true; do
  options=("$test_uid_name" "$test_basicauth_name" "$test_useragent_name" "$test_badcas_certs_name" "$test_tor_name" "$test_exe_name" "$test_pdf_name" "$test_22scan_name" "$test_miscdns_name" "$test_filesharing_name" "$test_external_ip_lookup_name" "$test_url_shortener_name" "$test_gaming_name" "$test_adware_pup_name" "$test_malware_c2_beacon_name" "CHAOS! RUN ALL!" "Quit!")

  clear

  echo " _             _   _ _____ _____   _____ "
  echo "| |           | \ | |_   _|  __ \ / ____|"
  echo "| |_ _ __ ___ |  \| | | | | |  | | (___  "
  echo "| __|  _   _ \| .   | | | | |  | |\___ \ "
  echo "| |_| | | | | | |\  |_| |_| |__| |____) |"
  echo " \__|_| |_| |_|_| \_|_____|_____/|_____/ "

  echo ""
  echo "tmNIDS - NIDS detection tester - @3CORESec"
  echo "Project: https://github.com/3CORESec/testmynids.org"
  echo ""
  echo "Choose which test you'd like to run: "
  echo ""
  select opt in "${options[@]}"; do
    case $REPLY in
      1) test_uid; break ;;
      2) test_basicauth; break ;;
      3) test_useragent; break ;;
      4) test_badcas_certs; break ;;
      5) test_tor; break ;;
      6) test_exe; break ;;
      7) test_pdf; break ;;
      8) test_22scan; break ;;
      9) test_miscdns; break ;;
      10) test_filesharing; break ;;
      11) test_external_ip_lookup; break ;;
      12) test_url_shortener; break ;;
      13) test_gaming; break ;;
      14) test_adware_pup; break ;;
      15) test_malware_c2_beacon; break ;;
      16) test_uid; test_basicauth; test_useragent; test_badcas_certs; test_tor; test_exe; test_pdf; test_22scan; test_miscdns; test_filesharing; test_external_ip_lookup; test_url_shortener; test_gaming; test_adware_pup; test_malware_c2_beacon; break ;;
      17) break 17 ;;
    *) echo "Invalid option!" >&2
  esac
  done
done
# below comes from if argument
fi


##############################
#        Script Mode         #
##############################

for arg in "$@"
do
  if [ "$arg" == "--list" ] || [ "$arg" == "-l" ] || [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
  then
    echo -e "\nThese are the available tests:\n\n \
      - $test_uid_name (run with -1)\n \
      - $test_basicauth_name (run with -2)\n \
      - $test_useragent_name (run with -3)\n \
      - $test_badcas_certs_name (run with -4)\n \
      - $test_tor_name (run with -5)\n \
      - $test_exe_name (run with -6)\n \
      - $test_pdf_name (run with -7)\n \
      - $test_22scan_name (run with -8)\n \
      - $test_miscdns_name (run with -9)\n \
      - $test_filesharing_name (run with -10)\n \
      - $test_external_ip_lookup_name (run with -11)\n \
      - $test_url_shortener_name (run with -12)\n \
      - $test_gaming_name (run with -13)\n \
      - $test_adware_pup_name (run with -14)\n \
      - $test_malware_c2_beacon_name (run with -15)\n \
      - CHAOS! Run all! (run with -99)\n"
    echo -e "Example (runs Test 7 - PDF download with Embedded File): ./tmnids -7\n"
  fi

  if [ "$arg" == "-1" ] 
  then
    test_uid  
  fi

  if [ "$arg" == "-2" ]
  then
    test_basicauth
  fi

  if [ "$arg" == "-3" ]
  then
    test_useragent
  fi

  if [ "$arg" == "-4" ] 
  then
    test_badcas_certs
  fi

  if [ "$arg" == "-5" ]
  then
    test_tor
  fi

  if [ "$arg" == "-6" ]
  then
    test_exe
  fi

  if [ "$arg" == "-7" ]
  then
    test_pdf
  fi

  if [ "$arg" == "-8" ]
  then
    test_22scan
  fi

  if [ "$arg" == "-9" ]
  then
    test_miscdns
  fi

  if [ "$arg" == "-10" ]
  then
    test_filesharing
  fi

  if [ "$arg" == "-11" ]
  then
    test_external_ip_lookup
  fi

  if [ "$arg" == "-12" ]
  then
    test_url_shortener
  fi

  if [ "$arg" == "-13" ]
  then
    test_gaming
  fi

  if [ "$arg" == "-14" ]
  then
    test_adware_pup
  fi

  if [ "$arg" == "-15" ]
  then
    test_malware_c2_beacon
  fi

  if [ "$arg" == "-99" ]
  then
    test_uid; test_basicauth; test_useragent; test_badcas_certs; test_tor; test_exe; test_pdf; test_22scan; test_miscdns; test_filesharing; test_external_ip_lookup; test_url_shortener; test_gaming; test_adware_pup; test_malware_c2_beacon;
  fi

done
