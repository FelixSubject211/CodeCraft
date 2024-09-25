//
//  NavigationView.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import SwiftUI

struct NavigationStackIOSView: View {
    @StateObject var router: IOSRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            CodeEditorFactory.create()
                .navigationDestination(for: RouteDestination.self) { route in
                    switch(route) {
                    case .codeOutputIfIOS: CodeOutputFactory.create()
                    }
                }
        }
    }
}
