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
    
    // MARK: - Table view data source
    
    private let numberOfRows = 100
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        let cell = customCell ?? CustomTableViewCell()
        
        let stringUrl = String(format: imageUrl, indexPath.row + 1)
        guard let url = URL(string: stringUrl)  else {
            print("Incorrect url \(stringUrl)")
            return cell
        }
        downloadImage(withUrl: url, forCell: cell)
        return cell
    }
    
    func downloadImage(withUrl url: URL, forCell cell: UITableViewCell) {
        guard let cell = cell as? CustomTableViewCell else { return }
        let absoluteUrl = url.absoluteString as NSString
        
        if let image = ImageCacheService.shared.getImage(url: absoluteUrl as NSString) {
            cell.setImage(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [unowned absoluteUrl] (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            guard let image = UIImage(data: dataResponse) else { return }
            
            DispatchQueue.main.async {
                cell.setImage(image)
                ImageCacheService.shared.addImage(url: absoluteUrl, image: image)
            }
        }
        task.resume()
    }
}



