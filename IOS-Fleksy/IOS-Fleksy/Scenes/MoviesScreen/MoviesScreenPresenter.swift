//
//  MoviesScreenPresenter.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation

protocol MoviesScreenPresenterProtocol: PresenterInteractorProtocol {

}

final class MoviesScreenPresenterImpl: BasePresenteProtocol, ObservableObject {

    var interactor: MoviesScreenInteractorProtocol?
}

extension MoviesScreenPresenterImpl: MoviesScreenPresenterProtocol {
    
}
