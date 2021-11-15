//
//  UIImage+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, completion: ((_ image: UIImage?) -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?(image)
                        return
                    }
                }
            }
            completion?(nil)
        }
    }
}
