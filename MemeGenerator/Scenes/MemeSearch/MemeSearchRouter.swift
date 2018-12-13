//
//  MemeSearchRouter.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

@objc protocol MemeSearchRoutingLogic {
    func routeToErrorHandle(segue: UIStoryboardSegue?)
    func showErrorHandleScreen(type: Int)
}

protocol MemeSearchDataPassing {
    var dataStore: MemeSearchDataStore? { get }
}

class MemeSearchRouter: NSObject, MemeSearchRoutingLogic, MemeSearchDataPassing {
    weak var viewController: MemeSearchViewController?
    var dataStore: MemeSearchDataStore?
    
    var errorHandleViewController: ErrorHandleViewController?
    
    // MARK: Routing
    
    func routeToErrorHandle(segue: UIStoryboardSegue?) {
        if let errorHandleViewController = segue?.destination as? ErrorHandleViewController {
            self.errorHandleViewController = errorHandleViewController
        }
    }
    
    func showErrorHandleScreen(type: Int) {
        errorHandleViewController?.requestUIInformation(type: ErrorHandle.ProblemType(rawValue: type)!)
        viewController?.errorHandleContainerView.isHidden = false
    }
}
