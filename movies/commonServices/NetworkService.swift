//
//  NetworkService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import UIKit

class NetworkService: NetworkServiceType {
    func makeRequestWithBody<T: Codable>(endpoint: EndpointType, body: T, complition: @escaping (Result<T, Error>) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard var request = buildRequest(endpoint: endpoint) else {
            return
        }
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        } catch let error {
            complition(.failure(error))
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
                        
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    complition(.success(responseData))
                } catch let error {
                    complition(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
    func makeRequest<T: Codable>(endpoint: EndpointType, complition: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let request = buildRequest(endpoint: endpoint) else {
            return
        }
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
            
            guard let data = data else { return }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                complition(.success(responseData))
            } catch let error {
                complition(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func loadImage(from url: URL?, complition: @escaping (Result<UIImage?, Error>) -> ()) {
        let session = URLSession(configuration: .default)
        guard let url = url else {
            return
        }
            
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
                
            if let data = data {
                let image = UIImage(data: data)
                guard let imageResult = image else {
                    return
                }
                complition(.success(imageResult))
            } else {
                complition(.success(nil))
            }
        }
        
        dataTask.resume()
    }
    
    private func buildRequest(endpoint: EndpointType) -> URLRequest? {
        var components = URLComponents(string: BASE_URL)
        components?.path = endpoint.path
        
        if endpoint.parameters.count != 0 {
            components?.queryItems = endpoint.parameters
        }
        
        guard let urlComponents = components else { return nil }

        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return urlRequest
    }
}
