package com.rubikslab.digitalfiling

class Subject {

    String name
    String code

    static constraints = {
        name(blank: false, maxSize: 300)
        code(blank: false, unique: true, size: 2..2, matches: "[০-৯]+")
    }

    String toString() {
        DigitalStringUtils.display(name)
    }
}
