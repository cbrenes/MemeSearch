//
//  ErrorHandleModels.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

enum ErrorHandle {
    
    // MARK: Use cases
    enum UIInformation {
        struct Request {
            var type: ProblemType
        }
        struct Response {
            var type: ProblemType
        }
        struct ViewModel {
            var image: UIImage?
            var title: String
        }
    }
    
    enum ProblemType: Int {
        case internetProblems = 0, serverProblems, noData
    }
    
}
