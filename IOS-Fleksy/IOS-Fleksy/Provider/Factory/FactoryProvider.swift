//
//  FactoryProvider.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation

protocol FactoryProvider {
    func createProviderRepository(baseUrl:String, typeProvider: FactoryProviderImpl.TypeProviders) -> BaseRepository?
}

extension FactoryProvider {

    func configuredURLSession() -> URLSession {
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 60
       configuration.timeoutIntervalForResource = 120
       configuration.waitsForConnectivity = true
       configuration.httpMaximumConnectionsPerHost = 5
       configuration.requestCachePolicy = .returnCacheDataElseLoad
       configuration.urlCache = .shared
       return URLSession(configuration: configuration)
   }

}

struct FactoryProviderImpl: FactoryProvider {

    enum TypeProviders {
        case MoviesProvider
        case ImagesProvider
    }

    func createProviderRepository(baseUrl: String, typeProvider: TypeProviders) -> BaseRepository? {
        switch typeProvider {
        case .MoviesProvider:
            return MoviesProvider(baseURL: baseUrl, session: configuredURLSession())
        case .ImagesProvider:
            return ImagesProvider(baseURL: baseUrl, session: configuredURLSession())
        }

    }

}
