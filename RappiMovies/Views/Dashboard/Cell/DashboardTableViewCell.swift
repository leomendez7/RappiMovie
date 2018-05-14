//
//  DashboardTableViewCell.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 10/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import UIKit
import AlamofireImage

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var upcommingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cellView.layer.shadowRadius = 4
        cellView.layer.cornerRadius = 4
        
        movieImage.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func config(movie: Movie) {
        
        let urlImage = movie.posterPath
        
        if urlImage != ""{
            let uslString = String(format: "https://image.tmdb.org/t/p/w500%@", urlImage)
            
            guard let safeURL = uslString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return
            }
            guard let url = URL(string: safeURL) else {
                return
            }
            let placeholderImage = #imageLiteral(resourceName: "noArticles")
            movieImage.af_setImage(withURL: url, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2))
        }else{
            movieImage.image = #imageLiteral(resourceName: "noArticles")
        }
        movieNameLabel.text = movie.originalTitle
        popularityLabel.text = String(format: "Popularity %.1f", movie.popularity)
        rateLabel.text = String(format: "Rate %.1f", movie.voteAverage)
        upcommingLabel.text = String(format: "upcomming %@", movie.releaseDate)
    }
}
