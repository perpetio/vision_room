//
//  FurnitureGroupsView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 13.09.2023.
//

import SwiftUI
import Swinject

struct FurnitureGroupsView: View {
    @ObservedObject var model: FurnitureGroupsModel = Container.shared.groupsModel
    
    var body: some View {
        List(model.groups) { item in
            Button(action: {
                model.selectGroup(item)
            }) {
                Label(item.name, systemImage: item.icon)
                    .foregroundStyle(.primary)
            }
        }
        .navigationDestination(item: $model.selectedGroup, destination: { group in
            FurnituresListView(model: Container.shared.listModel(for: group))
        })
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                VStack (alignment: .leading) {
                    Text("Library")
                        .font(.largeTitle)
                    
                    Text("All Items")
                        .foregroundStyle(.tertiary)
                }
                .padding(.all, 8)
            }
        }
        .task {
            do {
                try await model.load()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    FurnitureGroupsView()
}
