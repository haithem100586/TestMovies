//
//  Movie.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import Foundation

struct Movie {
    
    var title : String
    var imageURL : String
    var releaseDateTheater : String
    var criticsScore : Int
    var audienceScore : Int
    var synopsis : String
    //var castings: [Casting] = []
    var castings: [Casting]
    
    init() {
        self.title = ""
        self.imageURL = ""
        self.releaseDateTheater = ""
        self.criticsScore = 0
        self.audienceScore = 0
        self.synopsis = ""
        let castings =  [Casting]()
        self.castings = castings
    }
    
    init(title: String, imageURL: String, releaseDateTheater: String, criticsScore: Int, audienceScore: Int,
        synopsis: String, castings: [Casting]) {
        
        self.title = title
        self.imageURL = imageURL
        self.releaseDateTheater = releaseDateTheater
        self.criticsScore = criticsScore
        self.audienceScore = audienceScore
        self.synopsis = synopsis
        self.castings = castings
    }
  
}
