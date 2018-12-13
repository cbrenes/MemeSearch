//
//  MemeSearchViewController.swift
// MemeSearch
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright (c) 2018 César Brenes. All rights reserved.
//
import UIKit
import JGProgressHUD

protocol MemeSearchDisplayLogic: class {
    func displayDataSourceWithData(viewModel: MemeSearch.DataSource.ViewModel.WithData)
    func displayDataSourceWithoutData(viewModel: MemeSearch.DataSource.ViewModel.WithoutData)
}

class MemeSearchViewController: UIViewController, MemeSearchDisplayLogic {
    var interactor: MemeSearchBusinessLogic?
    var router: (NSObjectProtocol & MemeSearchRoutingLogic & MemeSearchDataPassing)?
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchCriteria: UITextField!
    @IBOutlet weak var errorHandleContainerView: UIView!
    @IBOutlet weak var searchButtonOutlet: UIButton! {
        didSet {
            searchButtonOutlet.setTitleColor(UIColor.white, for: .normal)
            searchButtonOutlet.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
        }
    }
    
    private let activityIndicator = JGProgressHUD(style: .dark)
    fileprivate let heightForRow: CGFloat = 226.0
    fileprivate let heightForHeader: CGFloat = 0.01
    var displayedMemes: [MemeSearch.DataSource.ViewModel.WithData.DisplayedMeme] = []
    
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
        let interactor = MemeSearchInteractor()
        let presenter = MemeSearchPresenter()
        let router = MemeSearchRouter()
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
        registerCustomCell()
        requestDataSource(searchCriteria: searchCriteria.text)
        searchButtonOutlet.setTitle(R.string.localizable.search(), for: .normal)
        searchButtonOutlet.setTitle(R.string.localizable.search(), for: .disabled)
        title = R.string.localizable.memeSearch()
    }
    
    // MARK: Request logic
    func requestDataSource(searchCriteria: String?) {
        activityIndicator.textLabel.text = R.string.localizable.loading()
        activityIndicator.show(in: self.view)
        let request = MemeSearch.DataSource.Request.init(searchCriteria: searchCriteria)
        interactor?.requestDataSource(request: request)
    }
    
    // MARK: Display logic
    func displayDataSourceWithData(viewModel: MemeSearch.DataSource.ViewModel.WithData) {
        errorHandleContainerView?.isHidden = true
        activityIndicator.dismiss()
        displayedMemes = viewModel.displayedMemes
        tableView.reloadData()
    }
    
    func displayDataSourceWithoutData(viewModel: MemeSearch.DataSource.ViewModel.WithoutData) {
        activityIndicator.dismiss()
        router?.showErrorHandleScreen(type: viewModel.type.rawValue)
    }
    
    // MARK: Actions logic
    @IBAction func searchAction(_ sender: Any) {
        view.endEditing(true)
        requestDataSource(searchCriteria: searchCriteria.text)
    }
    
    @IBAction func searchCriteriaChangedAction(_ sender: UITextField) {
        if let text = sender.text, text.isEmpty {
            searchButtonOutlet.isEnabled = false
        } else {
            searchButtonOutlet.isEnabled = true
        }
    }
}

extension MemeSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCustomCell() {
        tableView.register(UINib(resource: R.nib.memeSearchTableViewCell), forCellReuseIdentifier: R.nib.memeSearchTableViewCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMemes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.memeSearchTableViewCell.name) as? MemeSearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(displayedMeme: displayedMemes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}
