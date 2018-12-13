//
//  MemesMemory.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation

class MemesMemory: MemesStoreProtocol {
    
    class func happyMemes() -> [Meme] {
        return [Meme(imageID: 8689594, displayName: "Craig would be so happy", imageUrl: "https://memegenerator.net/img/images/8689594.jpg", ranking: 1),
                Meme(imageID: 212278, displayName: "Happy Birthday Panda", imageUrl: "https://memegenerator.net/img/images/212278.jpg", ranking: 2),
                Meme(imageID: 578936, displayName: "Happy Forever Alone", imageUrl: "https://memegenerator.net/img/images/578936.jpg", ranking: 3),
                Meme(imageID: 578936, displayName: "HAPPY KITTEN", imageUrl: "https://memegenerator.net/img/images/1167066.jpg", ranking: 4),
                Meme(imageID: 9186754, displayName: "I would be so happy Craig", imageUrl: "https://memegenerator.net/img/images/9186754.jpg", ranking: 5)]
        
    }
    
    class func getOnehappyMeme() -> [Meme] {
        return [Meme(imageID: 8689594, displayName: "Craig would be so happy", imageUrl: "https://memegenerator.net/img/images/8689594.jpg", ranking: 1)]
    }

    func fetchMemes(searchCriteria: String, completionHandler: @escaping ([Meme]?, ServiceError?) -> Void) {
        completionHandler(MemesMemory.happyMemes(), nil)
    }
}
