//
//  FurnituresListModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 14.09.2023.
//

import Foundation

final class FurnituresListModel: ObservableObject, Equatable {
    private let group: FurnituresGroup
    private let service: FurnitureService
    
    @Published var items = [FurnitureItem]()
    @Published var selectedItem: FurnitureModel?
    
    init(group: FurnituresGroup, service: FurnitureService) {
        self.group = group
        self.service = service
    }
    
    func load() async throws {
        let items = try await service.getFurnitures(for: group)
        
        await MainActor.run {
            self.items = items
        }
    }
    
    func title() -> String {
        "Furnitures"
    }
    
    func subtitle() -> String {
        items.isEmpty ? "~" : "\(items.count) items"
    }
    
    func startViewing(_ item: FurnitureItem) async throws {
        try await service.didStartViewing(item: item)
    }
    
    static func == (lhs: FurnituresListModel, rhs: FurnituresListModel) -> Bool {
        lhs.group.id == rhs.group.id
    }
}
