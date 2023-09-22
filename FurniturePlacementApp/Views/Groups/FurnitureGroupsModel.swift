//
//  FurnitureGroupsModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 14.09.2023.
//

import Foundation

final class FurnitureGroupsModel: ObservableObject {
    private let service: FurnitureService
    
    @Published var groups = [FurnituresGroup]()
    @Published var selectedGroup: FurnituresGroup?
    
    init(service: FurnitureService) {
        self.service = service
    }
    
    func load() async throws {
        let groups = try await service.getGroups()
        
        await MainActor.run {
            self.groups = groups
            self.selectedGroup = groups.first(where: { group in
                group.type != .recentlyViewed
            })
        }
    }
    
    func selectGroup(_ group: FurnituresGroup) {
        selectedGroup = group
    }
}
