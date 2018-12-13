//
//  MemesWorkerTests.swift
//  MemeGeneratorTests
//
//  Created by Cesar Brenes on 12/9/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import XCTest

class MemesWorkerTests: XCTestCase {
    
    var worker: MemesWorker!
    static var testMemes: [Meme]!

    override func setUp() {
        setupMemesWorker()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func setupMemesWorker() {
        worker = MemesWorker(store: MemesMemory())
        worker.fetchMemes(searchCriteria: "") { (memes, _) in
            MemesWorkerTests.testMemes = memes
        }
    }
    
    class MemesMemorySpy: MemesMemory {
        var fetchedMemesCalled = false
        
        override func fetchMemes(searchCriteria: String, completionHandler: @escaping ([Meme], ServiceError?) -> Void) {
            fetchedMemesCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(MemesWorkerTests.testMemes, nil)
            }
        }
    }
    
    func testFetchMemesShouldReturnListOfMemes() {
        //Given
        let memesMemorySpy = MemesMemorySpy()
        worker.store = memesMemorySpy
        
        //When
        var fetchedMemes = [Meme]()
        let expect = expectation(description: "Wait for fetchMemes() to return")
        worker.fetchMemes(searchCriteria: "") { (memes, _) in
            fetchedMemes = memes!
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        XCTAssert(memesMemorySpy.fetchedMemesCalled, "Calling fetchMemes() should ask the data store for a list of memes")
        XCTAssertEqual(fetchedMemes.count, MemesWorkerTests.testMemes.count, "fetchMemes() should return a list of memes")
        for meme in fetchedMemes {
            XCTAssert(MemesWorkerTests.testMemes.contains(where: {$0.imageID == meme.imageID}), "Fetched memes should match the meme in the data store")
        }
    }
}
