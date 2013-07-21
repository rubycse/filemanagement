<% import grails.persistence.Event %>
<%=packageName%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
  <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.show.label" args="[entityName]"/>
</content>

<content tag="nav">
  <ul>
    <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
    <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
    <li class="homeLink"><a href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
  </ul>
</content>

<body>

<div class="content">

  <g:form>

    <div class="dialog">
      <% excludedProps = Event.allEvents.toList() << 'version'
      props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
      Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
      props.each {p -> %>
      <div class="prop">
        <label for="${p.name}">
          <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}"/>
        </label>
        <div class="value">
          <% if (p.isEnum()) { %>
          \${${propertyName}?.${p.name}?.encodeAsHTML()}
          <% } else if (p.oneToMany || p.manyToMany) { %>
          <ul>
            <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
              <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
            </g:each>
          </ul>
          <% } else if (p.manyToOne || p.oneToOne) { %>
          <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>
          <% } else if (p.type == Boolean.class || p.type == boolean.class) { %>
          <g:formatBoolean boolean="\${${propertyName}?.${p.name}}"/>
          <% } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
          <g:tFormatDate date="\${${propertyName}?.${p.name}}"/>
          <% } else { %>
          \${fieldValue(bean: ${propertyName}, field: "${p.name}")}
          <% } %>
        </div>

      </div>
      <% } %>
    </div>

    <div class="buttons">
      <div class="floatRight">
        <g:hiddenField name="id" value="\${${propertyName}?.id}"/>
        <g:actionSubmit action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}"/>&nbsp;&nbsp;
        <g:actionSubmit action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
      </div>
      <div class="clearBoth"></div>
    </div>

  </g:form>

</div>
</body>
</html>
