//
//  StoreModel.swift
//  impression
//
//  Created by DAGUENET Valentin on 05/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import Foundation
import SQLite

struct StoreExpressions {
    var id = SQLite.Expression<Int64>("id")
    var name = SQLite.Expression<String>("name")
    var adress = SQLite.Expression<String>("adress")
    var city = SQLite.Expression<String>("city")
    var hours = SQLite.Expression<String>("hours")
    var lat = SQLite.Expression<Double>("lat")
    var long = SQLite.Expression<Double>("long")
}

class StoreModel{
    var table = Table("store")
    let expressions = StoreExpressions()
    
    init() {}
    
    func findAll() -> [SQLite.Row] {
        let rows = Array(try DB_CONNECTION.prepare(self.table))
        
        return rows
    }
}
