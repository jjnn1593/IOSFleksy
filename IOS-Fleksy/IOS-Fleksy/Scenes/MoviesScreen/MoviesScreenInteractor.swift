//
//  MoviesScreenInteractor.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenInteractorProtocol: InteractorPresenterProtocol {
    func fetchDataMoviesFromProvider()
}

final class MoviesScreenInteractorImpl: BaseInteractorProtocol {

    weak var presenter: MoviesScreenPresenterProtocol?
    var provider: MoviesProviderProtocol? = FactoryProviderImpl().createProviderRepository(baseUrl: Constants.RepositoryConfig.baseUrl) as? MoviesProviderProtocol
}

extension MoviesScreenInteractorImpl: MoviesScreenInteractorProtocol {
    internal func fetchDataMoviesFromProvider() {

        provider?.loadMovies(page: 1, completionHadler: { result in
            switch result {
            case.failure(_):
                print("Return error to presenter")
                break
            case.success(let movieResponse):
                self.presenter?.getDataMovies(movies: movieResponse.movies ?? [Movie]())
            }

        })

    }

}
