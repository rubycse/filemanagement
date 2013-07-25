<html>
    <head>
        <title>Digital Filing :: <g:layoutTitle /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>


<body onload="${pageProperty(name: 'body.onload')}">

<div class="container" id="container">

    <g:render template="/layouts/topbar"/>

    <div class="body">

    <g:if test="${pageProperty(name: 'page.nav')}">
        <div class="heading">
            <div class="nav">
                <h2 class="floatLeft">${pageProperty(name: 'page.header')}</h2>
                <div>${pageProperty(name: 'page.nav')}</div>
                <div class="clearBoth"></div>
            </div>
        </div>
    </g:if>

        <div class="clearBoth"></div>

        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>

        <g:if test="${flash.error}">
            <div class="errorMessage">${flash.error}</div>
        </g:if>

        <g:layoutBody/>

    </div>

    <div class="clearBoth"></div>

</div>

</body>
</html>
