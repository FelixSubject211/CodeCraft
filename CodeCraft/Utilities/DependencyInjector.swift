//
//  DependencyInjector.swift
//  CodeCraft
//
//  Created by Felix Fischer on 24.09.24.
//

class DependencyInjector {
    private static var dependencies: [String: AnyObject] = [:]

    static func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    static func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: T.self)
        guard let dependency = dependencies[key] as? T else {
            fatalError("No registered dependency for \(key)")
        }
        return dependency
    }
}
