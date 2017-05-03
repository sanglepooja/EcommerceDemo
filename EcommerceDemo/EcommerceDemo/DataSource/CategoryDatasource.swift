//
//  CategoryDatasource.swift
//  EcommerceDemo
//
//  Created by Faasos on 03/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

enum CategoryCelltype:String {
    case WithChildCategory
    case WithProducts
}

class CategoryDatasource: NSObject {

    var category : Category?
    var categoryCelltype : CategoryCelltype?
    var nestedCategoryDatasource : [CategoryDatasource] = []
    var indexpath : IndexPath?
    
    
    init(category: Category, categoryCelltype:CategoryCelltype) {
        
        self.category = category
        self.categoryCelltype = categoryCelltype
        
    }
    
}
