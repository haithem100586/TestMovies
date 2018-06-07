//
//  DetailsViewController.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   var movie = Movie()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("aaaaaaaaaaaa",movie)
        //print("-------------")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section==0){
             return 1
        }
        else if (section==1){
            return 1
        }
        else if (section==2){
            return 1
        }
        else if (section==3){
            return 1
        }
        else{
            return movie.castings.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section==0){
            return 0
        }
        else if(section==1){
            return 0
        }
        
        else{
             return Constants.HEIGHTSCREEN*0.1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==1){
            return Constants.HEIGHTSCREEN*0.3
        }
            
        else{
            return Constants.HEIGHTSCREEN*0.1
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        
        if (section==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailMyReviewHeader") as? S3HReview
            return cell
        }
        else if (section==3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSynopsisHeader") as? S4HSynopsis
            return cell
        }
        else if (section==4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCastingHeader") as? S5HCasting
            return cell
        }
        else{
             return nil
        } 

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section==0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailTitle", for: indexPath) as? S1CTitle
            cell?.titleLabel.text = movie.title
            return cell!
        }
        
        else if (indexPath.section==1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailInformations", for: indexPath) as? S2CDetails
            cell?.realedDateLabel.text = "Release Date : "+movie.releaseDateTheater
            cell?.criticsRating.rating = Double(movie.criticsScore/20)
            cell?.audienceRating.rating = Double(movie.audienceScore/20)
            let placeholder = #imageLiteral(resourceName: "movieImage")
            cell?.detailImage.sd_setImage(with: URL(string: movie.imageURL), placeholderImage: placeholder )
            
            return cell!
        }
        
        else if (indexPath.section==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailMyReviewCell", for: indexPath) as? S3CReview
            return cell!
        }
        
        else if (indexPath.section==3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSynopsisCell", for: indexPath) as? S4CSynopsis
            cell?.synopsisLabel.text = movie.synopsis
            return cell!
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCastingCell", for: indexPath) as? S5CCasting
            cell?.castingLabel.text = movie.castings[indexPath.row].name
            return cell!
        }
     
    }
    

}
