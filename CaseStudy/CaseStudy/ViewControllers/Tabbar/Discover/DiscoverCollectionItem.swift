//
//  DiscoverCollectionItem.swift
//  CaseStudy
//
//  Created by Ömer Demir on 29.11.2022.
//

import UIKit


class DiscoverCollectionItem: NSObject {
    
    let data:Any
    let size:CGSize
    
    init(data:Any, size:CGSize) {
        self.data = data
        self.size = size
    }
}
