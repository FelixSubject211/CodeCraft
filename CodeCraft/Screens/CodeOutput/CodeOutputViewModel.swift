//
//  CodeOutputViewModel.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Combine
import Foundation

class CodeOutputViewModel: ObservableObject {
    @Published var output: [OutputItem] = []
    
    private let repository: CodeExecutionRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: CodeExecutionRepository) {
        self.repository = repository
        setupBindings()
    }

    private func setupBindings() {
        repository.output
            .receive(on: RunLoop.main)
            .sink { [weak self] output in
                self?.output = output.map {
                    switch ($0.status) {
                    case .success:
                        OutputItem(output: $0.output, date: $0.date, isFailure: false)
                    case .failure(lineNumber: let lineNumber):
                        OutputItem(output: $0.output, date: $0.date, isFailure: true)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    struct OutputItem: Equatable {
        let output: String
        let date: Date
        let isFailure: Bool
    }
}

