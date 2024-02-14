//
//  Products.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 03/02/24.
//

import Foundation
struct Product : Decodable{
    var id : Int
    var title : String
    var price : Float
    var description : String
    var image : String
    var category : String
    var rating : Rating
}
struct Rating : Decodable{
    var rate : Float
    var count : Int
}
