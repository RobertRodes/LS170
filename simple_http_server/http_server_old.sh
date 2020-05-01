function server () {
  while true
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      if [[ -f ./www/$path ]]
      then
        echo -e "HTTP/1.1 200 OK\n"; cat ./www/$path; echo -e "\n"
      else
        echo -e "HTTP/1.1 404 Not Found\n"
      fi
    else
      echo -e "HTTP/1.1 400 Bad Request\n"
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}