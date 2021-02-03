#!/data/data/com.termux/files/usr/bin/bash
#FaceBook Video Downloader
#Coder Yell Phone Naing
#Date :: 1.3.2021 {9:07}
#Don't Edit Or Modify Codes,Respect The Coder
#You can Download Both HD And SD.
server=http://naleng.go.th/naleng/mainfile/fb.php?link=
check_device () {
  if [[ -d /sdcard/Android ]];then
  echo ""
  else
  echo -e "\e[1;31mSorry,I don't Support You\e[0m"
  exit
  fi
}
check_packages () {
  echo -e "\e[1;34mChecking Required Packages\e[0m"
  command -v curl >/dev/null || pkg install curl
  command -v wget >/dev/null || pkg install wget
}
check_dir () {
  if [[ -d /sdcard/Fb_Videos ]];then
  echo ""
  else
  mkdir /sdcard/Fb_Videos
  fi
}
banner () {
  clear
  check_dir
  #Tool Banner
  echo -e "\e[1;32m
.___.__ .  .   .      .__             .        .
[__ [__)\  /* _| _  _ |  \ _ .    ,._ | _  _. _| _ ._.
|   [__) \/ |(_](/,(_)|__/(_) \/\/ [ )|(_)(_](_](/,[  \e[0m"
echo -e "\e[1;31m
          >[×]< Coder :: Yell Phone Naing
          >[×]< Date  :: 3.3.2021
          >[×]< Tool  :: Facebook Public Video Downloader
          >[×]< Github:: https://www.github.com/T-Tools
          >[×]< Script:: BASH,PHP
\e[0m"
echo ""
}
byebye () {
  echo -e "\e[35mThank For Using My Tool,YellPhoneNaing\e[0m"
  exit
}
get_link () {
  #Get Video Link
  read -p $'\e[32mEnter Video Link :: \e[0m' link
  #Check User Input
  if [[ "$link" != "" ]];then
  #If Input Is Not Empty,comfirm
  comfirm_link=$link
  else
  #Retry
  echo -e "\e[1;31mPlease Enter Link\e[0m"
  get_link
  fi
}
server_fail () {
  echo "\e[1;31mCan't Connect To Server,Please Try Again Later\e[0m"
  exit
}
check_server () {
  echo -e "\e[1;34mChecking Server Status\e[0m"
  status_code=$(curl -Iks $server | head -n 1 | grep -o '[200]\+')
  if [[ $status_code == "200" ]];then
  echo -e "\e[1;32mOk,Server Status Is Online\e[0m"
  else
  server_fail
  fi
}
request_api () {
  echo -e "\e[34mRequesting Download Link To Server\e[0m"
  json=$(curl -A "Fb_Video_Downloader" -L -ks $server$comfirm_link)
  success=$(echo $json| grep -oP '(?<="success":)[^,]*')
  sd=$(echo $json | grep -oP '(?<="Download Low Quality":")[^"]*' | sed 's@\\@@g')
  hd=$(echo $json | grep -oP '(?<="Download High Quality":")[^"]*' | sed 's@\\@@g')
}
download_sd () {
  echo -e "\e[1;34mYou Will Download The Video With SD Quality"
  random=$((888888 + $RANDOM % 9999999))
  file=/sdcard/Fb_Videos/downloaded_$random.mp4
  wget -c --output-document="$file" "$sd"
  echo -e "Video Have Been Saved In (\e[1;32m$file\e[1;34m)\e[0m"
  byebye
}
download_hd () {
  echo -e "\e[1;34mYou Will Download The Video With HD Quality"
  random=$((888888 + $RANDOM % 9999999))
  file=/sdcard/Fb_Videos/downloaded_$random.mp4
  wget -c --output-document="$file" "$hd"
  echo -e "Video Have Been Saved In (\e[1;32m$file\e[1;34m)\e[0m"
  byebye
}
download () {
  case $1 in
  hd)
  download_hd;;
  sd)
  download_sd;;
  esac
}
check_json () {
  if [[ $success == true ]];then
  echo -e "\e[1;34mPlease Choose Download Quality
  \e[1;31m(1)Download SD
  \e[1;32m(2)Download HD\e[0m"
read -p $'\e[35mEnter Your Choice Number :: \e[0m' number
case $number in
1)
download sd;;
2)
download hd;;
esac
  else
  echo -e "\e[1;35mSorry,Something Was Wrong\e[0m"
  exit
  fi
}
main () {
  check_device
  check_packages
  banner
  get_link
  check_server
  request_api
  check_json
}
main
