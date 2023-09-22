//
//  AppContainer.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 20.09.2023.
//

import Foundation
import Swinject

extension Container {
    static let shared = Container(shouldRegisterServices: true)
    
    private convenience init(shouldRegisterServices: Bool) {
        self.init()
        
        if shouldRegisterServices {
            registerServices()
        }
    }
    
    private func registerServices() {
        register(FurnitureService.self) { _ in
            LocalFurnitureService()
        }
        .inObjectScope(.container)
        
        register(AppContentModel.self) { resolver in
            AppContentModel(service: resolver.furnitureService)
        }
        .inObjectScope(.container)
        
        register(ImmersiveModel.self) { resolver in
            ImmersiveModel(service: resolver.furnitureService)
        }
        
        register(FurnitureGroupsModel.self) { resolver in
            FurnitureGroupsModel(service: resolver.furnitureService)
        }
        
        register(PlacementListModel.self) { resolver in
            PlacementListModel(service: resolver.furnitureService)
        }
        
        register(FurnituresListModel.self) { resolver, group in
            FurnituresListModel(group: group, service: resolver.furnitureService)
        }
    }
}

extension Resolver {
    var furnitureService: FurnitureService {
        Container.shared.resolve(FurnitureService.self)!
    }
    
    var appModel: AppContentModel {
        Container.shared.resolve(AppContentModel.self)!
    }
    
    var immersiveModel: ImmersiveModel {
        Container.shared.resolve(ImmersiveModel.self)!
    }
    
    var groupsModel: FurnitureGroupsModel {
        Container.shared.resolve(FurnitureGroupsModel.self)!
    }
    
    var placementListModel: PlacementListModel {
        Container.shared.resolve(PlacementListModel.self)!
    }
    
    func listModel(for group: FurnituresGroup) -> FurnituresListModel {
        Container.shared.resolve(FurnituresListModel.self, argument: group)!
    }
}
