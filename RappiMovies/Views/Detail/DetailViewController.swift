//
//  DetailViewController.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 13/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var upcommingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setImage()
        titleLabel.text = movie?.title
        popularityLabel.text = String(format: "Popularity %.1f", movie?.popularity ?? "")
        rateLabel.text = String(format: "Rate %.1f", movie?.voteAverage ?? "")
        upcommingLabel.text = String(format: "upcomming %@", movie?.releaseDate ?? "")
        descriptionLabel.text = movie?.overview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationBar (){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Rappi"))
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setImage() {
        let urlImage = movie?.posterPath
        
        if urlImage != ""{
            let uslString = String(format: "https://image.tmdb.org/t/p/w500%@", urlImage!)
            
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
    }
    
    @IBAction func image(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            if self.movie?.posterPath != ""{
                UIApplication.shared.isStatusBarHidden = true
                let vc = ImageDetailsViewController()
                vc.urlImg = (self.movie?.posterPath)!
                self.present(vc, animated: true, completion: nil)
            }
        })
    }
}
