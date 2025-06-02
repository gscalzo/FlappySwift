//
//  utilities.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Foundation

func execAfter(delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}