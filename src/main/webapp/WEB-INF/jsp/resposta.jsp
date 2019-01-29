<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- MetisMenu CSS -->
    <link href="/vendor/metisMenu/metisMenu.min.css" rel="stylesheet"/>

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
                        <li class="divider"/>
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
                <h1 class="page-header">Visualização das Respostas</h1>
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
                        Lista de Resposta
                    </div>

                    <div class="panel-body">
                        <div class="row">

                            <div class="col-lg-12">


                                <div class="panel-body">
                                    <ul class="timeline">


                                        <li>
                                            <div class="timeline-badge primary"><i class="fa fa-tasks"></i>
                                            </div>
                                            <div class="timeline-panel">
                                                <div class="timeline-heading">
                                                    <h4 class="timeline-title">${pergunta.titulo}</h4>
                                                </div>
                                                <div class="timeline-body">
                                                    <p>${pergunta.pergunta}</p>
                                                    <hr>
                                                    <p>
                                                        <small class="text-muted"><i class="fa fa-user"></i>
                                                            ${pergunta.user.nome}
                                                        </small>
                                                    </p>
                                                    <p>
                                                        <small class="text-muted"><i class="fa fa-calendar"></i>
                                                            <fmt:formatDate value="${pergunta.createdAt}"
                                                                            pattern="dd/MM/yyyy HH:mm:ss"/>
                                                        </small>
                                                    </p>

                                                </div>
                                            </div>
                                        </li>


                                        <c:if test="${ respostas.size() > 0}">

                                        <c:forEach items="${respostas}" var="vRespostas" varStatus="counter">

                                        <c:if test="${counter.count mod 2 != 0}">
                                        <li class="timeline-inverted">
                                            </c:if>
                                            <c:if test="${counter.count mod 2 == 0}">
                                        <li>
                                            </c:if>

                                            <div class="timeline-badge warning"><i class="fa fa-comment"></i>
                                            </div>
                                            <div class="timeline-panel">
                                                <div class="timeline-body">
                                                    <p>${vRespostas.resposta}</p>
                                                    <hr>
                                                    <p>
                                                        <small class="text-muted"><i class="fa fa-user"></i>
                                                                ${vRespostas.user.nome}
                                                        </small>

                                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                                        <small class="text-muted"><i class="fa fa-calendar"></i>
                                                            <fmt:formatDate value="${vRespostas.createdAt}"
                                                                            pattern="dd/MM/yyyy HH:mm:ss"/>
                                                        </small>

                                                    </p>
                                                    <c:if test="${sessionNome == vRespostas.user.nome}">
                                                        <br>
                                                        <p>
                                                            <a type="button" class="btn btn-danger btn-circle"
                                                               href="/resposta/${pergunta.id}/${vRespostas.id}/excluir">
                                                                <i class="fa fa-trash"></i>
                                                            </a>
                                                        </p>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </li>


                                        </c:forEach>

                                        </c:if>


                                        <%--<div class="btn-group">--%>
                                        <%--<button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">--%>
                                        <%--<i class="fa fa-gear"></i> <span class="caret"></span>--%>
                                        <%--</button>--%>
                                        <%--<ul class="dropdown-menu" role="menu">--%>
                                        <%--<li><a href="#">Action</a>--%>
                                        <%--</li>--%>
                                        <%--<li><a href="#">Another action</a>--%>
                                        <%--</li>--%>
                                        <%--<li><a href="#">Something else here</a>--%>
                                        <%--</li>--%>
                                        <%--<li class="divider"></li>--%>
                                        <%--<li><a href="#">Separated link</a>--%>
                                        <%--</li>--%>
                                        <%--</ul>--%>
                                        <%--</div>--%>


                                </div>

                                <c:if test="${ sessionLogado == true}">
                                    <div class="panel-body">
                                        <div class="row">

                                            <div class="col-lg-12">

                                                <form method="post" action="/resposta/salvar">
                                                    <input hidden="hidden" name="pergunta" id="pergunta"
                                                           value="${pergunta}"/>
                                                    <input hidden="hidden" name="perguntaID" id="perguntaID"
                                                           value="${pergunta.id}"/>


                                                    <div class="form-group">
                                                        <label>Sua resposta:</label>

                                                        <textarea class="form-control" rows="3" name="resposta"
                                                                  id="resposta"
                                                                  required="required"></textarea>


                                                    </div>

                                                    <button type="submit" class="btn btn-primary">Responder</button>
                                                    <button type="reset" class="btn btn-danger">Limpar</button>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

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
