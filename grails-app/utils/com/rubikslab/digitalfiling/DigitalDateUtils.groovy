package com.rubikslab.digitalfiling

class DigitalDateUtils {
    public static def YEAR_RANGE

    static {
        YEAR_RANGE = new ArrayList<String>()

        1978.upto(2099) {
            YEAR_RANGE.add(Utils.engToBengaliNumber(it.toString()))
        }
    }

    public static String getCurrentYear() {
        Utils.engToBengaliNumber(new Date().format("yyyy"))
    }
}
