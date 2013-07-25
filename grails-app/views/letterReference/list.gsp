
<%@ page import="com.rubikslab.digitalfiling.LetterReference" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'letterReference.label', default: 'LetterReference')}"/>
  <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.list.label" args="[entityName]"/>
</content>

<content tag="nav">
  <ul>
    <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
    <li class="searchLink"><g:link action="search"><g:message code="default.link.search.label"/></g:link></li>
    <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
  </ul>
</content>

<body>

<div class="content list">
  <table>
    <thead>
    <tr>


      <g:tSortableColumn property="digitalReference" title="${message(code: 'letterReference.digitalReference.label', default: 'Digital Reference')}"/>
      
      <th><g:message code="letterReference.file.label" default="File"/></th>

      <g:tSortableColumn property="date" title="${message(code: 'letterReference.date.label', default: 'Date')}"/>
      
      <g:tSortableColumn property="addresseeName" title="${message(code: 'letterReference.addresseeName.label', default: 'Addressee Name')}"/>
      
      <g:tSortableColumn property="description" title="${message(code: 'letterReference.description.label', default: 'Description')}"/>
      
    </tr>
    </thead>
    <tbody>
    <g:each in="${letterReferenceInstanceList}" status="i" var="letterReferenceInstance">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        
        <td><g:link action="show" id="${letterReferenceInstance.id}">${fieldValue(bean: letterReferenceInstance, field: "digitalReference")}</g:link></td>
        
        <td>${fieldValue(bean: letterReferenceInstance, field: "file")}</td>
        
        <td><g:tFormatDate date="${letterReferenceInstance.date}"/></td>

        <td>${fieldValue(bean: letterReferenceInstance, field: "addresseeName")}</td>
        
        <td>${fieldValue(bean: letterReferenceInstance, field: "description")}</td>
        
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <g:tPaginate total="${letterReferenceInstanceTotal}"/>
  </div>
</div>
</body>
</html>
