//
//  ServiceViewModelProtocol.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import Foundation


protocol ServiceViewModelProtocol: AnyObject {
    func serviceError(error:Error)
    func triggerSpinner(isShow:Bool)
}
