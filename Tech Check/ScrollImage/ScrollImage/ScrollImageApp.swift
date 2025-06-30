//
//  ScrollImageApp.swift
//  ScrollImage
//
//  Created by 정태주 on 6/28/25.
//

import SwiftUI

@main
struct ScrollImageApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollThumbPreview()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
