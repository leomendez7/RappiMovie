//
//  DataService.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 10/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import Foundation
import RealmSwift

class DataService{
    
    static let shared = DataService()

    let realm = try! Realm()
    
    func loadMovie(_ contentBlock: @escaping (NSError?, MoviesResponse?)->()){
        
        var movies = MoviesResponse()
        movies.loadMoviesFromDatabase()
        contentBlock(nil, movies)
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "210c2fc9-7285-79cb-82a4-9817fbea1d76"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/4/list/1?api_key=ecd808c2e2821a26fd7b166a9a01bbe8")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription ?? "Unkwnown error")
            } else {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let newMovies = try! decoder.decode(MoviesResponse.self, from: data!)
                  contentBlock(nil, newMovies)
                movies = newMovies
                movies.saveMoviesInDatabase()
            }
        })
        
        dataTask.resume()
    }
    
}
