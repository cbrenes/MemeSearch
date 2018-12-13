//
//  AlamofireHelper.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHelper {
    
    static let timeOut = 30.0
    
    class func createRequest(parameters: Parameters?, requestPath: String, httpMethod: HTTPMethod) -> URLRequest? {
        guard let requestURL = URL(string: requestPath) else {
            return nil
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = timeOut
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        return request
    }
    
}
