//
//  ContentView.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 14/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MoviesScreenCoordinator().build()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
