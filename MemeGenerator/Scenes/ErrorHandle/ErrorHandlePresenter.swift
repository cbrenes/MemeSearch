//
//  ErrorHandlePresenter.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

protocol ErrorHandlePresentationLogic {
    func presentUIInformation(response: ErrorHandle.UIInformation.Response)
}

class ErrorHandlePresenter: ErrorHandlePresentationLogic {
    weak var viewController: ErrorHandleDisplayLogic?
    
    // MARK: presenter logic
    func presentUIInformation(response: ErrorHandle.UIInformation.Response) {
        var image: UIImage?
        var title: String
        switch response.type {
        case .internetProblems:
            image = R.image.internetProblems()
            title = R.string.localizable.checkYourInternetConnection()
        case .noData:
            image = R.image.notFound()
            title = R.string.localizable.theServerDoesnTHaveInformationForThisCriteria()
        case .serverProblems:
            image = R.image.serverProblems()
            title = R.string.localizable.theServerHasProblems()
        }
        viewController?.displayUIInformation(viewModel: ErrorHandle.UIInformation.ViewModel.init(image: image, title: title))
    }
}
