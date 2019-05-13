//
//  Timer.swift
//  Demise
//
//  Created by Allen Lai on 1/28/18.
//  Copyright © 2018 Allen Lai. All rights reserved.
//

import Foundation


class ALTimer {


    static var recordTimer = Timer()
    static var recordingTimeCounter = 0


    @objc func updateCounter() {
        ALTimer.recordingTimeCounter += 1

//        timeLabel.text = String(minutes) + ":" + stringSeconds + "." + stringCenti
    }


}
