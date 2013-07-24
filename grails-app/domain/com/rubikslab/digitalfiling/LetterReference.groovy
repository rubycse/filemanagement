package com.rubikslab.digitalfiling

import java.sql.Blob

class LetterReference {

    File file
    Date date
    String idNumber
    String addresseeName
    String description
    byte[] attachment

    static constraints = {
        file(blank: false)
        date(nullable: true)
        idNumber(blank: false, size: 4..4, matches: "[০-৯]+")
        addresseeName(blank: false)
        description(maxSize: 500)
        attachment(nullable: true, display: false)
    }

//    String getDigitalReference() {
//        file?.digitalReference + "-" + idNumber;
//    }
}
