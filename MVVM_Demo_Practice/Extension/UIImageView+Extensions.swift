//
//  UIImageView+Extensions.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 05/02/24.
//

import Foundation
import Kingfisher
import UIKit
extension UIImageView{
    func setImage(with urlString : String){
        guard let url = URL(string: urlString) else{
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.setImage(with: resource)
    }
}
