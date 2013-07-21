package com.rubikslab.digitalfiling

class LetterReference {

    File file
    Date date
    String idNumber
    String addresseeName
    String description

    static constraints = {
        file(blank: false)
        date(blank: false)
        idNumber(blank: false, size: 4..4, matches: "[০-৯]+")
        addresseeName(blank: false)
        description(maxSize: 500)
    }

//    String getDigitalReference() {
//        file?.digitalReference + "-" + idNumber;
//    }
}
