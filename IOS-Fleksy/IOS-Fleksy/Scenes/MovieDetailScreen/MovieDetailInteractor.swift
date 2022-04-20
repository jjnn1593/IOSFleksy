//
//  MovieDetailInteractor.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 19/4/22.
//

import Foundation

protocol MovieDetailInteractorProtocol: InteractorPresenterProtocol {
    func fechtDetailMovie(id: Int)
    func fetchImageDetailMovie(url: String)
    func fetchSimilarMovies(page: Int, id: Int)
}

final class MovieDetailInteractor: BaseInteractorProtocol {

    weak var presenter: MovieDetailPresenter?
    var providerMovies: MoviesProviderProtocol? = FactoryProviderImpl().createProviderRepository(baseUrl: Constants.RepositoryConfig.baseUrl, typeProvider: .MoviesProvider) as? MoviesProviderProtocol
    var providerImages: ImagesProvider? =  FactoryProviderImpl().createProviderRepository(baseUrl: Constants.RepositoryConfig.baseUrlImage, typeProvider: .ImagesProvider) as? ImagesProvider
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {

    func fetchSimilarMovies(page: Int, id: Int) {

        providerMovies?.loadMovies(id: id, page: page, completionHadler: { result in
            switch result {
            case.failure(_):
                print("Retornar error hacia arriba al presenter...")
                break
            case.success(let movieResponse):
                self.presenter?.getDataMoviesSimilar(movies: movieResponse.movies ?? [Movie]())
            }

        })
    }

    func fetchImageDetailMovie(url: String) {
        providerImages?.loadImage(contextUrl: url, completionHadler: { result in
            switch result {
            case.failure(_):
                print("Retornar error hacia arriba al presenter...")
                break
            case.success(let detailMovie):
                self.presenter?.getImageMovie(data: detailMovie)
            }
        })
    }

    func fechtDetailMovie(id: Int) {
        providerMovies?.getMovie(id: id, completionHadler: { result in
            switch result {
            case.failure(_):
                print("Retornar error hacia arriba al presenter...")
                break
            case.success(let detailMovie):
                self.presenter?.getDetailMovie(detailMovie: detailMovie)
            }
        })
    }
}
