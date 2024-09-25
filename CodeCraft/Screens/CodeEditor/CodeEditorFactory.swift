//
//  CodeEditorFactory.swift
//  CodeCraft
//
//  Created by Felix Fischer on 24.09.24.
//

import Foundation
import SwiftUI

enum CodeEditorFactory {
    static func create() -> some View {
        @Injected var router: Router
        @Injected var repository: CodeExecutionRepository

        let viewModel = CodeEditorViewModel(
            router: router,
            repository: repository
        )

        return CodeEditorView(viewModel: viewModel)
    }
}
