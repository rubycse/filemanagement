

<%@ page import="com.rubikslab.digitalfiling.LetterReference" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'letterReference.label', default: 'LetterReference')}"/>
    <title><g:message code="default.search.label" args="[entityName]"/></title>
</head>

<content tag="header">
    <g:message code="default.search.label" args="[entityName]"/>
</content>

<content tag="nav">
    <ul>
        <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
        <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
        <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</content>

<body>
<g:hasErrors bean="${letterReferenceCmd}">
    <div class="errors">
        <g:renderErrors bean="${letterReferenceCmd}" as="list"/>
    </div>
</g:hasErrors>

<div class="content">
    <g:form action="display" method="post">
        <div class="dialog">

            <div class="prop ${hasErrors(bean: letterReferenceCmd, field: 'digitalReference', 'error')}">
                <label for="digitalReference">
                    <g:message code="letterReference.digitalReference.label" default="Digital Reference"/>
                </label>
                <div class="value">
                    <g:textField name="digitalReference" class="field" value="${letterReferenceCmd?.digitalReference}" />
                </div>
            </div>

            <div class="prop ${hasErrors(bean: letterReferenceCmd, field: 'fromDate', 'error')}">
                <label for="fromDate">
                    <g:message code="letterReference.fromDate.label" default="Date From"/>
                </label>
                <div class="value">
                    <g:datePicker name="fromDate" precision="day" value="${''}" noSelection="['': '']" />
                </div>
            </div>

            <div class="prop ${hasErrors(bean: letterReferenceCmd, field: 'toDate', 'error')}">
                <label for="fromDate">
                    <g:message code="letterReference.toDate.label" default="Date To"/>
                </label>
                <div class="value">
                    <g:datePicker name="toDate" precision="day" value="${letterReferenceCmd?.toDate}" noSelection="['': '']" />
                </div>
            </div>

            <div class="prop ${hasErrors(bean: letterReferenceCmd, field: 'addresseeName', 'error')}">
                <label for="addresseeName">
                    <g:message code="letterReference.addresseeName.label" default="Addressee Name"/>
                </label>
                <div class="value">
                    <g:textField name="addresseeName" class="field" value="${letterReferenceCmd?.addresseeName}" />
                </div>
            </div>

            <div class="prop ${hasErrors(bean: letterReferenceCmd, field: 'description', 'error')}">
                <label for="description">
                    <g:message code="letterReference.description.label" default="Description"/>
                </label>
                <div class="value">
                    <g:textField name="description" class="field" value="${letterReferenceCmd?.description}" />
                </div>
            </div>

        </div>

        <div class="buttons">
            <div class="floatRight">
                <g:submitButton name="search" value="${message(code: 'default.button.search.label', default: 'Search')}"/>
            </div>
            <div class="clearBoth"></div>
        </div>
    </g:form>
</div>
</body>
</html>
