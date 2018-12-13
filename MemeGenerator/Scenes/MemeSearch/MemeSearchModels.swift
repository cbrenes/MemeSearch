//
//  MemeSearchModels.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

enum MemeSearch {
    
    // MARK: Use cases
    enum DataSource {
        struct Request {
            var searchCriteria: String?
        }
        struct Response {
            var errorFound: ServiceError?
            var memeList: [Meme]?
        }
        struct ViewModel {
            struct WithData {
                struct DisplayedMeme {
                    var name: String
                    var url: URL?
                    var defaultImage: UIImage?
                }
                var displayedMemes: [DisplayedMeme]
            }
            struct WithoutData {
                var type: ErrorHandle.ProblemType
            }
        }
    }
}
