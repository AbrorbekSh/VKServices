//
//  ServicesViewModel.swift
//  ServicesInfo
//
//  Created by Аброрбек on 31.03.2024.
//

import UIKit

final class ServicesViewModel {
    typealias FetchCompletion = (Error?) -> Void
    typealias ImageDownloadCompletion = (UIImage?) -> Void
    
    private let networkingService: NetworkingService
    private var services: [Service] = []
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetchServices(completion: @escaping FetchCompletion) {
        networkingService.fetchServices { [weak self] services, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
            } else if let services = services {
                self.services = services
                completion(nil)
            }
        }
    }
    
    func downloadImage(for url: String, completion: @escaping ImageDownloadCompletion) {
        networkingService.downloadImage(from: url, completion: completion)
    }
    
    func numberOfServices() -> Int {
        return services.count
    }
    
    func configure(cell: ServiceTableViewCell, at index: Int) {
        let service = services[index]
        
        downloadImage(for: service.iconURL) { image in
            DispatchQueue.main.async {
                cell.configure(with: service)
                if let image {
                    cell.setImage(image: image)
                }
            }
        }
    }
    
    func didSelectService(at index: Int) {        
        if let url = URL(string: services[index].link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
