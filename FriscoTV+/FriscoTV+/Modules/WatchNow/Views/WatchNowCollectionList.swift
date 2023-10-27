//
//  WatchNowCollectionList.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/14/23.
//

import SwiftUI
import OSLog

struct WatchNowCollectionList:  View {
    @Environment(\.colorScheme) var colorScheme
    // This does not scale well if we are going to be calling a lot
    // of APIs. This could grow quickly, consider using a viewModel for this
    @State var comingSoonMovies: [Movie] = []
    @State var popularMovies: [Movie] = []
    @State var topRatedMovies: [Movie] = []
    @State var isChecked = false
    @State var offsetY = 0.0
    @State var opacity = 0.0
    
    let watchNowLogger = Logger()
  
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    headerView(geometry: geometry)
                    section(movies: comingSoonMovies)
                    section(movies: popularMovies)
                    section(movies: topRatedMovies)
                }
                .overlay {
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 100)
                                .foregroundStyle(.thinMaterial)
                            Text("Watch Now")
                                .font(.callout)
                                .fontWeight(.bold)
                                .offset(y: -10)
                                .foregroundStyle(.primary)
                        }
                        .offset(y: -minY)
                        .opacity(opacity)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()
            .navigationDestination(for: Int.self) { num in
                Text("\(num)")
            }
            .background {
                ScrollViewDetector { offset in
                    if offset > 100 {
                        opacity = Double(offset * 2) / Double(900)
                    } else {
                        opacity = 0
                    }
                }
            }
            .task {
                let comingSoonService = ComingSoonMovieService()
                let popularService = PopularMoviesService()
                let topRatedService = TopRatedMovieService()
                do {
                    async let comingSoonResults = comingSoonService.fetchComingSoonMovies()
                    async let popularResults = popularService.fetchPopularMovies(page: 2)
                    async let topRatedResuts = topRatedService.fetchTopRatedMovies()
                    await comingSoonMovies = try comingSoonResults.results
                    await popularMovies = try popularResults.results
                    await topRatedMovies = try topRatedResuts.results
                } catch {
                    watchNowLogger.error("\(error)")
                }
            }
        }
    }
    
    
    @ViewBuilder
    func headerView(geometry: GeometryProxy) -> some View {
        StretchableHeaderContainer {
            ZStack(alignment: .top) {
                TabView {
                    Group {
                        Image(.elemental).resizable()
                        Image(.kimsConvienence).resizable()
                        Image(.starWardRogueOne).resizable()
                        Image(.kungFuPanda).resizable()
                        Image(.lionKing).resizable()
                        Image(.starWarsRiseOfSkyWalker).resizable()
                    }
                    .scaledToFill()
                    .overlay {
                        LinearGradient(colors: [.black.opacity(0.2), .clear, .black.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    }
                }
                FloatingHeader(isChecked: $isChecked)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: geometry.size.height * 0.80)
        .containerRelativeFrame(.horizontal)
        .listRowInsets(EdgeInsets())
    }
    
    @ViewBuilder
    func section(movies: [Movie]) -> some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    // for each card in a specific category
                    ForEach(movies) { movie in
                        Button(action: {
                            // Nothing really just use a navigation link
                        }, label: {
                            MovieCard(movie: movie)
                        })
                        .buttonStyle(ScaledButtonStyle())
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(20, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
        } header: {
            // custom header view
            MovieSectionHeaderView()
                .offset(x: 20)
        }
    }
}

struct WatchNowCollectionListView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WatchNowCollectionList()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
                .previewDisplayName("\(UIDevice.current.name)")
        }
    }
}
