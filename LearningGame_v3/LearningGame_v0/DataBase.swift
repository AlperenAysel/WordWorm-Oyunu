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
    // TODO: butonu ile birlikte silinicek
    func ListeleTest() {
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
                print("NO: \(kelime[self.kelimeId]) İngilizce Kelime: \(kelime[self.ingKelime]) Türkçe Karşılığı: \(kelime[self.trKelime]) Türü: \(kelime[self.kelimeTuru]) Öğrenme Seviyesi: \(kelime[self.ogrenmeSeviyesi])")
                let gunSayısı = Liste(eklenenTarih: kelime[self.eklemeTarihi]).aradanGecenZaman
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
                let gunSayısı = Liste(eklenenTarih: kelime[self.eklemeTarihi]).aradanGecenZaman
                
                SozlukleriEkleme(left: &ingToTr, right: Liste().bugununLİstesiniCıkar(aradanGecenGunSayısı: gunSayısı, ogrenmeSeviyesi: kelime[self.ogrenmeSeviyesi], ingKelime: kelime[self.ingKelime], trKelime: kelime[self.trKelime]))
            }
            
        } catch  {
            print(error)
        }
        
        return ingToTr
    }
    // TODO: Baglanıcak
    func ogrenilenKelimelerListesi() -> [Date:Int] {
        var ogrenilenKelimeler = [Date:Int]()
        
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
               SozlukleriEkleme(left: &ogrenilenKelimeler, right: Liste().OgrenilenKelimeListesi(eklenenTarih: kelime[self.eklemeTarihi], ogrenmeSeviyesi: kelime[self.ogrenmeSeviyesi]))
            }
            
        } catch  {
            print(error)
        }
        return ogrenilenKelimeler
    }
    
    func SozlukleriEkleme <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
    
    func OgrenmeSeviyesiniArttır(ogrenilenIngKelimeId: Int) {
        let degistirilmeTarihi = Date()
        let degisecekKelimeId = self.kelimelerTable.filter(self.kelimeId == ogrenilenIngKelimeId)
        let kelimeGuncelle = degisecekKelimeId.update(self.ogrenmeSeviyesi <- self.ogrenmeSeviyesi+1, self.eklemeTarihi <- degistirilmeTarihi)
        do {
            try self.dataBase.run(kelimeGuncelle)
        } catch  {
            print(error)
        }
    }
    func OgrenmeSeviyesiSıfırla(sifirlanacakKelimeId: Int) {
        let degistirilmeTarihi = Date()
        let degisecekKelimeId = self.kelimelerTable.filter(self.kelimeId == sifirlanacakKelimeId)
        let kelimeGuncelle = degisecekKelimeId.update(self.ogrenmeSeviyesi <- 1, self.eklemeTarihi <- degistirilmeTarihi)
        do {
            try self.dataBase.run(kelimeGuncelle)
        } catch  {
            print(error)
        }
    }
    func KelimeIdBulma(idBulunucakKelime: String) -> Int {
        
        var bulunanId = Int()
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
                if kelime[self.ingKelime] == idBulunucakKelime {
                    bulunanId = kelime[self.kelimeId]
                }
            }
            
        } catch  {
            print(error)
        }
        return bulunanId
    }
    func TurkceKelimeler() -> [String] {
        var trListe = [String]()
        do {
            let kelimeler = try self.dataBase.prepare(kelimelerTable)
            for kelime in kelimeler {
                trListe.append(kelime[self.trKelime])
            }
        } catch  {
            print(error)
        }
        return trListe
    }
    
}
