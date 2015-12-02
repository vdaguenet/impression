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

    var table = Table("product")
    let expressions = ProductExpressions()
    
    init() {}
}
