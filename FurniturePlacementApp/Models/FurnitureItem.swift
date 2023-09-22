//
//  FurnitureItem.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 13.09.2023.
//

import Foundation

struct FurnitureItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let fileName: String
    let scale: Float
}
