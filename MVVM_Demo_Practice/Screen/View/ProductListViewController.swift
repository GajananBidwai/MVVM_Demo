//
//  ProductListViewController.swift
//  MVVM_Demo_Practice
//
//  Created by Mac on 04/02/24.
//

import UIKit


class ProductListViewController: UIViewController {
    private var viewModel = ProductViewModel()
    
    @IBOutlet weak var productTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.dataSource = self
     //   productTableView.delegate = self
        configuration()
    }
    

    

}
extension ProductListViewController{
    func configuration(){
        registerXIBWithTableView()
        initViewModel()
        observerEvent()
    }
    
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTableView.register(uiNib, forCellReuseIdentifier: "ProductTableViewCell")
        
    }
//    func initializeTableView(){
//        productTableView.dataSource = self
//       // productTableView.delegate = self
//    }
    func initViewModel(){
        viewModel.fetchProducts()
    }
    // data binding event observe , communication
    func observerEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else {return}
            
            switch event{
            case .loading :
                print("Product Loading")
            case .stopLoading :
                print("stop loading")
            case .dataLoaded :
                DispatchQueue.main.async {
                    self.productTableView.reloadData()  // Ui works best in main
                }
            case .error(let error):
                print(error)
            }
            
            
        }
        
    }
}
extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let productTableViewCell = productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell
        
         //   return productTableViewCell!
            
        
        productTableViewCell!.product = viewModel.products[indexPath.row]
//        return productTableViewCell
        
        return productTableViewCell!
    }

}
