package com.rubikslab.digitalfiling

class SubjectController {

    def scaffold = true

    def index() { redirect(action: "list") }
}
