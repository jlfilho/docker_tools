# docker_tools
autor: Joao da Mata

Ferramenta para criar e remover container docker com mapeamento de volumes da máquina física


# Instalação:
./install.sh 


Uso:
 docker_tools [opção]

Opções:
  -u	Usuário: -u teste
  -v	Versão do pyton 2|3: -v 3
  -p	Porta para ssh no container: -p 2002
  -r	Remove conteiner e volumes mapeados
  -h	Ajuda

   Ex.:
      docker_tools -u teste -p 2002 -v 3  	=>Para criar um novo container com python3 para o usuário teste porta 2002
      docker_tools -r teste.latest-gpu-py3	=>Para remover o container
