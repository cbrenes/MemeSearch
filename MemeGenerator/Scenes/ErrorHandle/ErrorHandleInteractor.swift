//
//  ErrorHandleInteractor.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

protocol ErrorHandleBusinessLogic {
    func requestUIInformation(request: ErrorHandle.UIInformation.Request)
}

protocol ErrorHandleDataStore {
}

class ErrorHandleInteractor: ErrorHandleBusinessLogic, ErrorHandleDataStore {
    var presenter: ErrorHandlePresentationLogic?
    
    func requestUIInformation(request: ErrorHandle.UIInformation.Request) {
        presenter?.presentUIInformation(response: ErrorHandle.UIInformation.Response.init(type: request.type))
    }
}
