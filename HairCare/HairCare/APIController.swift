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
}

enum NetworkError: Error {
    case encodingError
    case unexpectedStatusCoded(Error)
    case requestError(Error)
}

class APIController {
    
    private let baseURL = URL(string: "https://haircare1backend.herokuapp.com/")!
    var bearer: Bearer?
    
    typealias SignInCompletonHandler = (NetworkError?) -> Void
    
    func signUp(customer: CustomerRepresentation, completion: @escaping SignInCompletonHandler) {
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
                completion(.unexpectedStatusCoded(statusCode))
            }
            completion(nil)
        }.resume()
    }
    
    func signIn(customer: CustomerRepresentation, completion: @escaping SignInCompletonHandler) {
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
                completion(.unexpectedStatusCoded(statusCodeError))
            }
            completion(nil)
        }.resume()
    }
}
