//
//  ErrorHandleViewController.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//

import UIKit

protocol ErrorHandleDisplayLogic: class {
    func displayUIInformation(viewModel: ErrorHandle.UIInformation.ViewModel)
}

class ErrorHandleViewController: UIViewController, ErrorHandleDisplayLogic {
    var interactor: ErrorHandleBusinessLogic?
    var router: (NSObjectProtocol & ErrorHandleRoutingLogic & ErrorHandleDataPassing)?

    // MARK: IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionMessageLabel: UILabel!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ErrorHandleInteractor()
        let presenter = ErrorHandlePresenter()
        let router = ErrorHandleRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Request logic
    func requestUIInformation(type: ErrorHandle.ProblemType) {
        let request = ErrorHandle.UIInformation.Request.init(type: type)
        interactor?.requestUIInformation(request: request)
    }
    
    // MARK: Display logic
    func displayUIInformation(viewModel: ErrorHandle.UIInformation.ViewModel) {
        iconImageView.image = viewModel.image
        descriptionMessageLabel.text = viewModel.title
    }
}
