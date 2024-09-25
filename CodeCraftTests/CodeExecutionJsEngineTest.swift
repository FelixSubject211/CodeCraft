//
//  CodeExecutionJsEngineTest.swift
//  CodeCraftTests
//
//  Created by Felix Fischer on 21.09.24.
//

import XCTest
import Combine
@testable import CodeCraft

final class CodeExecutionJsEngineTest: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    var sut: CodeExecutionEngine!
    
    override func setUpWithError() throws {
        sut = CodeExecutionJsEngine()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        cancellables.removeAll()
    }

    func testExecuteValidCode() throws {
        let expectation = XCTestExpectation(description: "Execution of valid JavaScript code")
        
        sut.output.assertReceivedOutput(
            expectation: expectation,
            validateOutput: { (result: CodeExecutionEngineResult, receivedCount: Int) in
                XCTAssertEqual(receivedCount, 1)
                XCTAssertEqual(result.output, "Expected Output")
                XCTAssertFalse(result.isFailure)
            }
        ).store(in: &cancellables)
        
        sut.execute(code: "console.log(\"Expected Output\");")
        
        wait(for: [expectation], timeout: 0.5)
    }
}



