//
//  MoviesScreenInteractor.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenInteractorProtocol: InteractorPresenterProtocol {
    func fetchDataMoviesFromProvider(page: Int)
}

final class MoviesScreenInteractorImpl: BaseInteractorProtocol {

    weak var presenter: MoviesScreenPresenterProtocol?
    var providerMovies: MoviesProviderProtocol? = FactoryProviderImpl().createProviderRepository(baseUrl: Constants.RepositoryConfig.baseUrl, typeProvider: .MoviesProvider) as? MoviesProviderProtocol
}

extension MoviesScreenInteractorImpl: MoviesScreenInteractorProtocol {
    
    internal func fetchDataMoviesFromProvider(page: Int) {

        providerMovies?.loadMovies(id: nil, page: page, completionHadler: { result in
            switch result {
            case.failure(_):
                print("Retornar error hacia arriba al presenter...")
                break
            case.success(let movieResponse):
                self.presenter?.getDataMovies(movies: movieResponse.movies ?? [Movie](), page: movieResponse.page ?? 1, totalPage: movieResponse.totalPages ?? 10)
            }

        })
    }
}
