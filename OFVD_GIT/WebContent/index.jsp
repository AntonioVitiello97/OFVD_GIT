<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.utils.Constants"%>
<%@page import="it.unisa.ofvd.utils.DBOptions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Osservatorio sul Fenomeno della Violenza sulle Donne">
<meta name="author" content="Consiglio Regionale della Campania">
<title><%=Constants.title%></title>
<!-- Bootstrap core CSS -->
<link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="assets/jquery/jquery.min.js"></script>
</head>
<body>
  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
    <div class="container">
      <a class="navbar-brand" href="/ofvd"><%=DBOptions.getString("projectAcro")%></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active"><a class="nav-link" href="/ofvd">About</a> <span class="sr-only">(current)</span></li>
          <li class="nav-item"><a class="nav-link" href="./login.jsp">Login</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="col-xs-12" style="height: 50px;"></div>
  <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
      <a href="/ofvd">
        <img src="assets/images/logo/logo.png" class="rounded-circle" alt="OFVD" width="204" height="200">
      </a>  
        <div class="col-xs-12" style="height: 50px;"></div>
        <p class="lead">
          &quot;I diritti delle donne sono una responsabilit&agrave; di tutto il genere umano;<br /> lottare contro ogni forma di violenza nei confronti delle donne &egrave; un obbligo dell&#39;umanit&agrave;<br /> il rafforzamento del potere di azione delle donne significa il progresso di tutta l&#39;umanit&agrave;&quot;
        </p>
        <ul class="list-unstyled">
          <li><i>(Kofi Hannan)</i></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="col-xs-12" style="height: 100px;"></div>
  <%@include file="common/footer.jsp"%>
  <!-- Bootstrap core JavaScript -->
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
