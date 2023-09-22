//
//  PlacementListView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 13.09.2023.
//

import SwiftUI
import Swinject

struct PlacementListView: View {
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 200))]
    
    @ObservedObject var model: PlacementListModel = Container.shared.placementListModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 24) {
                    ForEach(model.items) { model in
                        Button(action: {
                            Task {
                                do {
                                    try await self.model.delete(model)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }) {
                            VStack(alignment: .leading) {
                                Image(model.item.icon)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .scaledToFill()
                                    .cornerRadius(10)
                                    .hoverEffect()
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
                                
                                Text(model.item.title)
                                    .lineLimit(1)
                                
                                Text(model.item.subtitle)
                                    .foregroundStyle(.tertiary)
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(width: 160, height: 200)
                    }
                }
            }
            .padding(24)
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
        }
    }
}

#Preview {
    PlacementListView()
}
