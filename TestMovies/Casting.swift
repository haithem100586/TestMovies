//
//  Casting.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import Foundation


struct Casting {
    
    var name : String
    var id : Int
    //var characters = [String]()
    var characters : [String]?
    
    
    init(name: String, id: Int, characters: [String]?) {
        
        self.name = name
        self.id = id
        self.characters = characters
    }
    
}
