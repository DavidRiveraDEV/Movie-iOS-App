//
//  ImageCacheService.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import UIKit

class ImageCacheService {
    
    static func save(image: UIImage, forKey key: String) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(key)!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getImage(forKey key: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(key).path)
        }
        return nil
    }
}
