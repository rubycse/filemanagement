<%@ page import="com.rubikslab.digitalfiling.File" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <r:require module="export"/>
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

            <th><g:message code="default.open.label" default="Open"/></th>

            <th><g:message code="file.subject.label" default="Subject"/></th>

            <g:tSortableColumn property="name" title="${message(code: 'file.name.label', default: 'Name')}"/>

            <g:tSortableColumn property="code" title="${message(code: 'file.code.label', default: 'Code')}"/>

            <g:tSortableColumn property="year" title="${message(code: 'file.year.label', default: 'Year')}"/>

            <g:tSortableColumn property="digitalReference"
                               title="${message(code: 'file.digitalReference.label', default: 'Digital Reference')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${fileInstanceList}" status="i" var="fileInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                <td><g:link action="show" id="${fileInstance.id}">Open</g:link></td>

                <td>${fieldValue(bean: fileInstance, field: "subject")}</td>

                <td>${fieldValue(bean: fileInstance, field: "name")}</td>

                <td>${fieldValue(bean: fileInstance, field: "code")}</td>

                <td>${fieldValue(bean: fileInstance, field: "year")}</td>

                <td>${fieldValue(bean: fileInstance, field: "digitalReference")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="paginateButtons">
        <g:tPaginate total="${fileInstanceTotal}"/>
    </div>
    <export:formats action="exportToExcel" formats="['excel']"/>
</div>
</body>
</html>
