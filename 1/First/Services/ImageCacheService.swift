//
//  ImageCacheService.swift
//  First
//
//  Created by user167101 on 2/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService {
    
    private init() {
        cache = NSCache<NSString, UIImage>()
    }
    
    private let cache: NSCache<NSString, UIImage>
    
    static let shared = ImageCacheService()
    
    func addImage(url: NSString, image: UIImage) {
        cache.setObject(image, forKey: url)
    }
    
    func getImage(url: NSString) -> UIImage? {
        return cache.object(forKey: url)
    }
}

