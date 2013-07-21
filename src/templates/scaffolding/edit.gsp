<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
  <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.edit.label" args="[entityName]"/>
</content>

<content tag="nav">
  <ul>
    <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
    <li class="listLink"><g:link action="list"><g:message code="default.link.list.label"/></g:link></li>
    <li class="homeLink"><a href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
  </ul>
</content>

<body>
<g:hasErrors bean="\${${propertyName}}">
  <div class="errors">
    <g:renderErrors bean="\${${propertyName}}" as="list"/>
  </div>
</g:hasErrors>

<div class="content">
  <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
    <g:hiddenField name="id" value="\${${propertyName}?.id}"/>
    <g:hiddenField name="version" value="\${${propertyName}?.version}"/>
    <div class="dialog">
      <% excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
      props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
      Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
      display = true
      boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
      props.each {p ->
        if (hasHibernate) {
          cp = domainClass.constrainedProperties[p.name]
          display = (cp?.display ?: true)
        }
        if (display) { %>
      <div class="prop \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'error')}">
        <label for="${p.name}">
          <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}"/>
          <% if (!cp.blank) { %>
          <span class="asterisk">*</span>
          <% } %>
        </label>
        <div class="value">
          ${renderEditor(p)}
        </div>
      </div>
      <% }
      } %>
    </div>

    <div class="buttons">
      <div class="floatRight">
        <g:actionSubmit action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}"/>&nbsp;&nbsp;
        <g:actionSubmit action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
      </div>
      <div class="clearBoth"></div>
    </div>
  </g:form>
</div>
</body>
</html>
