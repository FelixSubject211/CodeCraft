//
//  NavigationStackFactory.swift
//  CodeCraft
//
//  Created by Felix Fischer on 24.09.24.
//

import SwiftUI

enum NavigationStackFactory {
    static func create() -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let router = IPadOSRouter()
            DependencyInjector.register(router as Router)
            
            return AnyView(NavigationStackIPadOSView(router: router))
        } else {
            let router = IOSRouter()
            DependencyInjector.register(router as Router)
            
            return AnyView(NavigationStackIOSView(router: router))
        }
    }
}
