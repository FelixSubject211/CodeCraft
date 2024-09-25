//
//  IPadOSRouter.swift
//  CodeCraft
//
//  Created by Felix Fischer on 23.09.24.
//

import Foundation
import SwiftUI

class IPadOSRouter: Router, ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ destionation: RouteDestination) {}
}
