//
//  MemeSearchPresenterTests.swift
// MemeSearchTests
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import XCTest

class MemeSearchPresenterTests: XCTestCase {
    
    var presenter: MemeSearchPresenter!

    override func setUp() {
        setupMemeSearchPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func setupMemeSearchPresenter() {
        presenter = MemeSearchPresenter()
    }
    
    class MemeSearchDisplayLogicSpy: MemeSearchDisplayLogic {
        var displayDataSourceWithDataCalled = false
        var displayDataSourceWithoutDataCalled = false
        
        var viewModelWithData: MemeSearch.DataSource.ViewModel.WithData!
        var viewModelWithoutData: MemeSearch.DataSource.ViewModel.WithoutData!
        
        func displayDataSourceWithData(viewModel: MemeSearch.DataSource.ViewModel.WithData) {
            displayDataSourceWithDataCalled = true
            viewModelWithData = viewModel
        }
        
        func displayDataSourceWithoutData(viewModel: MemeSearch.DataSource.ViewModel.WithoutData) {
            displayDataSourceWithoutDataCalled = true
            viewModelWithoutData = viewModel
        }
    }
    
    func testPresentDataSourceShouldAskViewControllerToDisplayDataSourceWithData() {
        // Given
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        // When
        let dataSource = MemesMemory.happyMemes()
        let response = MemeSearch.DataSource.Response.init(errorFound: nil, memeList: dataSource)
        presenter.presentDataSource(response: response)
        // Then
        XCTAssert(memeSearchDisplayLogicSpy.displayDataSourceWithDataCalled)
    }
    
    func testPresentDataSourceShouldAskViewControllerToDisplayDataSourceWithoutData() {
        // Given
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        // When
        let response = MemeSearch.DataSource.Response.init(errorFound: ServiceError.internet, memeList: [Meme]())
        presenter.presentDataSource(response: response)
        // Then
        XCTAssert(memeSearchDisplayLogicSpy.displayDataSourceWithoutDataCalled)
    }
    
    func testPresentDataSourceWithDataShouldFormatTheCorrectData() {
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        
        // When
        let dataSource = MemesMemory.getOnehappyMeme()
        let response = MemeSearch.DataSource.Response.init(errorFound: nil, memeList: dataSource)
        presenter?.presentDataSource(response: response)
        
        // Then
        let displayedMemes = memeSearchDisplayLogicSpy.viewModelWithData.displayedMemes
        let url = URL(string: "https://memegenerator.net/img/images/8689594.jpg")!
        for displayedMeme in displayedMemes {
            XCTAssertEqual(displayedMeme.name, "Craig would be so happy")
            XCTAssertEqual(displayedMeme.url, url)
        }
    }
    
    func testPresentDataSourceWithoutDataShouldFormatTheCorrectDataInternetProblems() {
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        
        // When
        let response = MemeSearch.DataSource.Response.init(errorFound: ServiceError.internet, memeList: [Meme]())
        presenter?.presentDataSource(response: response)
        
        // Then
        let type = memeSearchDisplayLogicSpy.viewModelWithoutData.type
        XCTAssertEqual(type, ErrorHandle.ProblemType.internetProblems)
    }
    
    func testPresentDataSourceWithoutDataShouldFormatTheCorrectDataServerProblems() {
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        
        // When
        let response = MemeSearch.DataSource.Response.init(errorFound: ServiceError.server, memeList: [Meme]())
        presenter?.presentDataSource(response: response)
        
        // Then
        let type = memeSearchDisplayLogicSpy.viewModelWithoutData.type
        XCTAssertEqual(type, ErrorHandle.ProblemType.serverProblems)
    }
    
    func testPresentDataSourceWithoutDataShouldFormatTheCorrectDataNoData() {
        let memeSearchDisplayLogicSpy = MemeSearchDisplayLogicSpy()
        presenter.viewController = memeSearchDisplayLogicSpy
        
        // When
        let response = MemeSearch.DataSource.Response.init(errorFound: ServiceError.noData, memeList: [Meme]())
        presenter?.presentDataSource(response: response)
        
        // Then
        let type = memeSearchDisplayLogicSpy.viewModelWithoutData.type
        XCTAssertEqual(type, ErrorHandle.ProblemType.noData)
    }

}
