//
//  DataBase.swift
//  LearningGame_v0
//
//  Created by Alperen on 14.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import Foundation
import SQLite

class DataBase {
    var dataBase: Connection!
    
    let kelimelerTable = Table("kelimeler")
    let kelimeId = Expression<Int>("id")
    let ingKelime = Expression<String>("İngilizce")
    let trKelime = Expression<String>("Türkçe")
    let kelimeTuru = Expression<String>("Türü")
    let ogrenmeSeviyesi = Expression<Int>("Seviye")
    let eklemeTarihi = Expression<Date>("Tarih")
    
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("kelimeler3").appendingPathExtension("sqlite3")
            let dataBase = try Connection(fileURL.path)
            self.dataBase = dataBase
            
            
        } catch {
            print(error)
        }
        
        let createTable = self.kelimelerTable.create { (table) in
            table.column(self.kelimeId, primaryKey: true)
            table.column(self.ingKelime, unique: true)
            table.column(self.trKelime)
            table.column(self.kelimeTuru)
            table.column(self.ogrenmeSeviyesi)
            table.column(self.eklemeTarihi)
             }
        do {
            try self.dataBase.run(createTable)
        } catch {
            print(error)
        }
        
        
    }
    
    
    
    
    
    
    func KelimeEkle(ingilizcesi ing: String, turkcesi tr: String, turu tur:String, tarihi tarih: Date) {
        
        let kelimeEkle = self.kelimelerTable.insert(self.ingKelime <- ing, self.trKelime <- tr, self.kelimeTuru <- tur, self.ogrenmeSeviyesi <- 1, self.eklemeTarihi <- tarih)
        do {
            try self.dataBase.run(kelimeEkle)
        } catch  {
            print(error)
        }
    }
    
    func ListeleTest() {
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
                print("NO: \(kelime[self.kelimeId]) İngilizce Kelime: \(kelime[self.ingKelime]) Türkçe Karşılığı: \(kelime[self.trKelime]) Türü: \(kelime[self.kelimeTuru])")
                var gunSayısı = Zaman(eklenenTarih: kelime[self.eklemeTarihi]).aradanGecenZaman
                print(gunSayısı)
            }
        } catch  {
            print(error)
        }
    }
    
    func IngVeTr() -> [String:String] {
        
        var ingToTr = [String:String]()
        
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
                ingToTr[kelime[self.ingKelime]] = kelime[self.trKelime]
            }
        } catch  {
            print(error)
        }
        return ingToTr
    }
    
}
