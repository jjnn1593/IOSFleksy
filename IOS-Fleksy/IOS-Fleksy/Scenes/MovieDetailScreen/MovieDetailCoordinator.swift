//
//  MovieDetailCoordinator.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 19/4/22.
//

import Foundation

final class MovieDetailCoordinator: ModuleCoordinator {

    typealias ContentView = MovieDetailScreenView
    typealias Presenter = MovieDetailPresenter
    typealias Interactor = MovieDetailInteractor

    static var shared: MovieDetailCoordinator = {
        let instance = MovieDetailCoordinator()
        return instance
    }()


    func build(movie: Movie) -> ContentView {
        let presenter = Presenter(movie: movie)
        let interactor = Interactor()
        let view = ContentView(presenter: presenter)
        self.coordinator(presenter: presenter, interactor: interactor)
        return view
    }
}
