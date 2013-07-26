<%@ page import="com.rubikslab.digitalfiling.Subject" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'subject.label', default: 'Subject')}"/>
  <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.list.label" args="[entityName]"/>
</content>

<content tag="nav">
  <ul>
    <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
    <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
  </ul>
</content>

<body>

<div class="content list">
  <table>
    <thead>
    <tr>

      <g:tSortableColumn property="name" title="${message(code: 'subject.name.label', default: 'Name')}"/>

      <g:tSortableColumn property="code" title="${message(code: 'subject.code.label', default: 'Code')}"/>

    </tr>
    </thead>
    <tbody>
    <g:each in="${subjectInstanceList}" status="i" var="subjectInstance">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

        <td><g:link action="show" id="${subjectInstance.id}">${fieldValue(bean: subjectInstance, field: "name")}</g:link></td>

        <td>${fieldValue(bean: subjectInstance, field: "code")}</td>

      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <g:tPaginate total="${subjectInstanceTotal}"/>
  </div>
</div>
</body>
</html>
