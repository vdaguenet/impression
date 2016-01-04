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
    var citation = SQLite.Expression<String>("citation")
    var auteurCitation = SQLite.Expression<String>("auteurCitation")
    var imageCitation = SQLite.Expression<String>("imageCitation")
    
}

class ProductModel {

    var table = Table("product")
    let expressions = ProductExpressions()
    
    init() {}
    
    func find(id: Int64) -> SQLite.Row {
        return Array(try DB_CONNECTION.prepare(self.table.filter(self.expressions.id == id)))[0]
    }
}