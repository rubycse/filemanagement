<%@ page import="com.rubikslab.digitalfiling.File" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<content tag="header">
    <g:message code="default.show.label" args="[entityName]"/>
</content>

<content tag="nav">
    <ul>
        <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
        <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
        <li class="searchLink"><g:link action="search"><g:message code="default.link.search.label"/></g:link></li>
        <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</content>

<body>

<div class="content">

    <g:form>

        <div class="dialog">

            <div class="prop">
                <label for="id">
                    <g:message code="file.id.label" default="Id"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "id")}

                </div>

            </div>

            <div class="prop">
                <label for="ministry">
                    <g:message code="file.ministry.label" default="Ministry"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "ministry")}

                </div>

            </div>

            <div class="prop">
                <label for="department">
                    <g:message code="file.department.label" default="Department"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "department")}

                </div>

            </div>

            <div class="prop">
                <label for="district">
                    <g:message code="file.district.label" default="District"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "district")}

                </div>

            </div>

            <div class="prop">
                <label for="thana">
                    <g:message code="file.thana.label" default="Thana"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "thana")}

                </div>

            </div>

            <div class="prop">
                <label for="office">
                    <g:message code="file.office.label" default="Office"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "office")}

                </div>

            </div>

            <div class="prop">
                <label for="subject">
                    <g:message code="file.subject.label" default="Subject"/>
                </label>

                <div class="value">

                    <g:link controller="subject" action="show"
                            id="${fileInstance?.subject?.id}">${fileInstance?.subject?.encodeAsHTML()}</g:link>

                </div>

            </div>

            <div class="prop">
                <label for="name">
                    <g:message code="file.name.label" default="Name"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "name")}

                </div>

            </div>

            <div class="prop">
                <label for="code">
                    <g:message code="file.code.label" default="Code"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "code")}

                </div>

            </div>

            <div class="prop">
                <label for="year">
                    <g:message code="file.year.label" default="Year"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "year")}

                </div>

            </div>

            <div class="prop">
                <label for="digitalReference">
                    <g:message code="file.digitalReference.label" default="Digital Reference"/>
                </label>

                <div class="value">

                    ${fieldValue(bean: fileInstance, field: "digitalReference")}

                </div>

            </div>

        </div>

        <div class="buttons">
            <div class="floatRight">
                <g:hiddenField name="id" value="${fileInstance?.id}"/>
                <g:actionSubmit action="edit"
                                value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>&nbsp;&nbsp;
                <g:actionSubmit action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
            </div>

            <div class="clearBoth"></div>
        </div>

    </g:form>

</div>
</body>
</html>
