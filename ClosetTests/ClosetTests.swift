//
//  ClosetTests.swift
//  ClosetTests
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import XCTest
@testable import Closet

class ClosetTests: XCTestCase {

    var sut: URLSession!
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let promise = expectation(description: "Status code: 200")
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                XCTFail("Error \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
