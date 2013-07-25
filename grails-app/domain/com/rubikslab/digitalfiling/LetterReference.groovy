package com.rubikslab.digitalfiling

import java.sql.Blob

class LetterReference {
    private static MAX_FILE_SIZE = 1024 * 1024 * 2 //2MB

    File file
    Date date
    String idNumber
    String addresseeName
    String description
    Blob attachment
    String attachmentType
    String attachmentName
    String digitalReference

    static constraints = {
        file(blank: false)
        date(nullable: true)
        idNumber(blank: false, size: 4..4, matches: "[০-৯]+")
        addresseeName(blank: false)
        description(maxSize: 500)
        attachment(nullable: true, maxSize: MAX_FILE_SIZE)
        attachmentType(nullable: true)
        attachmentName(nullable: true)
        digitalReference(nullable: true)
    }

    def beforeInsert() {
        digitalReference = file?.digitalReference + "-" + idNumber
    }
}
