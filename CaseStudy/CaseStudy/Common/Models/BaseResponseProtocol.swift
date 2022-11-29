//
//  BaseResponseProtocol.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import Foundation


protocol BaseResponseProtocol: Codable {
    var isSuccess:Bool { get set }
    var message:String?  { get set }
    var statusCode:String  { get set }
}
