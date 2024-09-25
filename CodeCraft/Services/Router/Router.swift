//
//  Router.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation

protocol Router {
    func push(_ destionation: RouteDestination)
}

enum RouteDestination: Hashable {
    case codeOutputIfIOS
}
