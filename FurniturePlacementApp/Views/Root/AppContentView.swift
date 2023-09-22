//
//  AppContentView.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 11.09.2023.
//

import SwiftUI
import Swinject

struct AppContentView: View {
    @ObservedObject var model: AppContentModel = Container.shared.appModel
    
    let groups = FurnitureGroupsView()
    let placement = PlacementListView()

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        TabView(selection: $model.selectedTab) {
            TabItemView(view: libraryView, tab: .library)
            TabItemView(view: placementView, tab: .placement)
        }
        .frame(
            width: model.size.width,
            height: model.size.height,
            alignment: model.size.alignment
        )
        .task {
            model.prepare()
            
            if model.immersiveSpaceIsShown {
                return
            }
            
            switch await openImmersiveSpace(id: "solarSystem") {
            case .opened:
                model.didShowImmersiveSpace()
                
            case .error, .userCancelled:
                fallthrough
                
            @unknown default:
                model.didHideImmersiveSpace()
            }
        }
    }
    
    @ViewBuilder
    private var libraryView: some View {
        NavigationSplitView {
            groups
        } detail: {
            
        }
    }
    
    @ViewBuilder
    private var placementView: some View {
        placement
    }
}

struct TabItemView<ContentView: View>: View {
    let view: ContentView
    let tab: ContentTab
    
    var body: some View {
        view
            .tabItem {
                Label(tab.title, systemImage: tab.icon)
            }
            .tag(tab)
    }
}

#Preview {
    AppContentView()
}
