//
//  PlacementListModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 20.09.2023.
//

import Foundation
import Combine

final class PlacementListModel: ObservableObject, Equatable {
    private let service: FurnitureService
    
    @Published var items = [FurnitureModel]()
    
    private var disposeBag = [AnyCancellable]()
    
    init(service: FurnitureService) {
        self.service = service
        prepare()
    }
    
    deinit {
        disposeBag.forEach {
            $0.cancel()
        }
    }
    
    private func prepare() {
        service.visibleModelsPublisher
            .receive(on: RunLoop.main)
            .sink { items in
                self.items = items
            }
            .store(in: &disposeBag)
    }
    
    func title() -> String {
        "Visible Furnitures"
    }
    
    func subtitle() -> String {
        "Tap to delete"
    }
    
    func delete(_ model: FurnitureModel) async throws {
        try await service.deleteVisibleModel(model)
    }
    
    static func == (lhs: PlacementListModel, rhs: PlacementListModel) -> Bool {
        lhs.items == rhs.items
    }
}
