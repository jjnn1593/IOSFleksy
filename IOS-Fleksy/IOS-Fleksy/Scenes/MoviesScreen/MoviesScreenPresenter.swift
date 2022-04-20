//
//  MoviesScreenPresenter.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenPresenterProtocol: PresenterInteractorProtocol {
    func getDataMovies(movies: [Movie], page: Int, totalPage: Int)
}

final class MoviesScreenPresenterImpl: BasePresenteProtocol, ObservableObject {

    @Published var listMovies: [Movie] = []
    @Published var imgMovie: Data = Data()

    var interactor: MoviesScreenInteractorProtocol?
    var page: Int?
    var totalPage: Int?
    var firstCall: Bool = true


    func fetchDataFromPresente() {
        if firstCall {
            interactor?.fetchDataMoviesFromProvider(page: 1)
            firstCall.toggle()
        } else if var page = page, let totalPage = totalPage, page < totalPage {
            page += 1
            interactor?.fetchDataMoviesFromProvider(page: page)
        }
    }
}

extension MoviesScreenPresenterImpl: MoviesScreenPresenterProtocol {

    func getDataMovies(movies: [Movie], page: Int, totalPage: Int) {
        self.page = page
        self.totalPage = totalPage
        self.listMovies.append(contentsOf: movies)

    }

    
}
