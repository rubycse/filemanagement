package digitalfiling

import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib

class DigitalTagLibTagLib {
    def pdf = {attrs, body ->

        def controller = attrs.controller ?: params.controller
        def action = attrs.action ?: params.action
        def id = attrs.id ?: params.id
        def fileName = "${attrs.fileName ?: (controller - "Controller")}.pdf".encodeAsURL()
        def title = (attrs.title ?: "").encodeAsURL()
        def linkLabel = attrs.linkLabel

        def servletPath = "${controller}/${action}"
        def path = "${request.contextPath}/pdf/${servletPath}/${id}?pdf=true&fileName=${fileName}&title=${title}"
        def icon = attrs.icon

        def parameters = ""
        def forwardParams = attrs.params
        if (forwardParams != null) {
            forwardParams.each {
                parameters += "&${it.key}=${it.value?.encodeAsURL()}"
            }
        }
        path += parameters

        if (icon == null || icon == "") {
            icon = "pdf_icon.gif"
        }

        out << "<a href='${path}'>"

        out << "<img src="
        out << "${createLinkTo(dir: 'images', file: icon)}"
        out << " alt='PRINT'/>"
        if (linkLabel) {
            out << " <br> ${linkLabel}"
        }

        out << body()

        out << "</a>"

    }

    /* Usage:
    * <g:checkBoxGroup
    *        from="optionList"
    *        name="name"
    *        value="value"
    *        optionKey="key"
    *        optionValue="value"
    *        display="vertical"
    * />
    *
    * Required fields
    * 1. from
    * 2. name
    *
    * Optional fields
    * 1. value
    * 2. optionKey
    * 3. optionValue
    * 4. display
    *
    * Default display is horizontal. In such case, elementsPerRow field (default is 5) can be used
    */

    def checkBoxGroup = {attrs, body ->

        def optionList = attrs.from
        def value = attrs.value
        def cname = attrs.name

        def optionValue = attrs.optionValue
        def optionKey = attrs.optionKey

        def display = attrs.display ?: "horizontal"
        def separator
        int elementsPerRow = 0

        if (display == "vertical") {
            separator = "<br>"
        }
        else {
            separator = "&nbsp;"
            elementsPerRow = attrs.elementsPerRow?.toInteger() ?: 5
        }

        int elementCount = 0

        out << "<input type='hidden' name=_${cname} value=''/>"

        optionList?.each {obj ->
            if (obj) {
                def option = optionValue ? obj."${optionValue}" : obj
                def key = optionKey ? obj."${optionKey}" : obj
                def isChecked = value?.contains(key) ? "checked" : ""
                out << "<input type='checkbox' name=${cname} value=${key} ${isChecked} /> ${option}"

                out << separator

                if (elementsPerRow) {
                    elementCount++
                    elementCount % elementsPerRow == 0 ? out << "<br>" : ""
                }
            }

        }
    }

    /**
     *  <g:quickSearch
     *        searchFor="net.therap.states.Individual"
     *        searchIn="['firstName', 'lastName']"
     *        forwardController="questionnaire"
     *        forwardAction="individualQuestionnaireList"
     *        forwardParams=[param1, param2]
     *        inputTextSize="20"
     *        searchInstance="1"
     *        defaultText=""
     *        minSearchCharacter="3"
     *        frequency="0.05"
     *  />
     *
     * Required fields
     * 1. searchFor
     * 2. searchIn
     * 3. forwardController
     * 4. forwardAction
     *
     * Optional fields
     * 5. forwardParams contains list of parameters
     * 6. inputTextSize is the size of the search text box
     * 7. searchInstance is only required if quickSearch is used more then once in a page
     * 8. defaultText shows in the search text field as default value
     * 9. minSearchCharacter is the minimum number of characters that must be entered in the input field before an Ajax request is made.
     * 10. frequency is how frequently (in seconds) the input field should be polled for changes before firing an Ajax request.
     */

    def quickSearch = {attributes, body ->

        def searchFor = attributes.searchFor
        def searchInPropertyList = attributes.searchIn
        def filterKey = attributes.filter?.key
        def filterValue = attributes.filter?.value

        def forwardController = attributes.forwardController
        def forwardAction = attributes.forwardAction
        def forwardParams = attributes.forwardParams
        def forwardTo = new ApplicationTagLib().createLink(url: [controller: forwardController, action: forwardAction])

        def parameters = ""
        if (forwardParams != null) {
            forwardParams.each {
                parameters += it + "&"
            }
        }

        String searchIn = ""
        searchInPropertyList.each {
            if (searchIn.length() > 0) {
                searchIn += ", "
            }
            searchIn += it
        }

        def searchUlr = new ApplicationTagLib().createLink(url: [controller: "quickSearch", action: "search",
                params: [filterKey: filterKey, filterValue: filterValue]])
        def searchParam = "'searchFor=$searchFor&searchIn=$searchIn'"

        def searchInstance = attributes.searchInstance ?: 1
        def inputTextSize = attributes.inputTextLength ?: 20
        def defaultText = attributes.defaultText ?: ""
        def minSearchCharacter = attributes.minSearchCharacter ?: 3
        minSearchCharacter = minSearchCharacter.toInteger() < 3 ? '3' : minSearchCharacter //due to performance concern
        def frequency = attributes.frequency ?: 0.4

        def afterUpdateElement = attributes.afterUpdateElement ?:
            (attributes.addToHidden ?
                """function defaultAfterUpdateElement${searchInstance}(text, li) {
                    if (li.id == '-1')
                        return;
                    document.getElementById('${attributes.addToHidden}').value = li.id;
                    document.getElementById('autocomplete${searchInstance}').setAttribute('class', 'valid');
                }""" :

                """function defaultAfterUpdateElement${searchInstance}(text, li) {
                    if (li.id == '-1')
                        return;
                    document.getElementById('autocomplete${searchInstance}').setAttribute('class', 'valid');
                    window.location = \"${forwardTo}?${parameters}id=\" + li.id ;
                }"""
            )

        out << """
            <table>
            <tr>
                <td>
                    <input type="text" class='valid' id="autocomplete${searchInstance}" name="autocomplete_parameter"
                        size="${inputTextSize}" value="${defaultText}"
                        onkeypress="checkKeyPressed${searchInstance}(event);"
                        onblur="if (this.value == '' || this.value == '${QuickSearchController.MAX_RESULT_SIZE_MSG}') {
                            this.value='${defaultText}';
                            document.getElementById('autocomplete${searchInstance}').setAttribute('class', 'valid');
                            if (document.getElementById('${attributes.addToHidden}') != null) {
                                document.getElementById('${attributes.addToHidden}').value = '';
                            }
                        }"
                        onfocus="if (this.value == '${defaultText}') this.value='';" />
                    <div id="autocomplete_choices${searchInstance}" class="autocomplete"></div>
                </td>
                <td style="width:20px;">
                <img src="${createLinkTo(dir: 'images', file: 'busy.gif')}" alt='Loading' id="busy_${searchInstance}" style="display:none;"/>
                </td>
            </tr>
            </table>
                <script>
                    function checkKeyPressed${searchInstance}(e) {
                    var keynum;
                    if (window.event) // IE
                    {
                        keynum = e.keyCode;
                    }
                    else if (e.which) // Netscape/Firefox/Opera
                    {
                        keynum = e.which;
                    }
                    if ((keynum == undefined) && (e.keyCode == 46)) {  //special check for delete button
                        keynum = 127;
                    }

                        if (keynum == 8 || (keynum >= 32 && keynum <= 127)) {
                            document.getElementById('autocomplete${searchInstance}').setAttribute('class', 'invalid');
                            if (document.getElementById('${attributes.addToHidden}') != null) {
                                document.getElementById('${attributes.addToHidden}').value = '';
                            }
                        }
                    }

                      document.observe("dom:loaded", function() {
                          new Ajax.Autocompleter("autocomplete${searchInstance}", "autocomplete_choices${searchInstance}", "${searchUlr}", {
                                      parameters: ${searchParam},
                                      afterUpdateElement: ${afterUpdateElement},
                                      minChars: ${minSearchCharacter},
                                      frequency: ${frequency},
                                      indicator: "busy_${searchInstance}"
                                  }
                              );
                      });
                      ${afterUpdateElement}
                </script>
                """
    }

    def keepLineBreak = {attribute, body ->
        out << attribute.value?.replace("\r\n", "<br/>").replace("\n\r", "<br/>").
                replace("\r", "<br/>").replace("\n", "<br/>")
    }

    def invokeTag = {attrs, body ->
        def tag = attrs.tag
        attrs.remove("tag")
        out << g."$tag"(attrs, body)
    }

    def remotePaginate = {attrs, body ->
        out << util.remotePaginate(attrs)
    }

    def remoteSortableColumn = {attrs, body ->
        out << util.remoteSortableColumn(attrs)
    }

    def datePicker = {attrs, body ->
        def id = attrs.id
        String value = (attrs.value ?
            (attrs.value?.class?.name == 'java.lang.String' ?
                attrs.value :
                Utils.formatDate(attrs.value, 'MM/dd/yyyy', "US/Central")) :
            '')
        out << "<input type='text' class='date-ui' name=${attrs.name}"
        out << " value='${value}'"
        if (id) {
            out << " id='${id}'"
        }
        out << ">"
    }

    def tPaginate = { attrs, body ->
        attrs.params = filterNestedParams(params)
        out << g.paginate(attrs, body)
    }

    def tExportExcel = { attrs, body ->
        attrs.params = filterNestedParams(params)
        def action = (attrs.action ? attrs.action : (params.action ? params.action : "list"))
        attrs.params.format = 'excel'
        attrs.params.extension = 'xls'
        def forwardTo = new ApplicationTagLib().createLink(url: [action: action, params: attrs.params])

        def size = (attrs.size) ?: 0

        if (Utils.exceedExcelMaxRowLimit(size)) {
            def msg = "Please note that, the report contains more than 64,000 rows/records. However, once exported, the excel file will contain only 64,000 records. You may want to refine the criteria to export a complete report containing no more than 64,000 records."
            out << """<div class="export" style="text-align: center;">
                      <span class="menuButton">
                        <p class="warnings">
                        ${msg}
                        </p>
                        <a href="${forwardTo}" class="excel" >Export To Excel</a>
                      </span>
                  </div>"""
        }
        else {
            out << """<div class="export" style="text-align: center;">
                      <span class="menuButton">
                        <a href="${forwardTo}" class="excel">Export To Excel</a>
                      </span>
                  </div>"""
        }
    }

    def tSortableColumn = { attrs, body ->
        attrs.params = filterNestedParams(params)
        out << g.sortableColumn(attrs, body)
    }

    /*
     * Handling grails's support for nested parameter map. Ignoring such nested map values
     */

    def filterNestedParams(params) {
        def filteredParams = [:]
        params.each {key, value ->
            if (!(value instanceof Map)) {
                filteredParams[key] = value
            }
        }
        filteredParams
    }

    def multiSelect = {attrs, body ->
        def optionList = attrs.from
        def value = attrs.value
        def cname = attrs.name

        def optionValue = attrs.optionValue
        def optionKey = attrs.optionKey
        out << "<input type='hidden' name=_${cname} value=''/>"
        out << """<select id=${cname} class="multiselect" multiple="multiple" name=${cname}>"""
        optionList?.each {obj ->
            if (obj) {
                def option = optionValue ? obj."${optionValue}" : obj
                def key = optionKey ? obj."${optionKey}" : obj
                def isSelected = value?.contains(key) ? "selected=\"selected\"" : ""
                out << "<option value=${key} ${isSelected} > ${option}</option>"
            }
        }
        out << """</select>"""
    }

    def tFormatDate = { attrs, body ->
        attrs.timeZone = "Asia/Dhaka"
        out << g.formatDate(attrs, body)
    }

    def countableTextArea = { attrs, body ->

        def escapeHtml = true
        if (attrs.escapeHtml) escapeHtml = Boolean.valueOf(attrs.remove('escapeHtml'))

        // Pull out the value to use as content not attrib
        def value = attrs.remove('value')
        if (!value) {
            value = body()
        }
        out << """<textarea  """
        attrs.each { k, v ->
            out << "$k=\"${v.encodeAsHTML()}\" "
        }
        out << """ >""" << """${escapeHtml ? value.encodeAsHTML() : value}</textarea>"""
        def check = Integer.valueOf(attrs.remove('isCountable'))
        def length = Integer.valueOf(attrs.remove('length'))
        if (check == 1) {
            out << """<p style="margin: 0;"> <span id="${attrs.id}-counter">About ${length} character(s) left </span> </p>"""
        }
    }
}
