//
//  Zaman.swift
//  LearningGame_v0
//
//  Created by Alperen on 14.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import Foundation

class Liste {
    
    var aradanGecenZaman = -1
    var bugununKelimeri = ["":""]
    
    init(eklenenTarih: Date) {
        let calender = Calendar.current
        let simdikiTarih = Date()
        
        let veryLongTime = calender.dateComponents([.second], from: eklenenTarih, to: simdikiTarih).second
        if veryLongTime != nil {
            self.aradanGecenZaman = veryLongTime!
        }
        }
    init() {
        bugununKelimeri.removeAll()
       
        
    }
    
    func bugununLİstesiniCıkar(aradanGecenGunSayısı: Int, ogrenmeSeviyesi: Int, ingKelime: String, trKelime: String) -> [String:String] {
        if aradanGecenGunSayısı >= 1, ogrenmeSeviyesi == 1 {
            bugununKelimeri[ingKelime] = trKelime
        }
        else if aradanGecenGunSayısı >= 7, ogrenmeSeviyesi == 2 {
            bugununKelimeri[ingKelime] = trKelime
        }
        else if aradanGecenGunSayısı >= 30, ogrenmeSeviyesi == 3 {
            bugununKelimeri[ingKelime] = trKelime
        }
        else if aradanGecenGunSayısı >= 180, ogrenmeSeviyesi == 4 {
            bugununKelimeri[ingKelime] = trKelime
        }
        return bugununKelimeri
    }
    
    
    }
