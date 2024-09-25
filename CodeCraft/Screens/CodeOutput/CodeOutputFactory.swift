//
//  CodeOutputFactory.swift
//  CodeCraft
//
//  Created by Felix Fischer on 24.09.24.
//

import SwiftUI

enum CodeOutputFactory {
    static func create() -> some View {
        @Injected var repository: CodeExecutionRepository

        let viewModel = CodeOutputViewModel(
            repository: repository
        )

        return CodeOutputView(viewModel: viewModel)
    }
}
