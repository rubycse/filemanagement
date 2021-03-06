

<%@ page import="com.rubikslab.digitalfiling.LetterReference" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'letterReference.label', default: 'LetterReference')}"/>
  <title><g:message code="default.create.label" args="[entityName]"/></title>
  <resource:dateChooser />
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
<g:hasErrors bean="${letterReferenceInstance}">
  <div class="errors">
    <g:renderErrors bean="${letterReferenceInstance}" as="list"/>
  </div>
</g:hasErrors>

<div class="content">
  <g:form action="save" method="post">
    <div class="dialog">
      
      <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'file', 'error')}">
        <label for="file">
          <g:message code="letterReference.file.label" default="File"/>
          <span class="asterisk">*</span>
        </label>
        <div class="value">
          <g:select name="file.id" class="field" from="${com.rubikslab.digitalfiling.File.list()}" optionKey="id" value="${letterReferenceInstance?.file?.id}"  />

        </div>
      </div>
      
      <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'date', 'error')}">
        <label for="date">
          <g:message code="letterReference.date.label" default="Date"/>
          <span class="asterisk">*</span>
        </label>
        <div class="value">
          <richui:dateChooser name="date" format="${message(code: 'default.date.format')}" value="${letterReferenceInstance.date}" />
        </div>
      </div>
      
      <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'idNumber', 'error')}">
        <label for="idNumber">
          <g:message code="letterReference.idNumber.label" default="Id Number"/>
          <span class="asterisk">*</span>
        </label>
        <div class="value">
          <g:textField name="idNumber" class="field" maxlength="4" value="${letterReferenceInstance?.idNumber}" />
        </div>
      </div>
      
      <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'addresseeName', 'error')}">
        <label for="addresseeName">
          <g:message code="letterReference.addresseeName.label" default="Addressee Name"/>
          <span class="asterisk">*</span>
        </label>
        <div class="value">
          <g:textField name="addresseeName" class="field" value="${letterReferenceInstance?.addresseeName}" />
        </div>
      </div>
      
      <div class="prop ${hasErrors(bean: letterReferenceInstance, field: 'description', 'error')}">
        <label for="description">
          <g:message code="letterReference.description.label" default="Description"/>
        </label>
        <div class="value">
          <g:countableTextArea name="description" id="description" class="field" cols="25" rows="4" isCountable="1" length="500" value="${letterReferenceInstance?.description}" />
        </div>
      </div>
      
    </div>

    <div class="buttons">
      <div class="floatRight">
        <g:submitButton name="create" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
      </div>
      <div class="clearBoth"></div>
    </div>
  </g:form>
</div>
</body>
</html>
