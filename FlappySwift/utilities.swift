//
//  utilities.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Foundation

func execAfter(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}