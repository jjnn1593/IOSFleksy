//
//  CardManagerPresenter.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation

class CardManagerPresenter: ObservableObject {
    
    @Published var data = Data()
    var providerImages: ImagesProvider? =  FactoryProviderImpl().createProviderRepository(baseUrl: Constants.RepositoryConfig.baseUrlImage, typeProvider: .ImagesProvider) as? ImagesProvider

     func getImage(contextUrl: String) {
        providerImages?.loadImage(contextUrl: contextUrl, completionHadler: { result in
            switch result {
            case .failure(_):
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self.data = image
                }
            }
        })
    }

}
