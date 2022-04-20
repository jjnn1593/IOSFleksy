//
//  MovieDetailPresenter.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 19/4/22.
//

import Foundation

protocol MovieDetailPresenterProtocol: PresenterInteractorProtocol {
    func getDataMoviesSimilar(movies: [Movie])
    func getDetailMovie(detailMovie: DetailMovie)
    func getImageMovie(data: Data)
}

final class MovieDetailPresenter: BasePresenteProtocol, ObservableObject {

    @Published var detailsMovie: DetailMovie?
    @Published var imageDetailMovie: Data = Data()
    @Published var similarMovies: [Movie] = []

    var interactor: MovieDetailInteractor?
    var movieSelected: Movie

    init (movie: Movie) {
        self.movieSelected = movie
    }

    func getDataMovieSelected() {
        if let idMovie = movieSelected.id {
            interactor?.fechtDetailMovie(id: idMovie)
        }
    }

    func getImageMovieSelected() {
        if let url = movieSelected.posterPath {
            interactor?.fetchImageDetailMovie(url: url)
        }
    }

    func getSimilarMovieSelected() {

        if  let idMovie = movieSelected.id {
            interactor?.fetchSimilarMovies(page: 1, id: idMovie)

        }
    }

}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func getImageMovie(data: Data) {
        self.imageDetailMovie = data
    }

    func getDetailMovie(detailMovie: DetailMovie) {
        self.detailsMovie = detailMovie
    }

    func getDataMoviesSimilar(movies: [Movie]) {
        self.similarMovies.append(contentsOf: movies)
    }

}
