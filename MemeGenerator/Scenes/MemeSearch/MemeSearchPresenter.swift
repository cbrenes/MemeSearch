//
//  MemeSearchPresenter.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

protocol MemeSearchPresentationLogic {
    func presentDataSource(response: MemeSearch.DataSource.Response)
}

class MemeSearchPresenter: MemeSearchPresentationLogic {
    weak var viewController: MemeSearchDisplayLogic?
    
    // MARK: presenter logic
    func presentDataSource(response: MemeSearch.DataSource.Response) {
        guard let error = response.errorFound else {
            if let items = response.memeList {
                presentDataSourceWithoutError(items: items)
            } else {
                presentDataSourceWithError(error: .noData)
            }
            return
        }
        presentDataSourceWithError(error: error)
    }
    
    func presentDataSourceWithError(error: ServiceError) {
        var errorType: ErrorHandle.ProblemType
        switch error {
        case .badURL, .server, .unknown:
            errorType = ErrorHandle.ProblemType.serverProblems
        case .noData:
            errorType = ErrorHandle.ProblemType.noData
        case .internet:
            errorType = ErrorHandle.ProblemType.internetProblems
        }
        self.viewController?.displayDataSourceWithoutData(viewModel: MemeSearch.DataSource.ViewModel.WithoutData.init(type: errorType))
    }
    
    func presentDataSourceWithoutError(items: [Meme]) {
        self.viewController?.displayDataSourceWithData(viewModel: MemeSearch.DataSource.ViewModel.WithData.init(displayedMemes: items.map({MemeSearch.DataSource.ViewModel.WithData.DisplayedMeme.init(name: $0.displayName, url: URL(string: $0.imageUrl), defaultImage: R.image.imageNotAvailable())})))
    }
}
