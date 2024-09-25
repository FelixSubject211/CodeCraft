//
//  CodeExecutionRepository.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation
import Combine

protocol CodeExecutionRepository {
    var output: AnyPublisher<[CodeExecutionRepositoryResultItem], Never> { get }
    
    func execute(code: String)
}

struct CodeExecutionRepositoryResultItem {
    enum Status {
        case success
        case failure(lineNumber: Int)
    }
    
    let output: String
    let date: Date
    let status: Status
}
