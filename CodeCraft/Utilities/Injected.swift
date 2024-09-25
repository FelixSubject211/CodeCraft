//
//  Injected.swift
//  CodeCraft
//
//  Created by Felix Fischer on 24.09.24.
//

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = DependencyInjector.resolve(T.self)
    }
}
