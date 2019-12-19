//
//  BreedDetailViewController.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {

    public var breedName: String!
    public var imagesArrayStringCache = [String]()

    @IBOutlet weak var breedImageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = breedName
        self.getImages()
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        var favoritesArray = [String]()
        if let array = UserDefaults.standard.array(forKey: "favorites") as? [String] {
            if array.contains(self.breedName) == false {
                favoritesArray.append(contentsOf: array)
                favoritesArray.append(self.breedName)
                UserDefaults.standard.set(favoritesArray, forKey: "favorites")
            }
        } else {
            UserDefaults.standard.set([self.breedName], forKey: "favorites")
        }
        
        
    }
    
    func getImages() {
        let urlString = ConstantsURL.baseURL + ConstantsURL.URLforBreed(breed: self.breedName)
        let request = URLRequest(url: URL(string: urlString)!)
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let result):
                if let jsonArray = result as? [String] {
                    self.imagesArrayStringCache = jsonArray
                    self.breedImageTableView.reloadData()
                }
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage(url: URL, completion: @escaping ((_ image: UIImage) -> ())) {
        let request = URLRequest(url: url)
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let result):
                let image = UIImage(data: result as! Data)
                completion(image!)
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension BreedDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArrayStringCache.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedImageTableViewCell", for: indexPath) as! BreedImageTableViewCell

        let url = URL(string: self.imagesArrayStringCache[indexPath.row])!
        DispatchQueue.global().async {
            self.getImage(url: url) { image in
                DispatchQueue.main.async {
                    cell.breedImageView?.image = image
                    cell.setNeedsLayout()                    
                }
            }
        }
        
        return cell
    }
}

