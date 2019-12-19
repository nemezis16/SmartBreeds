//
//  FavoriteBreedViewController.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import UIKit

class FavoriteBreedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var breedsArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let array = UserDefaults.standard.array(forKey: "favorites") as? [String] {
            breedsArray = array
            self.tableView.reloadData()
        }
    }
    
    @IBAction func handleCleanButtonTap(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set([], forKey: "favorites")
        breedsArray = [String]()
        self.tableView.reloadData()
    }
    
}

extension FavoriteBreedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedItemTableViewCell", for: indexPath) as! BreedItemTableViewCell
        cell.breedName.text = self.breedsArray[indexPath.row]
        
        return cell
    }
}

extension FavoriteBreedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreedDetailViewController") as! BreedDetailViewController
        breedDetailViewController.breedName = self.breedsArray[indexPath.row]
        self.navigationController?.pushViewController(breedDetailViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
