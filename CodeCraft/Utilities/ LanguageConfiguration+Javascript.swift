//
//   LanguageConfiguration+Javascribt.swift
//  CodeCraft
//
//  Created by Felix Fischer on 23.09.24.
//

import Foundation
import LanguageSupport

extension LanguageConfiguration {
    static var javascript: LanguageConfiguration {
        LanguageConfiguration.init(
            name: "javascript",
            stringRegexp: "\"(?:\\\\.|[^\\\\\"])*\"|'(?:\\\\.|[^\\\\'])*'",
            characterRegexp: nil,
            numberRegexp: "\\b\\d+(?:\\.\\d+)?(?:[eE][+-]?\\d+)?\\b",
            singleLineComment: "//",
            nestedComment: LanguageConfiguration.BracketPair(open: "/*", close: "*/"),
            identifierRegexp: "\\b[a-zA-Z_$][a-zA-Z0-9_$]*\\b",
            reservedIdentifiers: [
                "break", "case", "catch", "class", "const", "continue", "debugger", "default", "delete",
                "do", "else", "export", "extends", "finally", "for", "function", "if", "import", "in",
                "instanceof", "new", "return", "super", "switch", "this", "throw", "try", "typeof",
                "var", "void", "while", "with", "yield", "let", "static", "enum", "await", "implements",
                "package", "protected", "interface", "private", "public", "null", "true", "false"
            ]
        )
    }
}
