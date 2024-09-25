//
//  CodeCraftApp.swift
//  CodeCraft
//
//  Created by Felix Fischer on 21.09.24.
//

import SwiftUI

@main
struct CodeCraftApp: App {
    
    init() {
        let engine = CodeExecutionJsEngine()
        let repository = CodeExecutionDefaultRepository(engine: engine)
        
        DependencyInjector.register(engine as CodeExecutionEngine)
        DependencyInjector.register(repository as CodeExecutionRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStackFactory.create()
        }
    }
}
