
<%@ page import="com.rubikslab.digitalfiling.LetterReference" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'letterReference.label', default: 'LetterReference')}"/>
  <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.show.label" args="[entityName]"/>
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

  <g:form>

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
        <label for="file">
          <g:message code="letterReference.file.label" default="File"/>
        </label>
        <div class="value">
          <g:link controller="file" action="show" id="${letterReferenceInstance?.file?.id}">${letterReferenceInstance?.file?.encodeAsHTML()}</g:link>
        </div>

      </div>
      
      <div class="prop">
        <label for="date">
          <g:message code="letterReference.date.label" default="Date"/>
        </label>
        <div class="value">
          <g:tFormatDate date="${letterReferenceInstance?.date}"/>
        </div>
      </div>
      
      <div class="prop">
        <label for="idNumber">
          <g:message code="letterReference.idNumber.label" default="Id Number"/>
        </label>
        <div class="value">
          ${fieldValue(bean: letterReferenceInstance, field: "idNumber")}
        </div>
      </div>
      
      <div class="prop">
        <label for="addresseeName">
          <g:message code="letterReference.addresseeName.label" default="Addressee Name"/>
        </label>
        <div class="value">
          ${fieldValue(bean: letterReferenceInstance, field: "addresseeName")}
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

      <g:if test="${letterReferenceInstance.attachment}">
      <div class="prop">
        <label for="attachment">
          <g:message code="letterReference.attachment.label" default="Attachment"/>
        </label>
        <div class="value">
          <g:link name="downloadFile" action="downloadFile" params="[id: letterReferenceInstance.id]">${fieldValue(bean: letterReferenceInstance, field: "attachmentName")}</g:link>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <g:actionSubmit class="smallButton" value="${message(code: 'default.link.remove.label')}" action="removeFile" params="[id: letterReferenceInstance.id]"
                          onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </div>
      </div>
      </g:if>

    </div>

      <div class="buttons">
      <div class="floatRight">
        <g:hiddenField name="id" value="${letterReferenceInstance?.id}"/>
        <g:if test="${!letterReferenceInstance.attachment}"><g:actionSubmit action="attachFile" value="${message(code: 'default.button.attachFile.label', default: 'Attach File')}"/>&nbsp;&nbsp;</g:if>
        <g:actionSubmit action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>&nbsp;&nbsp;
        <g:actionSubmit action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
      </div>
      <div class="clearBoth"></div>
    </div>

  </g:form>

</div>
</body>
</html>
