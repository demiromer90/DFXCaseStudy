//
//  Product.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import Foundation


class Product: Codable {

    var imageUrl:String?
    var desc:String?
    var currency:String?
    var discount:String?
    var rate_percentage:Double?
    @DecodableDefault.ZeroPrice var price:Price
    var old_price:Price?
    
    
    enum CodingKeys: String, CodingKey {
        case imageUrl, currency, discount, rate_percentage, price, old_price
        case desc = "description"
    }
}
