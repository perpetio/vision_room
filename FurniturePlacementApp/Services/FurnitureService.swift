//
//  FurnitureService.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import Foundation

protocol FurnitureService: AnyObject {
    var recentlySelectedItemPublisher: Published<[FurnitureItem]>.Publisher { get }
    var visibleModelsPublisher: Published<[FurnitureModel]>.Publisher { get }
    var activeModelPublisher: Published<FurnitureModel?>.Publisher { get }
    
    func getGroups() async throws -> [FurnituresGroup]
    func getFurnitures(for group: FurnituresGroup) async throws -> [FurnitureItem]
    func getFurniture(for item: FurnitureItem) async throws -> FurnitureModel
    func didStartViewing(item: FurnitureItem) async throws
    func deleteVisibleModel(_ model: FurnitureModel) async throws
}
