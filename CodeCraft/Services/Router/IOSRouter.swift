//
//  DefaultRouter.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Foundation
import SwiftUI

class IOSRouter: Router, ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ destionation: RouteDestination) {
        path.append(destionation)
    }
}
