package com.rubikslab.digitalfiling

class FileController {

    static scaffold = true

    def index = { redirect(action: "list") }

    def search = {
    }

    def result = {
        def subject
        def code

        if (params.digitalReference?.trim()?.length() == 25 && params.digitalReference?.startWith("৪৬.২০৩.০০০০.০০১.")) {
            def subCode = params.digitalReference.subString(16, 17)
            subject = Subject.findByCode(subCode)
            code = params.digitalReference.subString(19, 20)
        } else {
            flash.message = "Invalid Digital Reference"
            render(view: "search", model: [params: params])
            return
        }

        def fileList = File.createCriteria().list {
//            if (subject) eq("subject.id", "${subject.id.toLong()}")
//            else if (params.subjectId) eq("subject.id", "${params.subjectId?.toLong()}")

            if (code) eq("code", "${code}")
            else if (params.code) eq("code", "${params.code}")

            order('id', 'desc')
        }

        render(view: "list", model: [fileInstanceList: fileList, fileInstanceTotal: fileList.size()])
    }
}
