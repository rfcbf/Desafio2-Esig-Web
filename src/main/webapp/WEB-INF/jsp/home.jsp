<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >

<html>
<head>

    <meta charset="UTF-8">
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

    <!-- DataTables CSS -->
    <link href="/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">


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
                    <h1 class="page-header">Painel de Controle</h1>
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
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${totalPerguntas}</div>
                                    <div>Total de Perguntas</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-comments fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${totalResposta}</div>
                                    <div>Total de Respostas</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${totalUsuario}</div>
                                    <div>Total de Usuários</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-tasks fa-fw"></i> Perguntas
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <table width="100%" class="table table-striped table-bordered table-hover" id="tabelaPerguntas">
                                <thead>
                                <tr>
                                    <th width="60%">Pergunta</th>
                                    <th width="12%">Criador</th>
                                    <th width="10%">Data Criação</th>
                                    <th width="8%">Respostas</th>
                                    <th width="10%">Ação</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach items="${perguntas}" var="vPerguntas">
                                    <tr>
                                        <td><c:out value="${vPerguntas.titulo}"/></td>
                                        <td><c:out value="${vPerguntas.user.nome}"/></td>
                                        <td align="center"><fmt:formatDate value="${vPerguntas.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                        <td align="center"><c:out value="${vPerguntas.totalPergunta.toString()}"/></td>
                                        <td align="center">

                                            <%--visualizar--%>
                                            <a type="button" class="btn btn-primary btn-circle" href="/resposta/${vPerguntas.id}/lista">
                                                <i class="fa fa-list"></i>
                                            </a>

                                            <c:if test="${ sessionLogado == true}">

                                                <c:if test="${ sessionNome == vPerguntas.user.nome}">
                                                    <%--editar--%>
                                                    <a type="button" class="btn btn-warning btn-circle" href="/perguntas/${vPerguntas.id}/atualizar">
                                                        <i class="fa fa-edit"></i>
                                                    </a>

                                                    <%--&lt;%&ndash;responder&ndash;%&gt;--%>
                                                    <%--<button type="button" class="btn btn-success btn-circle" data-toggle="tooltip" data-placement="bottom" title="Responder">--%>
                                                    <%--<i class="fa fa-reply"></i>--%>
                                                    <%--</button>--%>

                                                    <%--excluir--%>
                                                    <a class="btn btn-danger btn-circle" href="/perguntas/${vPerguntas.id}/excluir">
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </c:if>

                                            </c:if>

                                        </td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>

                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
            </div>
            <!-- /.row -->

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

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <!-- DataTables JavaScript -->
    <script src="/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <script>
        $(document).ready(function() {
            $('#tabelaPerguntas').DataTable({
                responsive: true,

                "language": {
                    "sEmptyTable": "Nenhum registro encontrado",
                    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
                    "sInfoFiltered": "(Filtrados de _MAX_ registros)",
                    "sInfoPostFix": "",
                    "sInfoThousands": ".",
                    "sLengthMenu": "_MENU_ resultados por página",
                    "sLoadingRecords": "Carregando...",
                    "sProcessing": "Processando...",
                    "sZeroRecords": "Nenhum registro encontrado",
                    "sSearch": "Pesquisar",
                    "oPaginate": {
                        "sNext": "Próximo",
                        "sPrevious": "Anterior",
                        "sFirst": "Primeiro",
                        "sLast": "Último"
                    },
                    "oAria": {
                        "sSortAscending": ": Ordenar colunas de forma ascendente",
                        "sSortDescending": ": Ordenar colunas de forma descendente"
                    }
                }

            });
        });

    </script>




</body>

</html>
