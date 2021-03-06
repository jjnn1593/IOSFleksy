//
//  MoviesCoordinator.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import Foundation
import SwiftUI

final class MoviesScreenCoordinator: ModuleCoordinator {

    typealias ContentView = MoviesScreenView
    typealias Presenter = MoviesScreenPresenterImpl
    typealias Interactor = MoviesScreenInteractorImpl

    static var shared: MoviesScreenCoordinator = {
        let instance = MoviesScreenCoordinator()
        return instance
    }()

    func build() -> ContentView {
        let presenter = Presenter()
        let interactor = Interactor()
        let view = ContentView(presenter: presenter)
        self.coordinator(presenter: presenter, interactor: interactor)
        return view
    }
}
