//
//  TestEtView.swift
//  LearningGame_v0
//
//  Created by Alperen on 12.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit

class TestEtView: UIViewController {
    
    let db = DataBase()
    
    var turkceDizisi = [String]()
    var ingilizceDizisi = [String]()
    var ingVeTrSozluk = [String:String]()
    var buttonRandomIndex = [0, 1, 2, 3]
    var olanSayılar = [Int]()
    
    
    @IBOutlet var KelimeButtonları: [UIButton]!
    
    @IBAction func KelimeBasButton(_ sender: UIButton) {
        
        let buttonIndex = KelimeButtonları.index(of: sender)
        if ingVeTrSozluk[IngilizceKelimeLabel.text!] == KelimeButtonları[buttonIndex!].currentTitle {
                print("correct answer")
                
                
            }
       
        
    }
    @IBOutlet weak var IngilizceKelimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        IngilizceKelimeLabel.layer.masksToBounds = true
        IngilizceKelimeLabel.layer.cornerRadius = 25
        
        for button in KelimeButtonları {
            button.layer.cornerRadius = 25
        }
        
        olanSayılar.removeAll()
        
        
        buttonRandomIndex.shuffle()
        
        ingVeTrSozluk = db.IngVeTr()
        for (key, value) in ingVeTrSozluk {
            self.turkceDizisi.append(value)
            self.ingilizceDizisi.append(key)
        }
        let kelimeSayısı = ingilizceDizisi.count
        let rasgeleSayı: Int = Int(arc4random_uniform(UInt32(kelimeSayısı)))
        IngilizceKelimeLabel.text = ingilizceDizisi[rasgeleSayı]
        
        
        olanSayılar += [rasgeleSayı]

        KelimeButtonları[buttonRandomIndex[0]].setTitle(turkceDizisi[rasgeleSayı], for: .normal)
        KelimeButtonları[buttonRandomIndex[1]].setTitle(turkceDizisi[randomNumara(olanSayılar: olanSayılar)], for: .normal)
        KelimeButtonları[buttonRandomIndex[2]].setTitle(turkceDizisi[randomNumara(olanSayılar: olanSayılar)], for: .normal)
        KelimeButtonları[buttonRandomIndex[3]].setTitle(turkceDizisi[randomNumara(olanSayılar: olanSayılar)], for: .normal)
        
    }
  
    @IBAction func GeriButton(_ sender: UIBarButtonItem) {
        self.viewDidLoad()
    }
    
    func randomNumara(olanSayılar: [Int]) -> Int {
        let kelimeSayısı = turkceDizisi.count
        var rasgeleSayım = Int(arc4random_uniform(UInt32(kelimeSayısı)))
        for numara in 0...olanSayılar.count - 1 {
            if rasgeleSayım == olanSayılar[numara] {
                repeat {
                    rasgeleSayım = Int(arc4random_uniform(UInt32(kelimeSayısı)))
                } while rasgeleSayım == olanSayılar[numara]
            }
        }
        
        self.olanSayılar += [rasgeleSayım]
        return rasgeleSayım
        
    }
    
    

    func TestEt(isTrue: Bool) {
        /* MARK: Butona Bastığında
    eğer bildiyse 2 sn bekletip butonun rengi değişicek ve id bulma metodu ile öğrenme seviyesini arttırma metodu
 çağırılıcak bilemediyse 2 sn bekletip butonun rengi değişicek ve id bulma metodu ile öğrenme seviyesini sıfırlama metodu
 çağırılacak */
 
    }

}
