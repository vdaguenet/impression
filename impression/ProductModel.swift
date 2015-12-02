//
//  ProductModel.swift
//  impression
//
//  Created by DAGUENET Valentin on 02/12/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import Foundation
import SQLite

struct ProductExpressions {
    var id = SQLite.Expression<Int64>("id")
    var name = SQLite.Expression<String>("name")
    var description = SQLite.Expression<String>("description")
    var image = SQLite.Expression<String>("image")
}

class ProductModel {
    var db: Connection!
    var table: Table!
    let expressions = ProductExpressions()
    
    init() {
        do {
            self.db = try Connection(GlobalVars.dbPath)
            print("[Product] Connected to database")
            
            self.table = Table("product")
            
            
        } catch {
            print("[Product] Can not connect to database")
        }
        
    }
}
