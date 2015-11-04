//
//  QuestionModel.swift
//  impression
//
//  Created by DAGUENET Valentin on 04/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import Foundation
import SQLite

class QuestionModel{
    var db: Connection!
    var table: Table!
    
    init() {
        do {
            self.db = try Connection(DB_PATH)
            print("Connected to database")
            
            self.table = Table("question")
            
        } catch {
            print("Can not connect to database")
        }
        
    }
    
    func findAll() -> [SQLite.Row] {
        let rows = Array(try self.db.prepare(self.table))

        return rows
    }
    
    func getRandomQuestion() {
        
    }
}