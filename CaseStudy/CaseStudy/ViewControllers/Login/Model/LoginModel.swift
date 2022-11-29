//
//  LoginModel.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import Foundation


class LoginModel:BaseResponseProtocol {
    @DecodableDefault.False var isSuccess: Bool
    var message: String?
    @DecodableDefault.EmptyString var statusCode: String
}
