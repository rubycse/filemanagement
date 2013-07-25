package com.rubikslab.digitalfiling

class File {

    String ministry
    String department
    String district
    String thana
    String office
    Subject subject
    String name
    String code
    String year
    String digitalReference

    static constraints = {
        ministry(blank: false, inList: ["স্থানীয় সরকার বিভাগ, স্থানীয় সরকার, পল্লী উন্নয়ন ও সমবায় মন্ত্রনালয়"])
        department(blank: false, inList: ["জনস্বাস্থ্য প্রকৌশল অধিদপ্তর"])
        district(blank: false, inList: ["প্রযোজ্য নয়"])
        thana(blank: false, inList: ["প্রযোজ্য নয়"])
        office(blank: false, inList: ["প্রধান প্রকৌশলীর দপ্তর"])
        subject(blank: false)
        name(blank: false, maxSize: 300)
        code(blank: false, unique: 'subject', size: 3..3, matches: "[০-৯]+")
        year(blank: false, inList: DigitalDateUtils.YEAR_RANGE, defaultValue: DigitalDateUtils.getCurrentYear())
        digitalReference(display: false, nullable: true)
    }

    def beforeInsert() {
        digitalReference = "৪৬.২০৩.০০০০.০০১." + subject?.code + "." + code + "." + year.substring(2)
    }

    String toString() {
        DigitalStringUtils.display(name)
    }
}
