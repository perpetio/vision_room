//
//  FurnituresGroup.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 13.09.2023.
//

import Foundation

struct FurnituresGroup: Identifiable, Hashable {
    enum `Type` {
        case recentlyViewed, table, chair, sofa, wardrobe
    }
    
    let id = UUID()
    let name: String
    let icon: String
    let type: `Type`
}
