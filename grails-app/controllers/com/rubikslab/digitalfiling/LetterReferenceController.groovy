package com.rubikslab.digitalfiling

import org.hibernate.Hibernate
import org.springframework.web.multipart.MultipartFile

class LetterReferenceController {

    static scaffold = true

    def index() { redirect(action: list) }

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
}
