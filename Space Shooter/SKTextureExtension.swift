//
//  SKTextureExtension.swift
//  Space Shooter
//
//  Created by Jose Martinez on 7/12/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//


import Foundation
import SpriteKit

// MARK: - Allows extraction of the texture name used in SKTexture
// example: self.texture?.name returns texture name as string.
extension SKTexture {

    var name:String? {
        let comps = description.components(separatedBy: "'")
        return comps.count > 1 ? comps[1] : nil
    }
    
}
