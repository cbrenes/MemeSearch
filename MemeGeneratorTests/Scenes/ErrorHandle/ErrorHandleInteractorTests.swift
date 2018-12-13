//
//  ErrorHandleInteractorTests.swift
//  MemeGeneratorTests
//
//  Created by Cesar Brenes on 12/9/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import XCTest

class ErrorHandleInteractorTests: XCTestCase {
    
    var interactor: ErrorHandleInteractor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupErrorHandleInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupErrorHandleInteractor() {
        interactor = ErrorHandleInteractor()
    }

    class ErrorHandlePresentationLogicSpy: ErrorHandlePresentationLogic {
        
        var presentUIInformationCalled = false
        
        func presentUIInformation(response: ErrorHandle.UIInformation.Response) {
            presentUIInformationCalled = true
        }
    }
    
    func testPresentUIInformation() {
        //Given
        let errorHandlePresentationLogicSpy = ErrorHandlePresentationLogicSpy()
        interactor.presenter = errorHandlePresentationLogicSpy
        
        //When
        let request = ErrorHandle.UIInformation.Request.init(type: .internetProblems)
        interactor?.requestUIInformation(request: request)
        
        //Then
        XCTAssert(errorHandlePresentationLogicSpy.presentUIInformationCalled)
    }
}
