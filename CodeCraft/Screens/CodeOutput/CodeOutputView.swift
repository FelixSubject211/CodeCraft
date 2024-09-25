//
//  CodeOutputView.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import SwiftUI

struct CodeOutputView: View {
    @StateObject var viewModel: CodeOutputViewModel
    private let bottomID = "bottom"
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.output, id: \.date) { outputItem in
                        Text("\(timeFormatter.string(from: outputItem.date)): \(outputItem.output)")
                            .font(.system(.footnote, design: .rounded))
                            .cornerRadius(8)
                            .background {
                                if (outputItem.isFailure) {
                                    Color.red.opacity(0.1)
                                }
                            }
                    }
                    Color.clear
                        .frame(height: 1)
                        .id(bottomID)
                }
                .padding()
                .onChange(of: viewModel.output) { _, _ in
                    withAnimation {
                        proxy.scrollTo(bottomID, anchor: .top)
                    }
                }
            }
        }
        .navigationBarTitle("Output", displayMode: .inline)
    }
}
