//
//  ImmersiveView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import SwiftUI
import RealityKit
import Swinject

struct ImmersiveView: View {
    @ObservedObject var model: ImmersiveModel = Container.shared.immersiveModel
    
    var body: some View {
        contentView
            .task {
                model.prepare()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if !model.objects.isEmpty {
            ZStack {
                ForEach(model.objects) {
                    FurnitureView(content: $0)
                }
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    ImmersiveView()
}
