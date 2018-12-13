//
//  ErrorHandleRouter.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

@objc protocol ErrorHandleRoutingLogic {
    
}

protocol ErrorHandleDataPassing {
    var dataStore: ErrorHandleDataStore? { get }
}

class ErrorHandleRouter: NSObject, ErrorHandleRoutingLogic, ErrorHandleDataPassing {
    weak var viewController: ErrorHandleViewController?
    var dataStore: ErrorHandleDataStore?
    
}
