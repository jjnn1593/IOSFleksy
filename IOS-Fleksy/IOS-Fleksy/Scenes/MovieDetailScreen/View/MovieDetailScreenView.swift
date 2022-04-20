//
//  MovieDetailScreenView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 19/4/22.
//

import SwiftUI

struct MovieDetailScreenView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var presenter: MovieDetailPresenter
    @State var offset: Int = 0

    var body: some View {
        GeometryReader { g in
            ScrollView {
                ZStack(alignment: .top) {
                    Color.clear
                    if presenter.imageDetailMovie.isEmpty {

                        Rectangle()
                            .fill(Color.gray)
                            .aspectRatio( contentMode: .fill)
                            .overlay(
                                ProgressView("Loading")
                                    .font(.title)

                            )

                    } else if let img = UIImage(data: presenter.imageDetailMovie) {

                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                    }

                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()

                        }, label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.white.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 20))

                        })
                        Spacer()

                    }
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                }
                VStack {
                    Group {
                        Text(presenter.detailsMovie?.originalName ?? "...")
                            .font(.title2)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                            .padding(.leading, 15)
                            .frame(maxWidth: .infinity, alignment: .center)
                        HStack() {
                            Spacer()
                            Image(systemName: "star.fill").foregroundColor(.yellow)

                            Text(String(format:"%.1f", presenter.detailsMovie?.voteAverage ?? 0.0))
                                .font(.subheadline)
                                .foregroundColor(Color.gray)

                        }.padding(.trailing, 30)
                        Divider()

                    }
                    Group {
                        Text("Description")
                            .font(.title3)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                            .padding(.leading, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(presenter.detailsMovie?.overview ?? "...")
                            .font(.subheadline)
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                    }

                    Group {

                        Text("Similar Tv Shows")
                            .font(.title3)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                            .padding(.leading, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)

                    }

                    ScrollView (.horizontal, showsIndicators: false) {
                       LazyHStack {
                            if  !presenter.similarMovies.isEmpty  {
                                ForEach (presenter.similarMovies) { movie in
                                        LazyVStack {

                                            CarouselSimilarMoviesView(g: g, movie: movie)
                                                    .padding(.trailing, 20)
                                        }
                                }

                            } else {
                                ProgressView()
                            }
                        }.frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)

                    }
                    .padding(.bottom, 100)
                }
            }

            .navigationBarHidden(true)
            .background(Color.white)
            .ignoresSafeArea(edges: [.top,.bottom])

        }.onAppear {
            presenter.getDataMovieSelected()
            presenter.getImageMovieSelected()
            presenter.getSimilarMovieSelected()

        }

    }

}

struct MovieDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreenView(presenter: MovieDetailPresenter(movie: Movie(posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg", id: 1234, name: "Título de la película", voteAverage: 8.33048)))
    }
}
