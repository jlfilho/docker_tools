#!/bin/bash

print_usage() {
  echo "Uso:"
  echo -e " $0 [opção]\n"
  echo -e " Argumentos obrigatórios:
  -u\tUsuário
  -v\tVersão do pyton 2|3
  -p\tPorta para ssh no conteiner"
}

make_dir() {
   if [ ! -d /home/$user ] && [ ! -d /data/$user  ]
   then
      #mkdir /home/$user
      #mkdir /data/$user
      echo "Criado"
   else
      echo "Usuário já existe."
      exit 0
   fi
}
remove() {
    if [ "$(docker ps -qa -f name=$container)" ]; then
       docker 
    fi
     exit 0
}


while getopts hu:p:v:r: OPCAO; do
   case "${OPCAO}" in
      u) user="${OPTARG}" ;;
      v) version="${OPTARG}" ;;
      p) port="${OPTARG}" ;;
      r) container="${OPTARG}" 
	remove
	;;
      *) print_usage
         exit 1 ;;
   esac
done
  

if [ ${version} ] && [ ${user} ] && [ ${port} ]
then
  if [ ${version} = 3 ]
  then
      echo "docker run -v /home/$user:/ssd -v /data/$user:/hd -d --runtime=nvidia -it -p $port:22 --restart unless-stopped --name $user.latest-gpu-py3 tensorflow/tensorflow:latest-gpu-py3"
      echo "docker exec -it $user.latest-gpu-py3 useradd -g root $user /data/$user:/hd -s /sbin/bash"
      echo "docker exec -it $user.latest-gpu-py3 usermod -aG sudo $user"
      echo "echo "$user:$user" | chpasswd"
  elif [ ${version} = 2 ]
  then
      echo "docker run -v /home/$user:/ssd -v /data/$user:/hd -d --runtime=nvidia -it -p $port:22 --restart unless-stopped --name $user.latest-gpu tensorflow/tensorflow:latest-gpu"
      echo "docker exec -it $user.latest-gpu useradd -g root $user -d /data/$user:/hd  -s /sbin/bash"
      echo "docker exec -it $user.latest-gpu usermod -aG sudo $user"
      echo "echo "$user:$user" | chpasswd"
  else
      echo "Parâmetro -v incorreto."
      print_usage
  fi
else
   print_usage
fi


  
exit 0
 
