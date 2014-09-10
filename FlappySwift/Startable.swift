//
//  Startable.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import Foundation


protocol Startable {
    func start() -> Startable
    func stop() -> Startable
}