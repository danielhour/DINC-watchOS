//
//  ComplicationManager.swift
//  DINC
//
//  Created by dhour on 4/16/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation
import ClockKit


struct ComplicationManager {

    /**
     Reloads timeline for complication
     */
    static func reloadComplications() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimeline(for: complication)
        }
    }
}
