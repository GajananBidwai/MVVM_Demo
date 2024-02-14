//
//  ProductTableViewCell.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 04/02/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    var product : Product?{
        didSet{ // property observer
            productDetailConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func productDetailConfiguration(){
        guard let product = product else {return}
        
        
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImage.setImage(with: product.image)
    }
}
