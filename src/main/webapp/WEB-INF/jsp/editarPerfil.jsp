<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Perguntas e Respostas</title>

    <!-- Bootstrap Core CSS -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="/vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="/dist/css/sb-admin-2.css" rel="stylesheet"/>

    <!-- Morris Charts CSS -->
    <link href="/vendor/morrisjs/morris.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <script>
        function validarSenha(){
            NovaSenha = document.getElementById('senha').value;
            CNovaSenha = document.getElementById('senha2').value;
            if (NovaSenha != CNovaSenha) {
                alert("Senhas diferentes!\nFavor digitar as senhas iguais");
                document.getElementById('senha2').focus();
            }else{
                document.FormTrocarSenha.submit();
            }
        }
    </script>

</head>

<body>

<div id="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/home">Perguntas e Respostas - Renato Ferraz</a>
        </div>
        <!-- /.navbar-header -->

        <ul class="nav navbar-top-links navbar-right">
            <!-- /.dropdown -->

            <c:if test="${ sessionLogado  == true}">
                <li class="text-primary">Olá, ${sessionNome}</li>
            </c:if>
            <c:if test="${ sessionLogado  == false}">
                <li class="text-primary">Olá, Convidado</li>
            </c:if>

            <li class="separator"></li>
            <li class="separator"></li>
            <li class="separator"></li>

            <c:if test="${ sessionLogado  == true}">
                <li class="button ">
                    <a class="btn-primary" href="/perguntas/criar"><i class="fa fa-file-o fa-fw"></i> Nova Pergunta</a>
                </li>
                <li class="separator"></li>
            </c:if>


            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>

                <ul class="dropdown-menu dropdown-user">
                    <c:if test="${ sessionLogado == true}">
                        <li><a href="/login/editarPerfil"><i class="fa fa-key fa-fw"></i> Trocar Senha</a></li>
                        <li class="divider" />
                        <li><a href="/login/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </c:if>
                    <c:if test="${ sessionLogado  == false}">
                        <li><a href="/login/logar"><i class="fa fa-sign-in fa-fw"></i> Entrar</a></li>
                        <li><a href="/login/criarConta"><i class="fa fa-plus fa-fw"></i> Criar Conta</a></li>
                    </c:if>
                </ul>

                <!-- /.dropdown-user -->
            </li>


            <!-- /.dropdown -->
        </ul>
        <!-- /.navbar-top-links -->
    </nav>

    <div id="page-wrapper">


        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">

                        <div class="panel-heading">
                            <h3 class="panel-title">Trocar Senha</h3>
                        </div>
                        <div class="panel-body">

                            <form role="form" action="/login/trocarSenha" method="get" id="FormTrocarSenha" name="FormTrocarSenha">


                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Nome Completo" name="nome" type="text" value="${sessionNome}" disabled="disabled" required="required">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="E-mail" name="email" type="email" required="required" disabled="disabled" value="${sessionEmail}">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Senha Atual" name="senhaAtual" id='senhaAtual' type="password" value="" required="required">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Nova Senha" name="senha" id="senha" type="password" value="" required="required">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Repita a Nova Senha" name="senha2" id="senha2" type="password" value="" required="required">
                                    </div>

                                    <c:if test="${ mensagem != null}">
                                        <div class="alert alert-danger" role="alert">
                                            <span>${mensagem}</span>
                                        </div>
                                    </c:if>

                                    <button type="button" onclick="validarSenha()" class="btn btn-lg btn-primary btn-block">Trocar Senha</button>
                                </fieldset>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/dist/js/sb-admin-2.js"></script>

</body>

</html>
