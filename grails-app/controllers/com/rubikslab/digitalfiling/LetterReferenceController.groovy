package com.rubikslab.digitalfiling

import org.hibernate.Hibernate
import org.springframework.web.multipart.MultipartFile

class LetterReferenceController {

    static scaffold = true

    def index() { redirect(action: list) }

    def create = {
        def letterReferenceInstance = new LetterReference()
        letterReferenceInstance.properties = params
        def maxIdNumber = LetterReference.executeQuery( 'select max(l.idNumber) from LetterReference l')
        letterReferenceInstance.idNumber = Utils.getNextCode(maxIdNumber?.get(0), 4)
        letterReferenceInstance.date = new Date()
        return [letterReferenceInstance: letterReferenceInstance]
    }

    def attachFile = {
        def letterReferenceInstance = LetterReference.get(params.id)
        if (!letterReferenceInstance) {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: 'letterReference.label', default: 'Letter Reference'), params.id])}"
            redirect(action: "list")
        }
        else {
            [letterReferenceInstance: letterReferenceInstance]
        }
    }

    def uploadFile = {
        MultipartFile attachment = request.getFile('attachment')
        if (attachment.empty) {
            flash.message = 'File cannot be empty'
            render(view: 'attachFile')
            return
        }

        def letterReferenceInstance = LetterReference.get(params.id)

        if (letterReferenceInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (letterReferenceInstance.version > version) {

                    letterReferenceInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'letterReference.label', default: 'LetterReference')] as Object[], "Another user has updated this Letter Reference while you were editing")
                    render(view: "attachFile", model: [letterReferenceInstance: letterReferenceInstance])
                    return
                }
            }

            letterReferenceInstance.attachment = Hibernate.createBlob(attachment.bytes)
            letterReferenceInstance.attachmentName = attachment.getOriginalFilename()

            if (!letterReferenceInstance.hasErrors() && letterReferenceInstance.save(flush: true)) {
                flash.message = "Attachment Uploaded Successfully"
                redirect(action: "show", id: letterReferenceInstance.id)
            }
            else {
                render(view: "attachFile", model: [letterReferenceInstance: letterReferenceInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'letterReference.label', default: 'LetterReference'), params.id])}"
            redirect(action: "list")
        }
    }

    def downloadFile = {
        def letterReferenceInstance = LetterReference.get(params.id)
        if (letterReferenceInstance) {
            response.contentType = letterReferenceInstance.attachmentType
            response.addHeader('Content-disposition', Utils.getAttachmentFileName(request, letterReferenceInstance.attachmentName))
            response.outputStream << letterReferenceInstance.attachment.getBytes(1, (int) letterReferenceInstance.attachment.length())
            return
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'letterReference.label', default: 'LetterReference'), params.id])}"
            redirect(action: "list")
        }
    }

    def removeFile = {
        def letterReferenceInstance = LetterReference.get(params.id)
        if (letterReferenceInstance) {
            letterReferenceInstance.attachment = null
            letterReferenceInstance.attachmentType = null
            letterReferenceInstance.attachmentName = null
            if (letterReferenceInstance.save(flush: true)) {
                flash.message = "Attachment Removed Successfully"
                render(view: "show", model: [letterReferenceInstance: letterReferenceInstance])
            }
        }
    }

    def search = {
        [letterReferenceCmd: new LetterReferenceCmd()]
    }

    def display = {

        def letterReferenceCmd = new LetterReferenceCmd()
        bindData letterReferenceCmd, params

        boolean isEmptySearch = DigitalStringUtils.isEmpty(letterReferenceCmd.addresseeName)  &&
                DigitalStringUtils.isEmpty(letterReferenceCmd.digitalReference) &&
                letterReferenceCmd.fromDate == null &&
                letterReferenceCmd.toDate == null

        if (isEmptySearch) {
            flash.error = "Please Select Digital Reference / Date Range / Assignee Name"
            render(view: "search", model: [letterReferenceCmd: letterReferenceCmd])
            return
        }

        def letterReferenceList = LetterReference.createCriteria().list {

            if (letterReferenceCmd.fromDate && letterReferenceCmd.toDate) {
                ge("date", letterReferenceCmd.fromDate)
                le("date", letterReferenceCmd.toDate)
            }
            if (letterReferenceCmd.digitalReference) eq("digitalReference", "${letterReferenceCmd.digitalReference?.trim()}")
            if (letterReferenceCmd.addresseeName) like("addresseeName", "%${letterReferenceCmd.addresseeName?.trim()}")
            if (letterReferenceCmd.description) like("description", "%${letterReferenceCmd.description?.trim()}")

            order('id', 'desc')
        }

        render(view: "list", model: [letterReferenceInstanceList: letterReferenceList, letterReferenceInstanceTotal: letterReferenceList.size()])
    }
}

class LetterReferenceCmd {
    String digitalReference
    Date fromDate
    Date toDate
    String addresseeName
    String description
}
