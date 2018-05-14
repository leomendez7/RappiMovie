//
//  DashboardViewController.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 10/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController {
    
    enum MovieSorting: Int {
        case popular
        case top
        case upcomming
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var movies: MoviesResponse!
    var datasource = [Movie]()
    
    var popular = true
    var top = false
    var upcomming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureOutlet()
        createTable()
        loadInfo()
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
    
    func configureOutlet() {
        
        let leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFit
        
        let leftView = UIView()
        
        leftView.frame = CGRect(x: 20, y: 0, width: 30, height: 20)
        leftImageView.frame = CGRect(x: 13, y: 0, width: 15, height: 20)
        searchTextField.leftViewMode = .always
        searchTextField.leftView = leftView
        
        let image = #imageLiteral(resourceName: "glass").withRenderingMode(.alwaysTemplate)
        leftImageView.image = image
        leftImageView.tintColor = UIColor.RMGrayColor()
        leftImageView.tintColorDidChange()
        
        leftView.addSubview(leftImageView)
        
        searchTextField.layer.cornerRadius = 15
    }
    
    func loadInfo() {
        ActivityIndicator.shared.startSpinnerAnimation(message: "Cargando...")
        DataService.shared.loadMovie { (error, mo) in
            if let e = error{
                print(e)
            }else{
                guard let movies = mo else { return }
                self.movies = movies
            }
            DispatchQueue.main.async {
                ActivityIndicator.shared.stopSpinnerAnimation()
                self.switchMovieOrder(self.segmentedControl)
            }
            
        }
    }
    
    @IBAction func switchMovieOrder(_ sender: UISegmentedControl) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let sorting = MovieSorting(rawValue: sender.selectedSegmentIndex) ?? .popular
        
        switch sorting {
        case .popular:
            datasource = movies.list(by: .popular)
            popular = true
            top = false
            upcomming = false
        case .top:
            datasource = movies.list(by: .top)
            popular = false
            top = true
            upcomming = false
        case .upcomming:
            datasource = movies.list(by: .upcomming)
            popular = false
            top = false
            upcomming = true
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func seacrhMovie(_ sender: UITextField) {
        if sender.text! != "" {
            if popular == true {
                datasource = movies.filterMovie(name: sender.text!, clasification: .popular)
            }else if top == true {
                datasource = movies.filterMovie(name: sender.text!, clasification: .top)
            }else if upcomming == true {
                datasource = movies.filterMovie(name: sender.text!, clasification: .upcomming)
            }
        }else{
            if (popular == true) {
                datasource = movies.list(by: .popular)
            }else if (top == true) {
                datasource = movies.list(by: .top)
            }else if (upcomming == true) {
                datasource = movies.list(by: .upcomming)
            }
        }
        self.tableView.reloadData()
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func createTable (){
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DashboardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashboardTableViewCell
        
        cell.config(movie: datasource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextView = DetailViewController()
        nextView.movie = datasource[indexPath.row]
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
