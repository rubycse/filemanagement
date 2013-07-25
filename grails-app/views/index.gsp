<html>
    <head>
        <title>Welcome to Grails</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">

        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        .moduleBox {
            border: 1px solid #AAAAAA;
            width: 150px;
            height: 200px;
            float: left;
            margin: 10px 20px;
            padding: 5px;
            font-size: 12px;
        }
        .moduleTitle {
            padding: 5px;
            border-bottom: 1px solid #D6D6D6;
            font-weight: bold;
        }
        .moduleBox li {
            list-style: none;
            padding-left: 10px;
            padding-top: 5px;
        }
        </style>
    </head>
    <body>
        <div class="moduleBox">
            <div class="moduleTitle">
                Subject
            </div>
            <ul>
                <li><g:link controller="subject" action="create">Create</g:link></li>
                <li><g:link controller="subject" action="list">List</g:link></li>
            </ul>
        </div>

        <div class="moduleBox">
            <div class="moduleTitle">
                File
            </div>
            <ul>
                <li><g:link controller="file" action="create">Create</g:link></li>
                <li><g:link controller="file" action="list">List</g:link></li>
                <li><g:link controller="file" action="search">Search</g:link></li>
            </ul>
        </div>

        <div class="moduleBox">
            <div class="moduleTitle">
                Letter
            </div>
            <ul>
                <li><g:link controller="letterReference" action="create">Create</g:link></li>
                <li><g:link controller="letterReference" action="list">List</g:link></li>
                <li><g:link controller="letterReference" action="search">Search</g:link></li>
            </ul>
        </div>
    </body>
</html>
