//
//  MoviesScreenInteractor.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenInteractorProtocol: InteractorPresenterProtocol {

}

final class MoviesScreenInteractorImpl: BaseInteractorProtocol {

    weak var presenter: MoviesScreenPresenterProtocol?

}

extension MoviesScreenInteractorImpl: MoviesScreenInteractorProtocol {

}
