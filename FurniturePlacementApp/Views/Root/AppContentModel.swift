//
//  AppContentModel.swift
//  FurniturePlacementApp
//
//  Created by Andrew Kochulab on 14.09.2023.
//

import SwiftUI
import Combine

enum ContentTab: Int {
    case library
    case placement
    
    var title: String {
        switch self {
        case .library: return "Library"
        case .placement: return "Placement"
        }
    }
    
    var icon: String {
        switch self {
        case .library: return "photo.fill"
        case .placement: return "house.fill"
        }
    }
}

struct ContentSize {
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    
    static var `default`: ContentSize {
        .init(width: 1200, height: 800, alignment: .center)
    }
}

final class AppContentModel: ObservableObject {
    private let service: FurnitureService
    
    @Published var selectedTab: ContentTab = .library
    @Published var size: ContentSize = .default
    
    @State var showImmersiveSpace = false
    @State var immersiveSpaceIsShown = false
    
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
        service.activeModelPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if value != nil {
                    self?.selectedTab = .placement
                }
            }
            .store(in: &disposeBag)
        
        $selectedTab
            .sink { [weak self] tab in
                switch tab {
                case .library:
                    self?.size = .default
                    
                case .placement:
                    self?.size = .init(width: 1200, height: 348, alignment: .bottom)
                }
            }
            .store(in: &disposeBag)
    }
    
    func didShowImmersiveSpace() {
        immersiveSpaceIsShown = true
    }
    
    func didHideImmersiveSpace() {
        immersiveSpaceIsShown = false
        showImmersiveSpace = false
    }
}
