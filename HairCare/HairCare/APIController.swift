//
//  APIController.swift
//  HairCare
//
//  Created by Tobi Kuyoro on 05/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HeaderNames: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum NetworkError: Error {
    case encodingError
    case unexpectedStatusCode(Error)
    case requestError(Error)
    case noBearer
    case serverError(Error)
    case badData
    case noDecode
    case otherError
}

class APIController {
    
    private let baseURL = URL(string: "https://haircare1backend.herokuapp.com/")!
    var bearer: Bearer?
    
    typealias SignInCompletionHandler = (NetworkError?) -> Void
    typealias StylistCitiesCompletionHandler = (Result<[StylistRepresentation], NetworkError>) -> Void
    typealias AllStylistsCompletionHandler = (Result<[StylistRepresentation], NetworkError>) -> Void
    typealias StylistDetailsCompletionHandler = (Result<StylistRepresentation, NetworkError>) -> Void
    typealias StylistImageCompletionHandler = (Result<UIImage, NetworkError>) -> Void
    
    func signUp(customer: SignUpUser, completion: @escaping SignInCompletionHandler) {
        let requestURL = baseURL
        .appendingPathComponent("api")
        .appendingPathComponent("customers")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        
        do {
            let customerJSON = try JSONEncoder().encode(customer)
            request.httpBody = customerJSON
        } catch {
            NSLog("Error encoding customer object")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error signing up customer: \(error)")
                completion(.requestError(error))
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                let statusCode = NSError(domain: "", code: response.statusCode, userInfo: nil)
                completion(.unexpectedStatusCode(statusCode))
            }
            completion(nil)
        }.resume()
    }
    
    func signIn(customer: SignInUser, completion: @escaping SignInCompletionHandler) {
        let requestURL = baseURL
        .appendingPathComponent("api")
        .appendingPathComponent("customers")
        .appendingPathComponent("login")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        
        do {
            request.httpBody = try JSONEncoder().encode(customer)
        } catch {
            NSLog("Error encoding customer for sign in: \(error)")
            completion(.encodingError)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error signing in customer: \(error)")
                completion(.requestError(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                let statusCodeError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                completion(.unexpectedStatusCode(statusCodeError))
            }
            completion(nil)
        }.resume()
    }
    
    func fetchStylists(in city: String, completion: @escaping StylistCitiesCompletionHandler) {
        guard let bearer = bearer else {
            completion(.failure(.noBearer))
            return
        }
        
        let stylistsURL = baseURL
        .appendingPathComponent("api")
        .appendingPathComponent("stylists")
        .appendingPathComponent("location")
        .appendingPathComponent(city)
        
        var request = URLRequest(url: stylistsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching stylists in \(city): \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.unexpectedStatusCode(NSError())))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let stylists = try JSONDecoder().decode([StylistRepresentation].self, from: data)
                completion(.success(stylists))
            } catch {
                NSLog("Error decoding stylists in \(city): \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func fetchAllStylists(completion: @escaping AllStylistsCompletionHandler) {
        guard let bearer = bearer else {
            completion(.failure(.noBearer))
            return
        }
        
            let stylistURL = baseURL
            .appendingPathComponent("api")
            .appendingPathComponent("stylists")
            
            var request = URLRequest(url: stylistURL)
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching stylists: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.unexpectedStatusCode(NSError())))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let stylists = try JSONDecoder().decode([StylistRepresentation].self, from: data)
                completion(.success(stylists))
            } catch {
                NSLog("Error decoding stylists: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping StylistImageCompletionHandler) {
        let imageURL = URL(string: urlString)!
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
}
