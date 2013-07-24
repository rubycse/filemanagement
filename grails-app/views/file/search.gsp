<%@ page import="com.rubikslab.digitalfiling.File" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}"/>
    <title><g:message code="default.search.label" args="[entityName]"/></title>
</head>

<content tag="header">
    <g:message code="default.search.label" args="[entityName]"/>
</content>

<content tag="nav">
    <ul>
        <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
        <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</content>

<body>
<g:hasErrors bean="${fileInstance}">
    <div class="errors">
        <g:renderErrors bean="${fileInstance}" as="list"/>
    </div>
</g:hasErrors>

<div class="content">
    <g:form action="display" method="post">
        <div class="dialog">
            <div class="prop ${hasErrors(bean: fileInstance, field: 'digitalReference', 'error')}">
                <label for="digitalReference">
                    <g:message code="file.digitalReference.label" default="Digital Reference"/>
                </label>

                <div class="value">
                    <g:textField name="digitalReference" value="${fileInstance?.digitalReference}"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'name', 'error')}">
                <label for="name">
                    <g:message code="file.name.label" default="Name"/>
                </label>

                <div class="value">
                    <g:textField name="name" id="name" class="field" cols="25" rows="4" isCountable="1"
                                         length="300" value="${fileInstance?.name}"/>

                </div>
            </div>


            <div class="prop ${hasErrors(bean: fileInstance, field: 'year', 'error')}">
                <label for="year">
                    <g:message code="file.year.label" default="Year"/>
                </label>

                <div class="value">
                    <g:select name="year" id="year" class="field" from="${fileInstance.constraints.year.inList}"
                              noSelection="['' : '-- Select --']"
                              value="${fileInstance?.year}" valueMessagePrefix="file.year"/>
                </div>
            </div>

        </div>

        <div class="buttons">
            <div class="floatRight">
                <g:submitButton name="search"
                                value="${message(code: 'default.button.search.label', default: 'Search')}"/>
            </div>

            <div class="clearBoth"></div>
        </div>
    </g:form>
</div>
</body>
</html>
