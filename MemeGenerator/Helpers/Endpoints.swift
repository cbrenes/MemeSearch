//
//  Endpoints.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "http://version1.api.memegenerator.net//Generators_Search?q="
    static let apiKey: [UInt8] = [63, 40, 8, 2]
    static let pageIndex = "&pageIndex=0&pageSize=20&apiKey="
}

struct EndPoints {
    static func getTracksURL(searchCriteria: String) -> String? {
        let encrypter = Obfuscator(withSalt: [AppDelegate.self, NSObject.self, NSString.self])
        let urlString = "\(API.baseUrl)\(searchCriteria)\(API.pageIndex)\(encrypter.reveal(key: API.apiKey))"
        guard let urlValidated = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return nil
        }
        return urlValidated
    }
}
