//
//  ExtensionUIImageView.swift
//  MovieApp
//
//  Created by user222465 on 10/7/22.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        self.addSubview(activityIndicator)
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                activityIndicator.removeFromSuperview()
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
