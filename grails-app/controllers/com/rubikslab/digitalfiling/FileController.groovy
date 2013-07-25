package com.rubikslab.digitalfiling

class FileController {

    static scaffold = true

    def exportService

    def index = { redirect(action: "list") }

    def create = {
        def fileInstance = new File()
        fileInstance.properties = params
        def maxCode = File.executeQuery( 'select max(f.code) from File f')
        fileInstance.code = Utils.getNextCode(maxCode?.get(0), 3)
        return [fileInstance: fileInstance]
    }

    def exportToExcel = {
        response.contentType = 'application/vnd.ms-excel'
        response.setHeader("Content-disposition", "attachment; filename=files.${params.extension}")

        def fileList = params.excelFromSearch ? searchFiles(session.getAttribute(SessionKeys.FILE_SEARCH_COMMAND)) : File.list(params)
        exportService.export(params.format, response.outputStream, fileList,
                ['name', 'code', 'year', 'digitalReference'],
                ['name': 'Name', 'code': 'Code', 'year': 'Year', 'digitalReference': 'Digital Reference'], [:],
                ['column.widths': [0.6, 0.075, 0.075, 0.25]])
    }

    def search = {
        def fileInstance = session.getAttribute(SessionKeys.FILE_SEARCH_COMMAND) ?: new File()
        [fileInstance: fileInstance]
    }

    def resetSearch = {
        session.setAttribute(SessionKeys.FILE_SEARCH_COMMAND, null)
        redirect(action: 'search')
    }

    def display = {
        def fileInstance = new File(params)

        boolean isEmptySearch = [fileInstance.name, fileInstance.digitalReference, fileInstance.year].every {
            DigitalStringUtils.isEmpty it
        }

        if (isEmptySearch && !fileInstance.subject) {
            fileInstance.errors.reject("Please Select Subject / Digital Reference / Name / Year")
            render(view: "search", model: [fileInstance: fileInstance])
            return
        }

        session.setAttribute(SessionKeys.FILE_SEARCH_COMMAND, fileInstance)
        List<File> fileList = searchFiles(fileInstance)

        render(view: "list", model: [fileInstanceList: fileList, fileInstanceTotal: fileList.size(), excelFromSearch: true])
    }

    private List<File> searchFiles(File fileInstance) {
        def fileList = File.createCriteria().list {

            if (fileInstance.subject) eq("subject.id", fileInstance.subject.id)
            if (fileInstance.name) like("name", "%${fileInstance.name?.trim()}%")
            if (fileInstance.digitalReference) eq("digitalReference", "${fileInstance.digitalReference?.trim()}")
            if (fileInstance.year) eq("year", "${fileInstance.year.trim()}")

            order('id', 'desc')
        }
        fileList
    }
}
