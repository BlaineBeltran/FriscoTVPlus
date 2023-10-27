//
//  MovieSectionHeaderView.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/16/23.
//

import SwiftUI

struct MovieSectionHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Main header title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
            Text("Subtitle")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MovieSectionHeaderView()
}
