//
//  MoviesScreenView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import SwiftUI

struct MoviesScreenView: View {

    @ObservedObject var presenter: MoviesScreenPresenterImpl
    @State var offset: Int = 0

    var body: some View {
        GeometryReader { g in
            NavigationView {
                ScrollView {
                    HStack (spacing: 0) {
                        Spacer()
                        Image("imgNavBar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 30)
                        Spacer()
                    }.padding().ignoresSafeArea()
                        .background(Color.white)
                    LazyVStack {
                        if !presenter.listMovies.isEmpty {
                            ForEach (presenter.listMovies) { movie in

                                    NavigationLink(destination: MovieDetailCoordinator.shared.build(movie: movie)) {
                                        LazyVStack {
                                            CardMovieView(g: g, movie: movie)

                                        }
                                    }
                            }
                            if offset == presenter.listMovies.count {
                                ProgressView()
                                    .padding(.vertical)
                                    .onAppear {
                                        presenter.fetchDataFromPresente()

                                    }
                            }
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.2
                                if  minY < height {
                                    DispatchQueue.main.async {
                                        offset = presenter.listMovies.count

                                    }
                                }
                                return Color.clear
                            }

                        } else {
                            ProgressView()
                                .padding()
                        }
                    }

                }.frame(width: g.size.width, height: g.size.height)
                    .navigationBarHidden(true)

            }.onAppear {
                presenter.fetchDataFromPresente()
            }
        }
    }
}

struct MoviesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesScreenCoordinator.shared.build().previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
