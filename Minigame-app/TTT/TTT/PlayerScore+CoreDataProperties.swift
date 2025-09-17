//
//  PlayerScore+CoreDataProperties.swift
//  TTT
//
//  Created by Feliciano Medina on 2/28/25.
//
//

import Foundation
import CoreData


extension PlayerScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerScore> {
        return NSFetchRequest<PlayerScore>(entityName: "PlayerScore")
    }

    @NSManaged public var playerName: String?
    @NSManaged public var score: Int64

}

extension PlayerScore : Identifiable {

}
