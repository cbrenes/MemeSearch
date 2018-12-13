//
//  Meme.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation

struct Meme {
    var imageID: Int
    var displayName: String
    var imageUrl: String
    var ranking: Int
    
    init(dictionary: [String: Any]) {
        self.imageID = dictionary[APIKeys.Meme.imageID] as? Int ?? 0
        self.displayName = dictionary[APIKeys.Meme.displayName] as? String ?? ""
        self.imageUrl = dictionary[APIKeys.Meme.imageUrl] as? String ?? ""
        self.ranking = dictionary[APIKeys.Meme.raning] as? Int ?? 0
    }
    
    init(imageID: Int, displayName: String, imageUrl: String, ranking: Int) {
        self.imageID = imageID
        self.displayName = displayName
        self.imageUrl = imageUrl
        self.ranking = ranking
    }
}
