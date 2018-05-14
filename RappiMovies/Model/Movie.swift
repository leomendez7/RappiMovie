//
//  Movie.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 10/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import Foundation
import RealmSwift


class Movie: Object, Codable {
    
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var mediaType: String = ""
    @objc dynamic var popularity: Float = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var posterPath: String = ""
    
    var releaseDateValue: Date {
        return DateFormatter().date(from: releaseDate) ?? Date()
    }
    
    override var description: String {
        return "\n TITLE: \(title), AVERAGE: \(voteAverage), POPULARITY: \(popularity),  RELEASE: \(releaseDate) \n"
    }
}

class MoviesResponse: Codable {
    var movies: [Movie] = []
    private let realm = try! Realm()
    
    enum MovieClasification {
        case popular
        case top
        case upcomming
    }
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    func list(by clasification: MovieClasification) -> [Movie] {
        switch clasification {
        case .popular:
            return movies.sorted{ $0.popularity > $1.popularity }
        case .top:
            return movies.sorted{ $0.voteAverage > $1.voteAverage }
        case .upcomming:
            return movies.sorted{ $0.releaseDateValue < $1.releaseDateValue }
        }
    }
    
    func filterMovie(name: String, clasification: MovieClasification) -> [Movie] {
        return list(by: clasification).filter { $0.title.contains(name) }
    }
    
    func saveMoviesInDatabase() {
        
        DispatchQueue.main.sync {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(realm.objects(Movie.self))
                }
                realm.beginWrite()
                realm.add(self.movies)
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func loadMoviesFromDatabase() {
        let movies = self.realm.objects(Movie.self)
        self.movies = movies.map { $0 }   
    }
    
}
