//
//  QuestionModel.swift
//  impression
//
//  Created by DAGUENET Valentin on 04/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import Foundation
import SQLite

struct QuestionExpressions {
    var id = SQLite.Expression<Int64>("id")
    var sentence = SQLite.Expression<String>("sentence")
    var firstProp = SQLite.Expression<String>("firstProp")
    var secondProp = SQLite.Expression<String>("secondProp")
    var firstProduct = SQLite.Expression<Int64>("firstProduct")
    var secondProduct = SQLite.Expression<Int64>("secondProduct")
    var background = SQLite.Expression<String>("background")
}

class QuestionModel{
    var table = Table("question")
    let expressions = QuestionExpressions()
    
    init() {}
    
    func findAll() -> [SQLite.Row] {
        let rows = Array(try DB_CONNECTION.prepare(self.table))

        return rows
    }
    
    func getRandomQuestion() -> SQLite.Row {
        let count = try DB_CONNECTION.scalar(self.table.count)
        
        let i = Int64(arc4random_uniform(UInt32(count)) + 1)
        
        if (GlobalVars.displayedQuestions.contains(i)) {
            return self.getRandomQuestion()
        }
        
        GlobalVars.displayedQuestions.append(i)
        
        return Array(try DB_CONNECTION.prepare(self.table.filter(self.expressions.id == i)))[0]
    }
}