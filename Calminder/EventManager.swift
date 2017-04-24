//
//  EventManager.swift
//  Calminder
//
//  Created by saeko fukui on 2017-04-23.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import Foundation
import EventKit

final class EventManager {
    private init() { }
    
    static let shared:EventManager = EventManager()
    
    let eventStore = EKEventStore()
}
