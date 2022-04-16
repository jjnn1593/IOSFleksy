//
//  MoviesScreenPresenter.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenPresenterProtocol: PresenterInteractorProtocol {
    func getDataMovies(movies: [Movie])
}

final class MoviesScreenPresenterImpl: BasePresenteProtocol, ObservableObject {

    var interactor: MoviesScreenInteractorProtocol?
    @Published var listMovies: [Movie] = []

    func fetchDataFromPresente() {
        self.interactor?.fetchDataMoviesFromProvider()
    }
}

extension MoviesScreenPresenterImpl: MoviesScreenPresenterProtocol {
    func getDataMovies(movies: [Movie]) {
        listMovies.append(contentsOf: movies)
    }

    
}
