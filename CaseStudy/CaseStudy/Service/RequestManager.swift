//
//  RequestManager.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import Foundation

class RequestManager: NSObject {
    
    func loginWith(email:String, password:String, completed: @escaping (Result<LoginModel, Error>) -> Void) {
        ServiceManager.callRequest(apiMethod: "login.json") { result in
            completed(result)
        }
    }
    
    func getFirstList(completed: @escaping (Result<ProductList, Error>) -> Void) {
        ServiceManager.callRequest(apiMethod: "discover_first_horizontal_list.json") { result in
            completed(result)
        }
    }
    
    func getSecondList(completed: @escaping (Result<ProductList, Error>) -> Void) {
        ServiceManager.callRequest(apiMethod: "discover_second_horizontal_list.json") { result in
            completed(result)
        }
    }
    
    func getThirdList(completed: @escaping (Result<ProductList, Error>) -> Void) {
        ServiceManager.callRequest(apiMethod: "discover_thirth_two_column_list.json") { result in
            completed(result)
        }
    }
    
}
