//
//  HomeViewController.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var breedsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBreeds()
    }
    
    func getBreeds() {
        let urlString = ConstantsURL.baseURL + ConstantsURL.breeds
        let request = URLRequest(url: URL(string: urlString)!)
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let result):
                if let jsonArray = result as? [String] {
                    self.breedsArray = jsonArray
                    self.tableView.reloadData()
                }
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedItemTableViewCell", for: indexPath) as! BreedItemTableViewCell
        cell.breedName.text = self.breedsArray[indexPath.row]
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreedDetailViewController") as! BreedDetailViewController
        breedDetailViewController.breedName = self.breedsArray[indexPath.row]
        self.navigationController?.pushViewController(breedDetailViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
