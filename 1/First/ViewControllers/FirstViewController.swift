//
//  NewsViewController.swift
//
//  Created by Roman on 08/12/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var imageUrl = "https://placehold.it/375x150?text=%d"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
       // print("table reloaded")
        
    }
    
    // MARK: - Table view data source
    
    private let numberOfRows = 100
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        
        let stringUrl = String(format: imageUrl, indexPath.row + 1)
        if let url = URL(string: stringUrl) {
            if (indexPath.row < numberOfRows) {
                downloadImage(withUrl: url, forCell: cell)
            }
        } else {
        print("Incorrect url \(stringUrl)")
        }
        
        // Временное решение,т.к. пока не знаю, как в downloadImage присвоить картинку в кастомуню imageView
        if let imageView = cell.imageView {
            cell.customImageView = imageView
        }
        
        return cell
    }
    
    func downloadImage(withUrl url: URL, forCell cell: UITableViewCell) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   guard let dataResponse = data, error == nil else {
                       print(error?.localizedDescription ?? "Response Error")
                       return
                   }
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: dataResponse)
            }
        }
        task.resume()
    }
}



