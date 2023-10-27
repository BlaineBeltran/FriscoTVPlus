//
//  StretchableHeader.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/16/23.
//

import SwiftUI

struct StretchableHeaderContainer<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            content().stretchable(in: geometry)
        }
    }
}

private extension View {
    
    @ViewBuilder
    func stretchable(in geo: GeometryProxy) -> some View {
        let width = geo.size.width
        let height = geo.size.height
        let minY = geo.frame(in: .global).minY
        let useStandard = minY <= 0
        self.frame(width: width, height: height + (useStandard ? 0 : minY))
            .offset(y: useStandard ? 0 : -minY)
    }
}
