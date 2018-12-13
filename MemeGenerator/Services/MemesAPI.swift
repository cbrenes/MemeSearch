//
//  MemesAPI.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation
import Alamofire

class MemesAPI: MemesStoreProtocol {
    
    func fetchMemes(searchCriteria: String, completionHandler: @escaping ([Meme]?, ServiceError?) -> Void) {
        guard let isNetWorkReachable = NetworkReachabilityManager()?.isReachable else {
            completionHandler(nil, ServiceError.unknown)
            return
        }
        if isNetWorkReachable {
            makeFetchMemesAPICall(searchCriteria: searchCriteria, completionHandler: completionHandler)
        } else {
            completionHandler(nil, ServiceError.internet)
        }
    }
    
    private func makeFetchMemesAPICall(searchCriteria: String, completionHandler:@escaping([Meme]?, ServiceError?) -> Void) {
        if let requestPath = EndPoints.getTracksURL(searchCriteria: searchCriteria), let request = AlamofireHelper.createRequest(parameters: nil, requestPath: requestPath, httpMethod: .get) {
            Alamofire.request(request).responseJSON { (response) in
                if let jsonData = response.result.value as? [String: Any], let memes = jsonData[APIKeys.Main.result] as? [[String: Any]] {
                    let answer = memes.map({Meme.init(dictionary: $0)}).sorted(by: {$0.ranking < $1.ranking})
                    var errorFound: ServiceError?
                    if answer.isEmpty {
                        errorFound = ServiceError.noData
                    }
                    completionHandler(answer, errorFound)
                } else {
                    completionHandler(nil, ServiceError.server)
                }
            }
        } else {
            completionHandler(nil, ServiceError.badURL)
        }
    }
    
}
