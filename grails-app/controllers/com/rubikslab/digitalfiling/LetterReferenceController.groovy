package com.rubikslab.digitalfiling

class LetterReferenceController {

    static scaffold = true

    def index() { redirect(action: list) }
}
