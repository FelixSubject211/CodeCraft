//
//  CodeExecutionJsEngine.swift
//  CodeCraft
//
//  Created by Felix Fischer on 21.09.24.
//

import Foundation
import JavaScriptCore
import Combine

class CodeExecutionJsEngine: CodeExecutionEngine {
    private var currentId: UUID?
    var output = PassthroughSubject<CodeExecutionEngineResult, Never>()

    func execute(code: String) {
        let executionId = UUID()
        currentId = executionId
        
        Task {
            let context = JSContext()!

            let consoleLog: @convention(block) (String, String) -> Void = { [weak self] message, id in
                guard let self = self else { return }
                guard executionId == self.currentId else { return }
                
                let output = CodeExecutionEngineResult(
                    output: message,
                    date: Date(),
                    status: .success
                )
                self.output.send(output)
            }
            
            context.setObject(consoleLog, forKeyedSubscript: "consoleLog" as (NSCopying & NSObjectProtocol)?)
            
            context.evaluateScript("""
                var console = {
                    log: function(message) {
                        consoleLog(message, '\(executionId.uuidString)');
                    }
                };
            """)
            
            context.exceptionHandler = { [weak self] context, exception in
                guard let self = self else { return }
                guard executionId == self.currentId else { return }
                
                let lineNumber = exception?.objectForKeyedSubscript("line")
                let errorMessage = exception?.description ?? "Unknown error"
                
                let output = CodeExecutionEngineResult(
                    output: errorMessage,
                    date: Date(),
                    status: .failure(lineNumber: Int(lineNumber!.toString())!)
                )
                self.output.send(output)
            }
            
            context.evaluateScript(code)
        }
    }
}
