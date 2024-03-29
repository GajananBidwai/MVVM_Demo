//
//  ProductViewModel.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 04/02/24.
//

import Foundation
final class ProductViewModel{
    var products : [Product] = []
    var eventHandler : ((_ event : Event)->Void)? // used for data binding
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler!(.stopLoading)
            
            switch response{
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler!(.error(error))
            }
        }
    }
    
}

extension ProductViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
