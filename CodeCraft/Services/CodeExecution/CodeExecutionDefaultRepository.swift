//
//  CodeExecutionDefaultRepository.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation
import Combine

class CodeExecutionDefaultRepository: CodeExecutionRepository {
    private let engine: CodeExecutionEngine
    private var cancellables = Set<AnyCancellable>()
    
    @Published private var outputValue: [CodeExecutionRepositoryResultItem] = []
    
    var output: AnyPublisher<[CodeExecutionRepositoryResultItem], Never> {
        $outputValue.eraseToAnyPublisher()
    }
    
    init(engine: CodeExecutionEngine) {
        self.engine = engine
        setupBindings()
    }
    
    func execute(code: String) {
        outputValue = []
        engine.execute(code: code)
    }
    
    private func setupBindings() {
        engine.output
            .sink { result in
                status: switch(result.status) {
                case .success:
                    self.outputValue = self.outputValue + [CodeExecutionRepositoryResultItem(
                        output: result.output,
                        date: result.date,
                        status: .success
                    )]
                case .failure(lineNumber: let lineNumber):
                    self.outputValue = self.outputValue + [CodeExecutionRepositoryResultItem(
                        output: result.output,
                        date: result.date,
                        status: .failure(lineNumber: lineNumber)
                    )]
                }
            }
            .store(in: &cancellables)
    }
}
