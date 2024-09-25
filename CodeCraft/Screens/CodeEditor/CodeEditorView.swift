//
//  CodeEditorView.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation
import SwiftUI
import LanguageSupport
import CodeEditorView

struct CodeEditorView: View {
    @StateObject var viewModel: CodeEditorViewModel
    
    var body: some View {
        ZStack {
            CodeEditor(
                text: $viewModel.code,
                position: $viewModel.position,
                messages: $viewModel.messages,
                language: LanguageConfiguration.javascript,
                layout: .init(showMinimap: false, wrapText: true)
            )
            
            Button(action: viewModel.executeCode) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .padding(.top)
        .navigationBarTitle("Editor", displayMode: .inline)
    }
}
