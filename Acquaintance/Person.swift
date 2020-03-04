//
//  Person.swift
//  Acquaintance
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 GAOOcean. All rights reserved.
//

import Foundation
import UIKit


class Person: NSObject,NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
    }
    
    /*required init?(coder aDecoder: NSCoder) {
        <#code#>
    }*/
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string,the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey:PropertyKey.nameKey) as? String else {
                logDebug("Unable to decode the name for a object.")
                return nil }
        let photo = aDecoder.decodeObject(forKey:
            PropertyKey.photoKey) as? UIImage
        let notes = aDecoder.decodeObject(forKey:PropertyKey.notesKey) as? String
        logDebug(String(format:"Decode the person %@", name))
        self.init(name: name, photo: photo, notes: notes)
    }
    

    
    
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let notesKey = "notes"
    }
    
    
    // MARK: - Archiving File Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory,in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("acqList")
    
    
    
    
    
    
    
    var name: String
    var photo: UIImage?
    var notes: String?
    init(name: String, photo: UIImage?, notes: String?) {
        self.name = name
        self.photo = photo
        self.notes = notes
        super.init()
    }
    convenience init(_ name: String) {
        self.init(name: name,
                  photo: nil,
                  notes: nil)
    }
    
}
