//
//  netflixApp.swift
//  netflix
//
//  Created by Josue Lubaki on 2024-04-29.
//

import SwiftUI
import SwiftfulRouting

@main
struct netflixApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                NetflixHomeView()
            }
        }
    }
}
