<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.batirplan.fnnr.salary.vo.SalaryVO" %>
<%@ page import="com.google.gson.Gson" %>

<%
    Gson gson = new Gson();
    String json = gson.toJson(paidList);
    response.getWriter().print(json);
%>
