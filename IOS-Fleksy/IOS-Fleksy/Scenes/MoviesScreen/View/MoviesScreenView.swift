//
//  MoviesScreenView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import SwiftUI

struct MoviesScreenView: View {

    @ObservedObject var presenter = MoviesScreenPresenterImpl()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear(perform: presenter.fetchDataFromPresente)
    }
}

struct MoviesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesScreenView()
    }
}
