//
//  MovieCard.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/15/23.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            // Loading images asynchronously using AsyncImage for now
            // Not sure on the performance of this based on other third party libraries
            // Such as Nuke, Alamofire, and Kingfisher or caching capabilities
            AsyncImage(url: movie.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(.rect(cornerRadius: 10, style: .continuous))
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(height: 200)
                        .foregroundStyle(.white)
                    ProgressView()
                        .controlSize(.large)
                }
            }
            Text(movie.title)
                .foregroundStyle(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Text(movie.releaseDate)
                .foregroundStyle(.secondary)
                .font(.title3)
                .lineLimit(2, reservesSpace: true)
        }
        .containerRelativeFrame(.horizontal)
    }
}

/// The button style that handles animating the size of the content
///
/// Using styles makes configuring button more reusable 
struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut.speed(1.3), value: configuration.isPressed)
    }
}

#Preview("Movie Card") {
    MovieCard(movie: .sample)
}
