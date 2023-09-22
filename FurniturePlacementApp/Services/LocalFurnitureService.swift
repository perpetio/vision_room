//
//  LocalFurnitureService.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 20.09.2023.
//

import Foundation
import RealityKit

final class LocalFurnitureService: FurnitureService, ObservableObject {
    enum Error: String, LocalizedError {
        case emptyModel = "Model is empty"
        
        var errorDescription: String? { rawValue }
    }
    
    var recentlySelectedItemPublisher: Published<[FurnitureItem]>.Publisher {
        $recentlySelectedItems
    }
    
    var visibleModelsPublisher: Published<[FurnitureModel]>.Publisher {
        $visibleModels
    }
    
    var activeModelPublisher: Published<FurnitureModel?>.Publisher {
        $activeModel
    }
    
    @Published private var recentlySelectedItems = [FurnitureItem]()
    @Published private var visibleModels = [FurnitureModel]()
    @Published private var activeModel: FurnitureModel?
    
    func getGroups() async throws -> [FurnituresGroup] {
        [
            FurnituresGroup(name: "Recently Viewed", icon: "clock", type: .recentlyViewed),
            FurnituresGroup(name: "Table", icon: "table.furniture", type: .table),
            FurnituresGroup(name: "Chair", icon: "chair", type: .chair),
            FurnituresGroup(name: "Sofa", icon: "sofa", type: .sofa),
            FurnituresGroup(name: "Wardrobe", icon: "rectangle.lefthalf.inset.filled", type: .wardrobe)
        ]
    }
    
    func getFurnitures(for group: FurnituresGroup) async throws -> [FurnitureItem] {
        switch group.type {
        case .recentlyViewed:
            return recentlySelectedItems
        case .table:
            return tableItems()
        case .chair:
            return chairItems()
        case .sofa:
            return sofaItems()
        case .wardrobe:
            return wardrobeItems()
        }
    }
    
    func getFurniture(for item: FurnitureItem) async throws -> FurnitureModel {
        let entity = try await ModelEntity(named: item.fileName)
        
        guard let model = await entity.model else {
            throw Error.emptyModel
        }
        
        let bounds = await model.mesh.bounds.extents
        await entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
        await entity.components.set(HoverEffectComponent())
        await entity.components.set(InputTargetComponent())
        
        return FurnitureModel(item: item, model: entity)
    }
    
    func didStartViewing(item: FurnitureItem) async throws {
        if let index = recentlySelectedItems.firstIndex(where: { $0.id == item.id }) {
            recentlySelectedItems.remove(at: index)
        }
        
        recentlySelectedItems.insert(item, at: 0)
        
        let model = try await getFurniture(for: item)
        visibleModels.append(model)
        
        activeModel = model
    }
    
    func deleteVisibleModel(_ model: FurnitureModel) async throws {
        guard let index = visibleModels.firstIndex(where: { $0.id == model.id }) else {
            return
        }
        
        visibleModels.remove(at: index)
        
        if activeModel?.id == model.id {
            activeModel = visibleModels.last
        }
    }
    
    private func tableItems() -> [FurnitureItem] {
        [
            FurnitureItem(title: "Wood Table", subtitle: "1.699,00 €", icon: "wood_background_cover", fileName: "table_wood", scale: 175),
            FurnitureItem(title: "Dining Table", subtitle: "2.199,00 €", icon: "dining_table_cover", fileName: "table_dining", scale: 0.5)
        ]
    }
    
    private func chairItems() -> [FurnitureItem] {
        [
            FurnitureItem(title: "Swan Chair", subtitle: "899,00 €", icon: "swan_chair_cover", fileName: "chair_swan", scale: 1),
            FurnitureItem(title: "Bar Chair", subtitle: "299,00 €", icon: "bar_chair_cover", fileName: "chair_bar", scale: 1),
            FurnitureItem(title: "Rest Chair", subtitle: "499,00 €", icon: "rest_chair_cover", fileName: "chair_rest", scale: 0.8)
        ]
    }
    
    private func sofaItems() -> [FurnitureItem] {
        [
            FurnitureItem(title: "Sofa #1", subtitle: "2799,00 €", icon: "sofa_1_cover", fileName: "sofa_1", scale: 1),
            FurnitureItem(title: "Sofa #2", subtitle: "1599,00 €", icon: "sofa_2_cover", fileName: "sofa_2", scale: 0.4),
            FurnitureItem(title: "Sofa #3", subtitle: "1399,00 €", icon: "sofa_3_cover", fileName: "sofa_3", scale: 0.4),
            FurnitureItem(title: "Sofa #4", subtitle: "2199,00 €", icon: "sofa_4_cover", fileName: "sofa_4", scale: 0.4)
        ]
    }
    
    private func wardrobeItems() -> [FurnitureItem] {
        [
            FurnitureItem(title: "Loft Wardrobe", subtitle: "699,00 €", icon: "loft_wardrobe_cover", fileName: "wardrobe_loft", scale: 1),
            FurnitureItem(title: "Low Poly Wardrobe", subtitle: "499,00 €", icon: "low_poly_wardrobe_cover", fileName: "wardrobe_low_poly", scale: 0.4)
        ]
    }
}
