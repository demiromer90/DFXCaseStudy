//
//  ServiceManager.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import Foundation
import UIKit

class ServiceManager: NSObject {
    
    private static let serviceCache = NSCache<AnyObject, AnyObject>()
    
    private static var session:URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession(configuration: config)
    }()
    
    
    //MARK: - API Request
    typealias performResponseHandler<T : BaseResponseProtocol> = Result<T, Error>
    
    
    static func callRequest<T:BaseResponseProtocol>(apiMethod:String, completed:@escaping (performResponseHandler<T>)->Void ) {
        let urlString = AppSettings.apiBaseUrl + apiMethod
        
        guard let url = URL(string: urlString) else {
            //URL Fail
            sessionCompleted(response: .failure(NSError(domain: "Generic Error".localized(), code: 0)), completed: completed)
            return
        }
        
        //Cache check
        if let cacheResponseData = serviceCache.object(forKey: url as AnyObject) as? Data {
            decodeData(url:url, responseData: cacheResponseData, completed: completed)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            //Error check
            if let err = error {
                sessionCompleted(response: .failure(err), completed: completed)
                return
            }
            
            //Response data check
            guard let responseData = data else {
                //Return Data Nil
                sessionCompleted(response: .failure(NSError(domain: "Generic Error".localized(), code: 0)), completed: completed)
                return
            }
            
            //Status code check
            if !(200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) {
                //Status Code Fail
                sessionCompleted(response: .failure(NSError(domain: "Generic Error".localized(), code: 0)), completed: completed)
                return
            }
            
            //Decoding
            decodeData(url:url, responseData: responseData, completed: completed)
            
        }
        task.resume()
        
    }
    
    private static func decodeData<T:BaseResponseProtocol>(url: URL, responseData:Data, completed: @escaping (performResponseHandler<T>)->Void) {
        let decoder = JSONDecoder()
        
        do {
            
            let decodeData = try decoder.decode(T.self, from: responseData)
            
            if decodeData.isSuccess == true {
                serviceCache.setObject(responseData as AnyObject, forKey: url as AnyObject)
                sessionCompleted(response: .success(decodeData), completed: completed)
            }else{
                sessionCompleted(response: .failure(NSError(domain: decodeData.message ?? "Generic Error".localized(), code: 0)), completed: completed)
            }
            
        }catch {
            //Decode Fail
            sessionCompleted(response: .failure(NSError(domain: "Generic Error".localized(), code: 0)), completed: completed)
        }
    }
    
    private static func sessionCompleted<T:BaseResponseProtocol>(response:performResponseHandler<T>, completed: @escaping (performResponseHandler<T>)->Void) {
        DispatchQueue.main.async {
            completed(response)
        }
    }
    
    
    
    //MARK: - Image Download
    static func downloadImageFrom(urlString:String, completed:@escaping (UIImage?)->Void ) {
        
        guard let url = URL(string: urlString) else {
            downloadImageCompleted(image: nil, completed: completed)
            return
        }
        
        //Cache check
        if let cacheResponseData = serviceCache.object(forKey: url as AnyObject) as? Data {
            decodeImage(url: url, responseData: cacheResponseData, completed: completed)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            //Response data check
            guard let responseData = data else {
                downloadImageCompleted(image: nil, completed: completed)
                return
            }
            
            //Decoding
            decodeImage(url: url, responseData: responseData, completed: completed)
            
        }
        task.resume()
    }
    
    private static func decodeImage(url: URL, responseData:Data, completed:@escaping (UIImage?)->Void) {
        if let image = UIImage(data: responseData) {
            serviceCache.setObject(responseData as AnyObject, forKey: url as AnyObject)
            downloadImageCompleted(image: image, completed: completed)
        }else{
            downloadImageCompleted(image: nil, completed: completed)
        }
    }
    
    private static func downloadImageCompleted(image:UIImage?, completed:@escaping (UIImage?)->Void) {
        DispatchQueue.main.async {
            completed(image)
        }
    }
}
