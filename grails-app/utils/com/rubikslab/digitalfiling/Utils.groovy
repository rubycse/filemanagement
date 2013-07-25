package com.rubikslab.digitalfiling

import javax.servlet.http.HttpServletRequest

/**
 * @author: lutfun
 * @since: 7/21/13
 */
class Utils {
    public static int defaultListSize = 15

    private static def engToBengaliDigit = ['0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪', '5': '৫',
            '6': '৬', '7': '৭', '8': '৮', '9': '৯']

    public static String engToBengaliNumber(String engNumber) {
        if (!engNumber.matches('[0-9]+')) {
            throw new NumberFormatException("Invalid English Number: " + engNumber)
        }

        StringBuilder bengaliNumber = new StringBuilder()

        engNumber.getChars().each { it ->
            bengaliNumber.append(engToBengaliDigit[it.toString()])
        }

        bengaliNumber
    }

    public static String bengaliToEngNumber(String bengaliNumber) {
        if (!bengaliNumber.matches('[০-৯]+')) {
            throw new NumberFormatException("Invalid Bengali Number: " + bengaliNumber)
        }

        String engNumber = String.copyValueOf(bengaliNumber.toCharArray())

        engToBengaliDigit.each {
            engNumber.replace(it.value, it.key)
        }

        engNumber
    }

    public static getAttachmentFileName(HttpServletRequest request, String attachmentName) {
        String userAgent = request.getHeader("User-Agent").toLowerCase();
        boolean msie = userAgent.indexOf("msie") != -1
        return "attachment; filename=" + (msie ? attachmentName : "\"" + attachmentName + "\"")
    }
}
