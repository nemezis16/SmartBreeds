//
//  NetworkManager.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Osadchuk. All rights reserved.
//

import UIKit

enum NetworkResult<Type> {
    case Success(Type)
    case Failure(Error)
}

typealias ResponseHandler = (NetworkResult<Any>)->Swift.Void

class NetworkManager {
    
    static let shared = NetworkManager()
    fileprivate lazy var session = { () -> URLSession in 
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: configuration)
    }()
    
//MARK: - Methods
    
    func get(request: URLRequest, responseHandler: ResponseHandler?) {
        session.dataTask(with: request.url!) { (data, response, error) in
            guard data != nil else {
                DispatchQueue.main.async {
                    if let error = error {
                        responseHandler?(.Failure(error))
                    } else {
                        print("Data and error == nil")
                    }
                }
                return
            }
            
            do {
                let decoded = try JSONSerialization.jsonObject(with: data!, options: [])
                DispatchQueue.main.async {
                    responseHandler?(.Success(decoded))
                }
            } catch {
                DispatchQueue.main.async {
                    responseHandler?(.Success(data as Any))
                }
            }
        }.resume()
    }
  
}
