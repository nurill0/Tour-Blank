//
//  SearchCell.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 05/09/23.
//

import UIKit
import UnsplashPhotoPicker

class PhotoCollectionViewCell: UICollectionViewCell {

    lazy var photoImageView: UIImageView = {
        let img = UIImageView()
        
        return img
    }()

    private var imageDataTask: URLSessionDataTask?
    private static var cache: URLCache = {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let diskPath = "unsplash"
        
        if #available(iOS 13.0, *) {
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                directory: URL(fileURLWithPath: diskPath, isDirectory: true)
            )
        }
        else {
            #if !targetEnvironment(macCatalyst)
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                diskPath: diskPath
            )
            #else
            fatalError()
            #endif
        }
    }()

    func downloadPhoto(_ photo: UnsplashPhoto) {
        guard let url = photo.urls[.regular] else { return }

        if let cachedResponse = PhotoCollectionViewCell.cache.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cachedResponse.data) {
            photoImageView.image = image
            return
        }

        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }

            strongSelf.imageDataTask = nil

            guard let data = data, let image = UIImage(data: data), error == nil else { return }

            DispatchQueue.main.async {
                UIView.transition(with: strongSelf.photoImageView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    strongSelf.photoImageView.image = image
                }, completion: nil)
            }
        }

        imageDataTask?.resume()
    }

}
