<%@ page import="com.rubikslab.digitalfiling.Subject" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'subject.label', default: 'Subject')}"/>
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
        <label for="name">
          <g:message code="subject.name.label" default="Name"/>
        </label>

        <div class="value">

          ${fieldValue(bean: subjectInstance, field: "name")}

        </div>

      </div>

      <div class="prop">
        <label for="code">
          <g:message code="subject.code.label" default="Code"/>
        </label>

        <div class="value">

          ${fieldValue(bean: subjectInstance, field: "code")}

        </div>

      </div>

    </div>

    <div class="buttons">
      <div class="floatRight">
        <g:hiddenField name="id" value="${subjectInstance?.id}"/>
        <g:actionSubmit action="edit"
                        value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>&nbsp;&nbsp;
        <g:actionSubmit action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
      </div>

      <div class="clearBoth"></div>
    </div>

  </g:form>

</div>
</body>
</html>
