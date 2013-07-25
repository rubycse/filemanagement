package com.rubikslab.digitalfiling

class FileController {

    static scaffold = true

    def exportService

    def index = { redirect(action: "list") }

    def exportToExcel = {
        response.contentType = 'application/vnd.ms-excel'
        response.setHeader("Content-disposition", "attachment; filename=files.${params.extension}")

        exportService.export(params.format, response.outputStream, File.list(params),
                ['name', 'code', 'year', 'digitalReference'],
                ['name': 'Name', 'code': 'Code', 'year': 'Year', 'digitalReference': 'Digital Reference'], [:],
                ['column.widths': [0.6, 0.075, 0.075, 0.25]])
    }

    def search = {
        def fileInstance = new File()
        [fileInstance: fileInstance]
    }

    def display = {
        def fileInstance = new File(params)

        boolean isEmptySearch = [fileInstance.name, fileInstance.digitalReference, fileInstance.year].every {
            DigitalStringUtils.isEmpty it
        }

        if (isEmptySearch) {
            fileInstance.errors.reject("Please Select Digital Reference / Name / Year")
            render(view: "search", model: [fileInstance: fileInstance])
            return
        }

        def fileList = File.createCriteria().list {

            if (fileInstance.name) like("name", "%${fileInstance.name?.trim()}%")
            if (fileInstance.digitalReference) eq("digitalReference", "${fileInstance.digitalReference?.trim()}")
            if (fileInstance.year) eq("year", "${fileInstance.year.trim()}")

            order('id', 'desc')
        }

        render(view: "list", model: [fileInstanceList: fileList, fileInstanceTotal: fileList.size()])
    }
}
