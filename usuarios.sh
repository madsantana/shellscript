#!/bin/bash

# usuarios.sh
# script simples para a criação ou deleção de uma lista de usuários contida num arquivo em texto comum.
# autor: Marco Antonio Damaceno
# data: 04/03/2020
# Versão 0.1

#Antes de iniciar, verifica se tem a permissão de root.
if [ "$(id -u)" != "0" ]; then 

	echo "Voce deve executar este script como root! "
	sleep 3
	clear
	exit 

fi

#Função para criar os usuários de acordo com o que está no arquivo de texto indicado.
#Lembrando que o arquivo de texto deve estar no formato Username:/home/userhome:full_name.
function CreateUsers() {

	ARQUIVO_TEXTO=$1
	clear
	sleep 2
	echo "O arquivo a ser carregado é o $ARQUIVO_TEXTO"
	echo -e "\n=========================================="
	sleep 2
	echo "Arquivo carregado com sucesso!"
	echo
	echo "Pressione uma tecla para continuar..."
	read CONTINUA
	
	while IFS=: read USERNAME USER_HOME USER_FULLNAME; 
	do
		useradd -m -c "$USER_FULLNAME" -d "$USER_HOME" "$USERNAME"
		echo -e "\nUsuário $USERNAME adicionado com sucesso!"
		
	done < "$ARQUIVO_TEXTO"

}

#Função para deletar unma lista de usuários contida no arquivo texto indicado, também deleta a pasta /home do usuário e seus respectivos arquivos.
function DeleteUser() {

	ARQUIVO_TEXTO=$1
	clear
	sleep 2
	echo "O arquivo a ser carregado é o $ARQUIVO_TEXTO"
	echo -e "\n=========================================="
	sleep 2
	echo "Arquivo carregado com sucesso!"
	echo
	echo "ALERTA! Os usuários no arquivo serão deletados do sistema!"
	echo
	echo "Pressione uma tecla para continuar..."
	read CONTINUA
	
	while IFS=: read USERNAME USER_HOME USER_FULLNAME; 
	do
		userdel "$USERNAME"
		rm -rf /home/$USERNAME
		
		echo -e "\nUsuário $USERNAME e todos os seus arquivos deletados com sucesso!"
		
	done < "$ARQUIVO_TEXTO"

}

#Mostra o uso correto do script
function PrintUsage() {

	echo "Uso: `basename $0` <-cdv> [-fhv]"
	echo
	echo -e "\n-f ARQUIVO.TXT - Arquivo texto com uma lista de usuários no formato username:/home/userhome:full_name "
	echo -e "\n-c Cria usuários no sistema de acordo com o arquivo texto fornecido com -f."
	echo -e "\n-d Deleta usuários no sistema de acordo com o arquivo texto fornecido com -f."
	echo -e "\n-h Mostra este help."
	echo -e "\n-v Mostra a versão deste script."
	sleep 2
	exit 1

}

#Mostra a versão deste script
function ScriptVersion() {

		echo "`basename $0` - Versão: 0.1"
		echo "Autor: Marco Antonio Damaceno"
		exit 1

}

#Funão simples para testar o carregamento do arquivo.
function LoadFile() {

			ARQUIVO=$1			

}

#Aqui é que a coisa realmente acontece.
while getopts "vhf:cdv" OPTION
do
	case $OPTION in
		
		h) DO_HELP=1 ;;
		f) ARQUIVO_TXT=$OPTARG ;;
		c) DO_CREATE_USERS=1 ;;
		d) DO_DELETE_USERS=1 ;;
		v) DO_VERSION=1 ;;
	esac
done

shift $((OPTIND-1))

if [ -z "$ARQUIVO_TXT" ] && [ -z "$DO_CREATE_USERS" ] && [ -z "$DO_HELP" ] && [ -z "$DO_VERSION" ]; then

	clear
	sleep 1
	echo "Uso incorreto, favor usar como abaixo..."
	echo
	PrintUsage
	
 fi

if [ "$ARQUIVO_TXT" ]; then

	if [ "$DO_CREATE_USERS" == 1 ]; then
		
		CreateUsers $ARQUIVO_TXT
	fi
	
	if [ "$DO_HELP" == 1 ]; then
	
		PrintUsage
	
	fi
	
	if [ "$DO_DELETE_USERS" == 1 ]; then
	
		DeleteUser $ARQUIVO_TXT
		
	fi
	
	if [ "$DO_VERSION" == 1 ]; then
		
		ScriptVersion
	
	fi
	
fi
