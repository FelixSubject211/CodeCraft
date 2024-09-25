//
//  Subject+AssertReceivedOutput.swift
//  CodeCraftTests
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation
import Combine
import XCTest

extension Subject {
    func assertReceivedOutput(expectation: XCTestExpectation, validateOutput: ((Output, Int) -> Void)? = nil) -> AnyCancellable {
        var receivedCount = 0
        return self.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            case .finished:
                XCTFail("Unexpected finish")
            }
            expectation.fulfill()
        }, receiveValue: { value in
            receivedCount += 1
            if let validateOutput = validateOutput {
                validateOutput(value, receivedCount)
                expectation.fulfill()
            } else {
                XCTFail("Unexpected output: \(value)")
            }
        })
    }
}
