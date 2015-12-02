//
//  GlobalVars.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import Foundation

struct GlobalVars {
    // Constants
    static let DB_NAME = "impression.sqlite3"
    static let NB_QUESTION: Int = 3
    // Vars
    static var dbPath = ""
    static var currentQuestion = 0
    static var displayedQuestions: [Int64] = []
    static var questionAnswerProducts: [Int64] = []
}