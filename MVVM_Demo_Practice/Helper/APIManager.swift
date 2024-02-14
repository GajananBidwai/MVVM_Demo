//
//  APIManager.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 03/02/24.
//


import Foundation
// singleton design pattern
// singleton class used for to avoid object creation
// final keyword is used for avoid inheritance
enum DataError : Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidDecoding
    case network(Error?)
}
typealias Handler = (Result<[Product], DataError>)->Void

final class APIManager {
    static var shared = APIManager()
    
    private init(){}
    
    
    func fetchProducts(completion: @escaping Handler){
        
        guard let url = URL(string: Constant.API.productUrl) else{return}
        // background task
        //escaption closure after the function execute
        //nonEscapting closure execute line by line
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                completion(.failure(.invalidURL))
                return
            }
            
            
//            guard let data = data else {
//                       // Only report invalid URL error if data is nil
//                       if let error = error {
//                           completion(.failure(.network(error)))
//                       } else {
//                           completion(.failure(.invalidURL))
//                       }
//                       return
//                   }

            // ~= pattern matching operator used to match check the pattern
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            // JSONDecoder() is used to convert the data into model of Array coz its product array
            do{
                let product = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(product))
            }catch{
                //completion(.network(error))
                completion(.failure(.invalidDecoding))
            }

        //resume for execute after the function returns //go inside the function
        }.resume()
    }
}


//small s(singleton - class ka object creat hoga outside of the class
//big S(Singleton - class ka object creat nhi hoga outside of the class

