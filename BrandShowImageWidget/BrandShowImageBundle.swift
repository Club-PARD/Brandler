//
//  BrandShowImageBundle.swift
//  BrandShowImage
//
//  Created by 정태주 on 7/5/25.
//

import WidgetKit
import SwiftUI

@main
struct BrandShowImageBundle: WidgetBundle {
    var body: some Widget {
        BrandShowImage()
        BrandShowImageControl()
        BrandShowImageLiveActivity()
    }
}
