//
//  CellData+CoreDataProperties.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//
//

import Foundation
import CoreData

extension CellData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CellData> {
        return NSFetchRequest<CellData>(entityName: "CellData")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var title: String?
    @NSManaged public var text: String?

}
