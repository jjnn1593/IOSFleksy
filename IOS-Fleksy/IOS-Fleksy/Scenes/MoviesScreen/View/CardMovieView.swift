//
//  CardMovieView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 17/4/22.
//

import SwiftUI

struct CardMovieView: View {
    @ObservedObject var cardPresenter = CardManagerPresenter()
    let g: GeometryProxy
    let movie: Movie

    init( g: GeometryProxy, movie: Movie) {
        self.g = g
        self.movie = movie
        if let contextUrl = movie.posterPath, cardPresenter.data.isEmpty {
            cardPresenter.getImage(contextUrl: contextUrl)
        }

    }

    var body: some View {

        HStack (spacing: 0) {
                if cardPresenter.data.isEmpty {
                    HStack (alignment:.firstTextBaseline, spacing: 0) {
                        ProgressView()

                    }.frame(width: (g.size.width/1.1) / 2, height: g.size.height / 2.5)

                } else if let img = UIImage(data: cardPresenter.data) {

                    HStack (alignment:.firstTextBaseline, spacing: 0) {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    }.frame(width: (g.size.width/1.1) / 2, height: g.size.height / 2.5)
                    .shadow(color: Color.black.opacity(0.4), radius: 15, x: 0, y: 10)

                }

                Spacer()

                VStack (alignment: .center, spacing: 0) {
                    Spacer()
                    Text(movie.name ?? "")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()

                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        Image(systemName: "star.fill").foregroundColor(.yellow)

                        Text(String(format:"%.1f", movie.voteAverage ?? 0.0))
                            .font(.subheadline)
                            .foregroundColor(Color.gray)

                    }.padding(.bottom, 20)

                }

                Spacer()

            }.frame(width: g.size.width/1.1, height: g.size.height / 2.5)
            .background(Color.clear)
                .padding()

    }

}

struct CardMovieView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            CardMovieView(g: g,movie: Movie(posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg", id: 1234, name: "Título de la película", voteAverage: 8.33048))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
        }
    }
    
}
