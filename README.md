# Desafio2-Esig-Web
Segundo desafio da Esig - Perguntas e Respostas

Criar uma aplicação de Question and Answer com as seguintes características:
1.       Deve ter um cadastro de usuário para identificar quem faz a pergunta e quem respondeu
2.       Os usuários só poderão fazer perguntas ou respondê-las se estiverem logados.
3.       A visualização e telas ficam a sua escolha. Seja criativo.
 
Tecnologias:
1.       Usar o framework de frontend Vue.js com bootstrap
2.       Usar Spring Boot, JPA e banco de dados PostgreSQL


Procedimento:
1.  Baixar esse repositorio
2.  Instalar o servidor do Postgres
  2.1   Na instalacao criar o usuario postgres com a senha 1234
  2.2   Se o usuario já existir alterar a senha no arquivo application.properties
3.  executar o script abaixo para criar o banco
-- DROP DATABASE pr;

CREATE DATABASE pr
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

4.  Importar o projeto maven
5.  executar o projeto
6.  acessar em http://localhost:8081/
