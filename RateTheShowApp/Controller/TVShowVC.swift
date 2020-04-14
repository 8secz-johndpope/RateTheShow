//
//  TVShowVC.swift
//  RateTheShowApp
//
//  Created by Анна Никифорова on 14.04.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit
//import Alamofire

class TVShowVC: UIViewController {
    
    var tvShows = [TVShowInfo]()
    var searchTVShow = [TVShowInfo]()
    var isSearching = false
  //  private var networkingClient = NetworkingClient()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
//        guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=4df29c189fd27f2129b274a60619e43c&language=en-US&page=1") else {
//            return
//        }
//
//        func execute(_ url: URL) {
//            AF.request(url, method: .get).response { response in
//                print(response)
//                if let data = response.data {
//                    do {
//                        let downloadedTVShowData = try JSONDecoder().decode(TVShowData.self, from: data)
//                        self.tvShows = downloadedTVShowData.results
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//
//        execute(url)
    //  networkingClient.execute(url)
        
    }
    
    // MARK: - JSON parsing
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=4df29c189fd27f2129b274a60619e43c&language=en-US&page=1") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            print(data)

            do {
                let downloadedTVShowData = try JSONDecoder().decode(TVShowData.self, from: data)
                self.tvShows = downloadedTVShowData.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        } .resume()
    }
    
}


// MARK: - TableView

extension TVShowVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchTVShow.count
        } else {
            return tvShows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tvShow = tvShows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowCell", for: indexPath) as! TVShowCell
        
        // cell configuration
        if isSearching {
            cell.setTVShow(tvShow: searchTVShow[indexPath.row])
        } else {
            cell.setTVShow(tvShow: tvShow)
        }
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

// MARK: - Search Bar

extension TVShowVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            searchTVShow = tvShows.filter({ value -> Bool in
                
                guard let text = searchBar.text?.lowercased() else { return false }
                return value.name!.lowercased().contains(text)
            })
            
            tableView.reloadData()
            
        }
    }
    
}
