//
//  ImmersiveModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 14.09.2023.
//

import Foundation
import Combine

final class ImmersiveModel: ObservableObject {
    private let service: FurnitureService
    
    @Published var objects = [FurnitureModel]()
    @Published var selectedObject: FurnitureModel?
    
    private var disposeBag = [AnyCancellable]()
    
    init(service: FurnitureService) {
        self.service = service
    }
    
    deinit {
        disposeBag.forEach {
            $0.cancel()
        }
    }
    
    func prepare() {
        service.visibleModelsPublisher
            .receive(on: RunLoop.main)
            .sink { objects in
                self.objects = objects
            }
            .store(in: &disposeBag)
        
        service.activeModelPublisher
            .receive(on: RunLoop.main)
            .sink { object in
                self.selectedObject = object
            }
            .store(in: &disposeBag)
    }
}
