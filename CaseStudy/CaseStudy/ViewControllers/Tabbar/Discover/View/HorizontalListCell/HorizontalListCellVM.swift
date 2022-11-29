//
//  HorizontalListCellVM.swift
//  CaseStudy
//
//  Created by Ömer Demir on 29.11.2022.
//

import UIKit


class HorizontalListCellVM:NSObject {
    
    let list:[ProductCellVM]
    let itemSpace:CGFloat
    var itemSize:CGSize
    
    init(list:[ProductCellVM], itemSpace:CGFloat, itemSize:CGSize) {
        self.list = list
        self.itemSpace = itemSpace
        self.itemSize = itemSize
    }
    
    
}
