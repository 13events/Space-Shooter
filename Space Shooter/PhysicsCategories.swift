//
//  PhysicsCategories.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/6/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation


/// Structure holding bit values used for physics
/// Values include:
/// player, bounds, playerWeapon
struct physicsCategories {
    static let player: UInt32 = 0x1 << 0
    static let bounds: UInt32 = 0x1 << 1
    static let playerWeapon: UInt32 = 0x1 << 2
}
