package com.rubikslab.digitalfiling

class DigitalStringUtils {

    private static int MAX_CHAR_TO_DISPLAY = 120

    public static String display(String text) {
        if (text.length() <= MAX_CHAR_TO_DISPLAY) {
            return text
        }

        String display = org.apache.commons.lang.StringUtils.left(text, MAX_CHAR_TO_DISPLAY)
        org.apache.commons.lang.StringUtils.substringBeforeLast(display, " ") + " ..."
    }
}
