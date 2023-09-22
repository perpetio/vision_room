//
//  FurnituresListView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 13.09.2023.
//

import SwiftUI
import Swinject

struct FurnituresListView: View {
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 200))]
    
    @ObservedObject var model: FurnituresListModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(model.items) { item in
                    Button(action: {
                        Task {
                            do {
                                try await model.startViewing(item)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }) {
                        VStack(alignment: .leading) {
                            Image(item.icon)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .scaledToFill()
                                .cornerRadius(10)
                                .hoverEffect()
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
                            
                            Text(item.title)
                                .lineLimit(1)
                            
                            Text(item.subtitle)
                                .foregroundStyle(.tertiary)
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 24)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                VStack (alignment: .leading) {
                    Text(model.title())
                        .font(.largeTitle)
                    
                    Text(model.subtitle())
                        .foregroundStyle(.tertiary)
                }
                .padding(.all, 8)
            }
        }
        .task(id: model) {
            do {
                try await model.load()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
