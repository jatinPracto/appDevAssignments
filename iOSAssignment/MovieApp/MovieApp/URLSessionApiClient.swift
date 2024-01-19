//
//  URLSessionApiClient.swift
//  MovieApp
//
//  Created by Jatin Kamal Vangani on 19/01/24.
//

import Foundation
final class URLSessionApiClient {
    static let shared = URLSessionApiClient()
    private init() {}
//    private let configuration: URLSessionConfiguration
//    private let session: URLSession
    
//    init() {
//        self.configuration = URLSessionConfiguration.default
//        self.configuration.timeoutIntervalForRequest = 30.0
//        self.configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
//        
//        // Create URLSession
//        self.session = URLSession(configuration: self.configuration)
//    }
    
    enum AppError: Error{
        case decodingError
        case noHttpBody
    }
    
    func dataTask<T: Codable>(_ url: URL, onCompletion: @escaping (_ result: Result<T, Error>) -> Void) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // onFailure
                if let err = error {
                    print(" failure")
                    onCompletion(.failure(err))
                    return
                }
                
                // onSuccess  
                if let data = data {
                   
                    //print("Data \(data.base64EncodedString())")
                    if let details = try? JSONDecoder().decode(T.self, from: data) {
                        print(" pass")
                      //  if let firstSearch = details.search.first
                        onCompletion(.success(details))
                    } else {
                        //print(" failure1")
                        onCompletion(.failure(AppError.decodingError))
                    }
                } else {
                    //print(" failure2")
                    onCompletion(.failure(AppError.noHttpBody))
                }
            }.resume()
        }
}
