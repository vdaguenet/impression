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
}

class QuestionModel{
    var db: Connection!
    var table: Table!
    let expressions = QuestionExpressions()
    
    init() {
        do {
            self.db = try Connection(GlobalVars.dbPath)
            print("[Question] Connected to database")

            self.table = Table("question")

            
        } catch {
            print("[Question] Can not connect to database")
        }
        
    }
    
    func findAll() -> [SQLite.Row] {
        let rows = Array(try self.db.prepare(self.table))

        return rows
    }
    
    func getRandomQuestion() -> SQLite.Row {
        let count = try db.scalar(self.table.count)
        
        let i = Int64(arc4random_uniform(UInt32(count)) + 1)
        
        if (GlobalVars.displayedQuestions.contains(i)) {
            return self.getRandomQuestion()
        }
        
        GlobalVars.displayedQuestions.append(i)
        
        return Array(try self.db.prepare(self.table.filter(self.expressions.id == i)))[0]
    }
}