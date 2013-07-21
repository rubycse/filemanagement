<% import grails.persistence.Event %>
<%=packageName%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
  <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<content tag="header">
  <g:message code="default.list.label" args="[entityName]"/>
</content>

<content tag="nav">
  <ul>
    <li class="newLink"><g:link action="create"><g:message code="default.link.new.label"/></g:link></li>
    <li class="homeLink"><a href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
  </ul>
</content>

<body>

<div class="content list">
  <table>
    <thead>
    <tr>
      <% excludedProps = Event.allEvents.toList() << 'version'
      props = domainClass.properties.findAll { !excludedProps.contains(it.name) && it.type != Set.class }
      Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
      props.eachWithIndex {p, i ->
        if (p.isAssociation()) { %>
      <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}"/></th>
      <% } else { %>
      <g:tSortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}"/>
      <% }
      } %>
    </tr>
    </thead>
    <tbody>
    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
      <tr class="\${(i % 2) == 0 ? 'odd' : 'even'}">
        <% props.eachWithIndex {p, i ->
          cp = domainClass.constrainedProperties[p.name]
          if (i == 0) { %>
        <td><g:link action="show" id="\${${propertyName}.id}">Open</g:link></td>
        <% } else {
          if (p.type == Boolean.class || p.type == boolean.class) { %>
        <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}"/></td>
        <% } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
        <td><g:tFormatDate date="\${${propertyName}.${p.name}}"/></td>
        <% } else { %>
        <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
        <% }
        }
        } %>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <g:tPaginate total="\${${propertyName}Total}"/>
  </div>
</div>
</body>
</html>
