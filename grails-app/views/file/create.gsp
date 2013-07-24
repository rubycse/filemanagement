<%@ page import="com.rubikslab.digitalfiling.File" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<content tag="header">
    <g:message code="default.create.label" args="[entityName]"/>
</content>

<content tag="nav">
    <ul>
        <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
        <li class="searchLink"><g:link action="search"><g:message code="default.link.search.label"/></g:link></li>
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
    <g:form action="save" method="post">
        <div class="dialog">

            <div class="prop ${hasErrors(bean: fileInstance, field: 'ministry', 'error')}">
                <label for="ministry">
                    <g:message code="file.ministry.label" default="Ministry"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="ministry" class="field" from="${fileInstance.constraints.ministry.inList}"
                              value="${fileInstance?.ministry}" valueMessagePrefix="file.ministry"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'department', 'error')}">
                <label for="department">
                    <g:message code="file.department.label" default="Department"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="department" class="field" from="${fileInstance.constraints.department.inList}"
                              value="${fileInstance?.department}" valueMessagePrefix="file.department"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'district', 'error')}">
                <label for="district">
                    <g:message code="file.district.label" default="District"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="district" class="field" from="${fileInstance.constraints.district.inList}"
                              value="${fileInstance?.district}" valueMessagePrefix="file.district"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'thana', 'error')}">
                <label for="thana">
                    <g:message code="file.thana.label" default="Thana"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="thana" class="field" from="${fileInstance.constraints.thana.inList}"
                              value="${fileInstance?.thana}" valueMessagePrefix="file.thana"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'office', 'error')}">
                <label for="office">
                    <g:message code="file.office.label" default="Office"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="office" class="field" from="${fileInstance.constraints.office.inList}"
                              value="${fileInstance?.office}" valueMessagePrefix="file.office"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'subject', 'error')}">
                <label for="subject">
                    <g:message code="file.subject.label" default="Subject"/>

                </label>

                <div class="value">
                    <g:select name="subject.id" class="field" from="${com.rubikslab.digitalfiling.Subject.list()}"
                              optionKey="id" value="${fileInstance?.subject?.id}"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'name', 'error')}">
                <label for="name">
                    <g:message code="file.name.label" default="Name"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:countableTextArea name="name" id="name" class="field" cols="25" rows="4" isCountable="1"
                                         length="300" value="${fileInstance?.name}"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'code', 'error')}">
                <label for="code">
                    <g:message code="file.code.label" default="Code"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:textField name="code" class="field" maxlength="3" value="${fileInstance?.code}"/>

                </div>
            </div>

            <div class="prop ${hasErrors(bean: fileInstance, field: 'year', 'error')}">
                <label for="year">
                    <g:message code="file.year.label" default="Year"/>

                    <span class="asterisk">*</span>

                </label>

                <div class="value">
                    <g:select name="year" class="field" from="${fileInstance.constraints.year.inList}"
                              value="${fileInstance?.year}" valueMessagePrefix="file.year"/>

                </div>
            </div>

        </div>

        <div class="buttons">
            <div class="floatRight">
                <g:submitButton name="create"
                                value="${message(code: 'default.button.create.label', default: 'Create')}"/>
            </div>

            <div class="clearBoth"></div>
        </div>
    </g:form>
</div>
</body>
</html>
