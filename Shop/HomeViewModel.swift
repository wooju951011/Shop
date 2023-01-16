//
//  HomeViewModel.swift
//  Shop
//
//  Created by wooju on 2023/01/16.
//

import Foundation
import Combine

final class HomeViewModel {
    
    let network: NetworkService
    
    @Published var items: [product] = []
    var subscriptions = Set<AnyCancellable>()
    
    let itemTapped = PassthroughSubject<product, Never>()
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetch() {
        let resource: Resource<[product]> = Resource(
            base: "http://192.168.55.201:8000",
            path: "/product/list",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("--> error: \(error)")
                case .finished:
                    print("--> finished")
                }
            } receiveValue: { items in
                self.items = items
            }.store(in: &subscriptions)
    }
}
