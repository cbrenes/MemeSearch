//
//  ErrorHandlePresenterTests.swift
//  MemeGeneratorTests
//
//  Created by Cesar Brenes on 12/9/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import XCTest

class ErrorHandlePresenterTests: XCTestCase {
    
    var presenter: ErrorHandlePresenter!

    override func setUp() {
        setupErrorHandlePresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupErrorHandlePresenter() {
        presenter = ErrorHandlePresenter()
    }
    
    class ErrorHandleDisplayLogicSpy: ErrorHandleDisplayLogic {
        
        var displayUIInformationCalled = false
        var viewModel: ErrorHandle.UIInformation.ViewModel!
        
        func displayUIInformation(viewModel: ErrorHandle.UIInformation.ViewModel) {
            displayUIInformationCalled = true
            self.viewModel = viewModel
        }
    }
    
    func testPresentUIInformationShouldAskViewControllerToDisplayUIInformation() {
        //Given
        let errorHandleDisplayLogicSpy = ErrorHandleDisplayLogicSpy()
        presenter.viewController = errorHandleDisplayLogicSpy
        //When
        let response = ErrorHandle.UIInformation.Response.init(type: .internetProblems)
        presenter.presentUIInformation(response: response)
        //Then
        XCTAssert(errorHandleDisplayLogicSpy.displayUIInformationCalled)
    }
    
    func testPresentUIInformationWithCorrectFormatInternetProblemsCase() {
        //Given
        let errorHandleDisplayLogicSpy = ErrorHandleDisplayLogicSpy()
        presenter.viewController = errorHandleDisplayLogicSpy
        
        //When
        let response = ErrorHandle.UIInformation.Response.init(type: .internetProblems)
        presenter.presentUIInformation(response: response)
        
        //Then
        let viewModel = errorHandleDisplayLogicSpy.viewModel
        XCTAssertEqual(viewModel?.image, R.image.internetProblems())
        XCTAssertEqual(viewModel?.title, R.string.localizable.checkYourInternetConnection())
    }
    
    func testPresentUIInformationWithCorrectFormatServerProblemsCase() {
        //Given
        let errorHandleDisplayLogicSpy = ErrorHandleDisplayLogicSpy()
        presenter.viewController = errorHandleDisplayLogicSpy
        
        //When
        let response = ErrorHandle.UIInformation.Response.init(type: .serverProblems)
        presenter.presentUIInformation(response: response)
        
        //Then
        let viewModel = errorHandleDisplayLogicSpy.viewModel
        XCTAssertEqual(viewModel?.image, R.image.serverProblems())
        XCTAssertEqual(viewModel?.title, R.string.localizable.theServerHasProblems())
    }
    
    func testPresentUIInformationWithCorrectFormatNoDataCase() {
        //Given
        let errorHandleDisplayLogicSpy = ErrorHandleDisplayLogicSpy()
        presenter.viewController = errorHandleDisplayLogicSpy
        
        //When
        let response = ErrorHandle.UIInformation.Response.init(type: .noData)
        presenter.presentUIInformation(response: response)
        
        //Then
        let viewModel = errorHandleDisplayLogicSpy.viewModel
        XCTAssertEqual(viewModel?.image, R.image.notFound())
        XCTAssertEqual(viewModel?.title, R.string.localizable.theServerDoesnTHaveInformationForThisCriteria())
    }
}
