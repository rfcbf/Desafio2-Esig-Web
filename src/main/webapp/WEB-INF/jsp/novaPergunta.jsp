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
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Perguntas</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <c:if test="${ mensagem != null}">
            <div class="alert alert-success" role="alert">
                <span>${mensagem}</span>
            </div>
        </c:if>

        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <c:if test="${perguntaAtualizar.id == 0}">
                            Crie sua pergunta
                        </c:if>

                        <c:if test="${perguntaAtualizar.id != 0}">
                            Atualizar sua pergunta
                        </c:if>


                    </div>

                    <div class="panel-body">
                        <div class="row">

                            <div class="col-lg-12">

                                <c:if test="${empty perguntaAtualizar}">
                                    <form method="post" action="/perguntas/salvar">
                                </c:if>

                                <c:if test="${!empty perguntaAtualizar}">
                                    <form  method="post" action="/perguntas/salvarAtualizacao">
                                        <input hidden="hidden" name="id" id="id" value="${perguntaAtualizar.id}"/>

                                    </c:if>

                                <%--<form role="form" method="post" action="/perguntas/salvar">--%>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>Seu Nome:</label>
                                            <p class="form-control-static">${sessionNome}</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>Seu E-mail:</label>
                                            <p class="form-control-static">${sessionEmail}</p>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Título:</label>

                                        <c:if test="${perguntaAtualizar.id == 0}">
                                            <input class="form-control" autofocus name="titulo" id="titulo" required="required"/>
                                        </c:if>

                                        <c:if test="${perguntaAtualizar.id != 0}">
                                            <input class="form-control" autofocus name="titulo" id="titulo" required="required" value="${perguntaAtualizar.titulo}"/>
                                        </c:if>

                                        <br>
                                        <label>Descrição:</label>

                                        <c:if test="${perguntaAtualizar.id == 0}">
                                            <textarea class="form-control" rows="6" name="pergunta" id="pergunta" required="required"></textarea>
                                        </c:if>

                                        <c:if test="${perguntaAtualizar.id != 0}">
                                            <textarea class="form-control" rows="6" name="pergunta" id="pergunta" required="required">${perguntaAtualizar.pergunta}</textarea>
                                        </c:if>

                                    </div>

                                    <button type="submit" class="btn btn-primary">Salvar</button>
                                    <button type="reset" class="btn btn-danger">Limpar Campos</button>

                                </form>

                            </div>

                        </div>
                        <!-- /.row (nested) -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>

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
