package com.rubikslab.digitalfiling;

import java.lang.String;
import java.util.List;

class DigitalDateUtils {
    static {
        1978.upto(2099) {
            Utils.engToBengaliNumber(it.toString())
        }
    }
    public static List<String> YEAR_RANGE = ["১৯৭৮", "১৯৭৯", "১৯৮০", "১৯৮১"]

}
