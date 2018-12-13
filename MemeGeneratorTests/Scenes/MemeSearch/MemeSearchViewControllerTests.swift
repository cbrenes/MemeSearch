//
//  MemeSearchViewControllerTests.swift
//  MemeGeneratorTests
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import XCTest

class MemeSearchViewControllerTests: XCTestCase {
    
    var viewController: MemeSearchViewController!
    var window: UIWindow!

    override func setUp() {
        window = UIWindow()
        setupMemeSearchViewController()
    }

    override func tearDown() {
        window = nil
    }
    
    func setupMemeSearchViewController() {
        if let controller = R.storyboard.memeSearch.instantiateInitialViewController()?.viewControllers.first as? MemeSearchViewController {
            viewController = controller
        }
    }

    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class MemeSearchBusinessLogicSpy: MemeSearchBusinessLogic {
        
        var requestDataSourceCalled = false
        
        func requestDataSource(request: MemeSearch.DataSource.Request) {
            requestDataSourceCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    func testShouldRequestDataSourceWhenViewDidLoad() {
        // Given
        let memeSearchBusinessLogicSpy = MemeSearchBusinessLogicSpy()
        viewController.interactor = memeSearchBusinessLogicSpy
        loadView()
        
        // When
        viewController.viewDidLoad()
        
        //Then
        XCTAssert(memeSearchBusinessLogicSpy.requestDataSourceCalled)
    }
    
    func testShouldDisplayDataSource() {
        // Given
        let tableViewSpy = TableViewSpy()
        viewController.tableView = tableViewSpy
        
        // When
        let displayedMemes = [MemeSearch.DataSource.ViewModel.WithData.DisplayedMeme.init(name: "Craig would be so happy", url: URL(string: "https://memegenerator.net/img/images/8689594.jpg"), defaultImage: R.image.imageNotAvailable())]
        let viewModel = MemeSearch.DataSource.ViewModel.WithData.init(displayedMemes: displayedMemes)
        viewController.displayDataSourceWithData(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled)
    }
    
    func testNumberOfRowsInAnySectionShouldBeEqualToNumberOfMemesToDisplay() {
        // Given
        let tableViewSpy = TableViewSpy()
        viewController.tableView = tableViewSpy
        let displayedMemes = [MemeSearch.DataSource.ViewModel.WithData.DisplayedMeme.init(name: "Craig would be so happy", url: URL(string: "https://memegenerator.net/img/images/8689594.jpg"), defaultImage: R.image.imageNotAvailable())]
        viewController.displayedMemes = displayedMemes
        
        // When
        let numberOfRows = viewController.tableView(viewController.tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, displayedMemes.count)
    }
}
