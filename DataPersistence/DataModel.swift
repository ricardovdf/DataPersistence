//
//  DataModel.swift
//  DataPersistence
//
//  Created by Ricardo V Del Frari on 19/04/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import Foundation

class DataModel : NSObject, NSCoding {
    
    //MARK: Properties
    var text : String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("text")
    
    //MARK: Init
    init(text: String) {
        self.text = text
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: PropertyKey.text)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let text = aDecoder.decodeObject(forKey: PropertyKey.text) as! String
        
        // Must call designated initializer.
        self.init(text: text)
    }
    
    //MARK: Types
    struct PropertyKey {
        static let text = "text"
    }
    
    
}
