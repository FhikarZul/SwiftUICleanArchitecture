//
//  SwiftUICleanArchitectureApp.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import SwiftUI

@main
struct SwiftUICleanArchitectureApp: App {
    
    private var initDI = InitDepedencyInjection()
    
    var body: some Scene {
        WindowGroup {
            TodoView()
        }
    }
}
