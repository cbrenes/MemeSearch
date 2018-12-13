//
//  MemesWorker.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import Foundation

class MemesWorker {
    var store: MemesStoreProtocol
    
    init(store: MemesStoreProtocol) {
        self.store = store
    }
    
    func fetchMemes(searchCriteria: String, completionHandler:@escaping([Meme]?, ServiceError?) -> Void) {
        store.fetchMemes(searchCriteria: searchCriteria) { (memes, error) in
            DispatchQueue.main.async {
               completionHandler(memes, error)
            }
        }
    }
    
}

protocol MemesStoreProtocol {
    func fetchMemes(searchCriteria: String, completionHandler:@escaping([Meme]?, ServiceError?) -> Void)
}
