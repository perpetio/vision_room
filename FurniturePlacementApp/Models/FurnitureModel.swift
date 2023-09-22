//
//  FurnitureModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import SwiftUI
import RealityKit

final class FurnitureModel: Identifiable, Hashable {
    var id: ObjectIdentifier {
        entity.id
    }
    
    let item: FurnitureItem
    let entity: ModelEntity
    private var startPosition: SIMD3<Float>?
    private var startRotation: simd_quatf?
    private(set) lazy var isChanged = false
    
    init(item: FurnitureItem, model: ModelEntity) {
        self.item = item
        
        entity = model
        entity.scale *= item.scale
        entity.position = SIMD3(0, 0, -2)
    }
    
    func drag(with value: EntityTargetValue<DragGesture.Value>) {
        guard let parent = entity.parent else {
            return
        }
        
        let startPosition = startPosition ?? entity.position
        self.startPosition = startPosition
        
        let delta = value.convert(
            value.translation3D,
            from: .local,
            to: parent
        )
        
        entity.position = startPosition + SIMD3(delta.x, 0, delta.z) // x and z positions only
        isChanged = true
    }

    func dragEnded() {
        startPosition = nil
    }

    func rotate(with value: EntityTargetValue<RotateGesture.Value>) {
        let startRotation = startRotation ?? entity.transform.rotation
        self.startRotation = startRotation
        
        let delta = simd_quatf(
            angle: Float(value.rotation.radians),
            axis: [0, 1, 0]
        )
        
        entity.transform.rotation = startRotation * delta
        isChanged = true
    }

    func rotateEnded() {
        startRotation = nil
    }
    
    static func == (lhs: FurnitureModel, rhs: FurnitureModel) -> Bool {
        lhs.entity == rhs.entity
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(entity)
    }
}
