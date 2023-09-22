//
//  FurnitureView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import SwiftUI
import RealityKit

struct FurnitureView: View {
    @State var content: FurnitureModel
    
    var body: some View {
        RealityView { value in
            let entity = content.entity
            let anchor = AnchorEntity()
            anchor.addChild(entity)
            value.add(anchor)
        }
        .gesture(
            DragGesture()
                .targetedToEntity(content.entity)
                .onChanged { value in
                    content.drag(with: value)
                }
                .onEnded { _ in
                    content.dragEnded()
                }
        )
        .gesture(
            RotateGesture()
                .targetedToEntity(content.entity)
                .onChanged { value in
                    content.rotate(with: value)
                }
                .onEnded { _ in
                    content.rotateEnded()
                }
        )
    }
}
