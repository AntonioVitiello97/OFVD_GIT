<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="it.unisa.ofvd.model.AccountsModel"%>    
<%
  AccountsModel  who = (AccountsModel) request.getSession().getAttribute("account");
if (who != null) {
%>
            <div class="user-profile pull-right">
              <img class="avatar user-thumb" src="../assets/images/author/avatar.png" alt="avatar">
              <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
              <span>
              <%=who.getNome() + " " + who.getCognome()%>
              <br>
              <sub><%=who.getPrintType()%></sub>
              </span>
              <i class="fa fa-angle-down"></i>
              </h4>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="profile.jsp"><i class="fas fa-user-cog"></i>&nbsp;&nbsp;Profilo</a> <a class="dropdown-item" href="../Logout"><i class="fas fa-power-off"></i>&nbsp;&nbsp;Logout</a>
              </div>
            </div>
<% } %> 