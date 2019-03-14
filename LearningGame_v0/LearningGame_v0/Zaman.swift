//
//  Zaman.swift
//  LearningGame_v0
//
//  Created by Alperen on 14.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import Foundation

class Zaman {
    
    var aradanGecenZaman = -1
    
    
    init(eklenenTarih: Date) {
        let calender = Calendar.current
        let simdikiTarih = Date()
        
        let veryLongTime = calender.dateComponents([.minute], from: eklenenTarih, to: simdikiTarih).minute
        if veryLongTime != nil {
            self.aradanGecenZaman = veryLongTime!
        }
        
    }
    
    
    
}
