//
//  NavigationStackIPadOSView.swift
//  CodeCraft
//
//  Created by Felix Fischer on 23.09.24.
//

import Foundation
import SwiftUI
import SplitView

struct NavigationStackIPadOSView: View {
    @StateObject var router: IPadOSRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            HSplit(
                left: { 
                    NavigationView {
                        CodeEditorFactory.create()
                    }.navigationViewStyle(StackNavigationViewStyle())
                },
                right: { 
                    NavigationView {
                        CodeOutputFactory.create()
                    }.navigationViewStyle(StackNavigationViewStyle())
                }
            )
            .constraints(minPFraction: 0.2, minSFraction: 0.2)
            .navigationDestination(for: RouteDestination.self) { route in
                switch(route) {
                case .codeOutputIfIOS:
                    fatalError("Can't push codeOutput on iPad because iPad has different layout")
                }
            }
        }
    }
}
