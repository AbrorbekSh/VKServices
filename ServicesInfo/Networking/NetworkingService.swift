//
//  NetworkingService.swift
//  ServicesInfo
//
//  Created by Аброрбек on 31.03.2024.
//

import UIKit

struct ServiceResponse: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}

final class NetworkingService {
    private let url = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func fetchServices(completion: @escaping ([Service]?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let serviceResponse = try decoder.decode(ServiceResponse.self, from: data)
                completion(serviceResponse.body.services, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
        
        task.resume()
    }
}
