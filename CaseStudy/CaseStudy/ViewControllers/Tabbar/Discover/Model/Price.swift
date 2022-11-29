//
//  Price.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import Foundation


class Price: Codable {
    @DecodableDefault.EmptyString var currency:String
    @DecodableDefault.ZeroDouble var value:Double
    
    init(currency: String, value: Double) {
        self.currency = currency
        self.value = value
    }
}
