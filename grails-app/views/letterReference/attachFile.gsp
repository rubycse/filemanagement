
<%@ page import="com.rubikslab.digitalfiling.LetterReference" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'letterReference.label', default: 'LetterReference')}"/>
    <title><g:message code="default.attachFile.label" args="[entityName]"/></title>
</head>

<content tag="header">
    <g:message code="default.attachFile.label" args="[entityName]"/>
</content>

<content tag="nav">
    <ul>
        <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
        <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
        <li class="homeLink"><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</content>

<body>

<div class="content">

    <g:form action="uploadFile" method="post" enctype="multipart/form-data">

        <div class="dialog">

            <div class="prop">
                <label>
                    <g:message code="letterReference.digitalReference.label" default="Digital Reference"/>
                </label>
                <div class="value">
                    ${fieldValue(bean: letterReferenceInstance, field: "digitalReference")}
                </div>
            </div>

            <div class="prop">
                <label for="description">
                    <g:message code="letterReference.description.label" default="Description"/>
                </label>
                <div class="value">
                    ${fieldValue(bean: letterReferenceInstance, field: "description")}
                </div>
            </div>

            <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'attachment', 'error')}">
                <label for="attachment">
                    <g:message code="letterReference.attachment.label" default="Attachment"/>
                </label>
                <div class="value">
                    <input type="file" class="field" id="attachment" name="attachment" />

                </div>
            </div>
        </div>

        <div class="buttons">
            <div class="floatRight">
                <g:hiddenField name="id" value="${letterReferenceInstance?.id}"/>
                <g:submitButton name="upload" value="${message(code: 'default.button.upload.label', default: 'Upload')}"/>&nbsp;&nbsp;
            </div>
            <div class="clearBoth"></div>
        </div>

    </g:form>

</div>
</body>
</html>
