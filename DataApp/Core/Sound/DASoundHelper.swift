//
//  DASoundHelper.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 23/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import Foundation
import AVFoundation


// MARK: Sound Helper Class
class DASoundHelper {
    // MARK: Sound Helper Enum
    enum SystemSound: UInt32 {
        case app_launched = 1110 // jbl_begin
        case data_received = 1010 // sms_received
        case data_error = 1073 // audio_tone_error
    }
    
    // MARK: Helper Function
    static func playSound(sound: SystemSound) {
        AudioServicesPlayAlertSound(SystemSoundID(sound.rawValue))
    }
}
