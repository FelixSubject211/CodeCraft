//
//  CodeExecutionEngine.swift
//  CodeCraft
//
//  Created by Felix Fischer on 21.09.24.
//

import Foundation
import Combine

protocol CodeExecutionEngine {
    var output: PassthroughSubject<CodeExecutionEngineResult, Never> { get }
    func execute(code: String)
}

struct CodeExecutionEngineResult {
    enum Status {
        case success
        case failure(lineNumber: Int)
    }
    
    let output: String
    let date: Date
    let status: Status
}
