//
//  MemeSearchInteractorTests.swift
// MemeSearchTests
//
//  Created by Cesar Brenes on 12/8/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//
import XCTest

class MemeSearchInteractorTests: XCTestCase {

    var interactor: MemeSearchInteractor!
    
    override func setUp() {
        super.setUp()
        setupMemeSearchInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupMemeSearchInteractor() {
        interactor = MemeSearchInteractor()
    }
    
    class MemeSearchPresentationLogicSpy: MemeSearchPresentationLogic {
        
        var presentedDataSourceCalled = false
        
        func presentDataSource(response: MemeSearch.DataSource.Response) {
            presentedDataSourceCalled = true
        }
    }
    
    class MemesWorkerSpy: MemesWorker {
        var fetchMemesCalled = false
        
        override func fetchMemes(searchCriteria: String, completionHandler:@escaping([Meme], ServiceError?) -> Void) {
            fetchMemesCalled = true
            completionHandler(MemesMemory.happyMemes(), nil)
        }
    }
    
    func testDataSourceShouldAskMemesWorkerToFetchMemesAndPresenterToFormatResult() {
        // Given
        let memeSearchPresentationLogicSpy = MemeSearchPresentationLogicSpy()
        interactor.presenter = memeSearchPresentationLogicSpy
        let memesWorkerSpy = MemesWorkerSpy(store: MemesMemory())
        interactor.memesWorker = memesWorkerSpy
        
        // When
        let request = MemeSearch.DataSource.Request()
        interactor.requestDataSource(request: request)
        
        // Then
        XCTAssert(memesWorkerSpy.fetchMemesCalled)
        XCTAssert(memeSearchPresentationLogicSpy.presentedDataSourceCalled)
    }
}
