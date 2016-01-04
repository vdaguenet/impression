//
//  GlobalVars.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import Foundation
import SQLite

struct GlobalVars {
    // Constants
    static let DB_NAME = "impression.sqlite3"
    static let NB_QUESTION: Int = 4
    // Vars
    static var dbPath = ""
    static var currentQuestion = 0
    static var displayedQuestions: [Int64] = []
    static var questionAnswers: [Int64] = []
    static var productsFinded: [SQLite.Row] = []
    
}