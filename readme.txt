# usuarios.sh
# script simples para a criação ou deleção de uma lista de usuários contida num arquivo em texto comum.
# autor: Marco Antonio Damaceno
# email: marco.damaceno@gmail.com
# data: 04/03/2020
# Versão 0.1

AVISO: É necessário permissão de root para executar o script, portanto execute-o com sudo ou em uma conta administrativa.

O arquivo txt contendo a lista de usuários a serem adicionados ao sistema ou deletados, deve seguir o seguinte padrão:

username:/home/home_usern:full_name

onde:

username é o nome de usuário utilizado para logar no sistema.
/home/home_user é o diretório home que será criado para o usuário ou deletado do mesmo.
full_name é o nome completo do usuário.


Uso: usuarios.sh <-cdv> [-fhv]


-f ARQUIVO.TXT - Arquivo texto com uma lista de usuários no formato username:/home/userhome:full_name

-c Cria usuários no sistema de acordo com o arquivo texto fornecido com -f.

-d Deleta usuários no sistema de acordo com o arquivo texto fornecido com -f.

-h Mostra este help.

-v Mostra a versão deste script.

Dúvidas, críticas e sugestões, favor entrar em contato pelo e-mail: marco.damaceno@gmail.com
