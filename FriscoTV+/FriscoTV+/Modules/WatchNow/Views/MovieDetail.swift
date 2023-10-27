//
//  MovieDetail.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/25/23.
//

import SwiftUI

struct MovieDetail: View {
    @Binding var showDetail: Bool
    @Binding var currentMovie: Movie?
    
    let namespace: Namespace.ID
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ZStack {
                        Image(.elemental)
                            .resizable()
                            .scaledToFill()
                            .frame(height: geo.size.height * 0.80)
                            .matchedGeometryEffect(id: currentMovie?.backdropPath, in: namespace)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    showDetail.toggle()
                                    currentMovie = nil
                                    
                            }
                        }
                    }
                    Text(currentMovie?.title ?? "")
                        .foregroundStyle(.primary)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .matchedGeometryEffect(id: currentMovie?.title, in: namespace)
                    Text(currentMovie?.releaseDate ?? "")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                        .lineLimit(2, reservesSpace: true)
                        .matchedGeometryEffect(id: currentMovie?.id, in: namespace)
                }
            }
            .transition(.identity)
            .ignoresSafeArea()
            .containerRelativeFrame(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(.white)
                    .frame(height: showDetail ? geo.size.height : nil)
                    .opacity(showDetail ? 1 : 0)
            }
        }
    }
}

//#Preview {
//    MovieDetail(showDetail: .constant(true), currentMovie: nil)
//}
