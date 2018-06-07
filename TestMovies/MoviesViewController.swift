//
//  ViewController.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var timer: Timer?
    var moviesArray = [AnyObject]()
    var searchActive : Bool = false
    var filteredTitles : [String] = []
    var moviesTitles : [String] = []
    var filteredMovies = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        addRefreshButton()
        
        loadData()
        startTimer()
        
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(Constants.delaiTimer), target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        }
    }
    
    func loop() {
        loadData()
    }
    
    func stopTimer() {
        print("stopTimer")
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func addRefreshButton(){
        let btnRefresh = UIButton(type: .custom)
        btnRefresh.setImage(UIImage(named: "refresh"), for: .normal)
        btnRefresh.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnRefresh.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnRefresh)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func refreshAction() {
        print("refresh")
        startTimer()
    }
    
    func loadData(){
        print("loadData")
        Alamofire.request(Constants.URLMoviesString).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let innerDict = dict["movies"]{
                    self.moviesArray = innerDict as! [AnyObject]
                    
                    self.tableView.reloadData()
                    self.resultsLabel.text = String(self.moviesArray.count)+" Results"
                }
            }
            
            for i in 0 ..< self.moviesArray.count{
                 let title = self.moviesArray[i]["title"]
                 self.moviesTitles.append(title as! String)
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
///////////////searchBar////////////////////////////////
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("aaaaaaaaaa", searchText)
        filteredTitles = moviesTitles.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        if(filteredTitles.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        for i in 0 ..< self.moviesArray.count{
            if filteredTitles.contains((self.moviesArray[i]["title"] as? String)!) {
              filteredMovies.append(moviesArray[i])
            }
        }
        
        self.tableView.reloadData()
    }
/////////////////////////////////////////////////////////
    
    
    
///////////////////tableview////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredMovies.count
        }
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        
        if(searchActive) {
            let title = filteredMovies[indexPath.row]["title"]
            cell?.movieLabel.text = title as? String
            let urlImages = filteredMovies[indexPath.row]["posters"] as? [String: String]
            let urlImage = urlImages?["thumbnail"] as! String
            let placeholder = #imageLiteral(resourceName: "movieImage")
            cell?.movieImage.sd_setImage(with: URL(string: urlImage), placeholderImage: placeholder )
        }else{
            let title = moviesArray[indexPath.row]["title"]
            cell?.movieLabel.text = title as? String
            let urlImages = moviesArray[indexPath.row]["posters"] as? [String: String]
            let urlImage = urlImages?["thumbnail"] as! String
            let placeholder = #imageLiteral(resourceName: "movieImage")
            cell?.movieImage.sd_setImage(with: URL(string: urlImage), placeholderImage: placeholder )
        }
    
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsegue" , let detailController = segue.destination as? DetailsViewController,
           let indexPath = self.tableView.indexPathForSelectedRow{
            
            let urlImages = moviesArray[indexPath.row]["posters"] as! [String: String]
            let urlImage = urlImages["detailed"]!
            
            let releaseDates = moviesArray[indexPath.row]["release_dates"] as! [String: String]
            let releaseDateTheater = releaseDates["theater"]!
            
            let ratings = moviesArray[indexPath.row]["ratings"] as! [String: Any]
            let criticScore = ratings["critics_score"] as! Int
            let audienceScore = ratings["audience_score"] as! Int
            
            let castings = moviesArray[indexPath.row]["abridged_cast"] as? [AnyObject]
            var arrayOfCastings = [Casting]()
           
            for i in 0 ..< castings!.count  {
                let dict = castings?[i]
                let casting = Casting (name: dict?["name"] as! String, id: Int(dict?["id"] as! String) ?? 0,
                                       characters: (dict?["characters"] as? [String]) )
                arrayOfCastings.append(casting)
            }
            
            let movie = Movie(title: moviesArray[indexPath.row]["title"] as! String, imageURL: urlImage, releaseDateTheater: releaseDateTheater, criticsScore :criticScore, audienceScore : audienceScore,  synopsis: moviesArray[indexPath.row]["synopsis"] as! String, castings : arrayOfCastings )
    
            detailController.movie = movie
        }
    }
    
    
    
}

