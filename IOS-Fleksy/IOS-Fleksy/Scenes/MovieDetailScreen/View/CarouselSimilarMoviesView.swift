//
//  CarouselSimilarMoviesView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 19/4/22.
//

import SwiftUI

struct CarouselSimilarMoviesView: View {

    @ObservedObject var cardPresenter = CardManagerPresenter()
    let g: GeometryProxy
    let movie: Movie

    init (g:GeometryProxy, movie: Movie) {
        self.movie = movie
        self.g = g
        if let url = movie.posterPath {
            cardPresenter.getImage(contextUrl: url)
        }

    }

    var body: some View {

        HStack (alignment: .center, spacing: 0) {
        if let img = UIImage(data: cardPresenter.data) {
                VStack {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .frame(width: (g.size.width/2) / 2, height: g.size.height * 0.25)
                    .shadow(color: Color.black.opacity(0.4), radius: 15, x: 0, y: 10)
                    Text(movie.name ?? "")
                        .font(.caption2)
                }

            }
        }
    }
}

struct CarouselSimilarMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            CarouselSimilarMoviesView(g: g, movie: Movie(posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg", id: 1234, name: "Título de la película", voteAverage: 8.33048))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
        }
    }

}


