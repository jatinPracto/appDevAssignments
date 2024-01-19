//
//  ViewController.swift
//  MovieApp
//
//  Created by Jatin Kamal Vangani on 19/01/24.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var baseURL = "https://www.omdbapi.com/"
    var apiKey = "2c30e4db"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        
        searchBar.delegate=self
        
    }
    
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text, !searchText.isEmpty {
                let apiURL = prepareURL(forQuery: searchText)!
                print(apiURL)
                
                URLSessionApiClient.shared.dataTask(apiURL) { (_ result: Result<Object, Error>) in
                    switch result {
                                    case .failure(let error):
                                        print(error)
                                    case .success(let object):
                        if let firstSearch = object.search?.first {
                                            DispatchQueue.main.async {
                                                self.titleLabel.text = firstSearch.title
                                                self.yearLabel.text = firstSearch.year
                                                self.typeLabel.text = firstSearch.type
                                                if let imageUrl = URL(string: firstSearch.poster) {
                                                    
                                                    self.loadImage(url: imageUrl)
                                                }
                                            }
                                        } else {
                                            print("No movie details found.")
                                        }
                                    }
                }
                }
            }
    
    func loadImage(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.posterImageView.image = image
                        }
                    }
                }
            }
        }
        

    func prepareURL(forQuery query: String) -> URL? {
                        
            var urlComponents = URLComponents(string: baseURL)
            urlComponents?.queryItems = [
                URLQueryItem(name: "apikey", value: apiKey),
                URLQueryItem(name: "s", value: query)
            ]
            return urlComponents?.url
        }
}

