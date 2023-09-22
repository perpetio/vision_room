//
//  FurniturePlacementApp.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import SwiftUI
import Swinject

@main
struct FurniturePlacementApp: App {
    private var container: Container {
        .shared
    }
    
    var body: some Scene {
        WindowGroup {
            AppContentView()
        }
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: "solarSystem") {
            ImmersiveView()
        }
        .immersionStyle(
            selection: .constant(.mixed),
            in: .mixed
        )
    }
}
