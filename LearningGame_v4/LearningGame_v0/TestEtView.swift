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
    var olanSayilarim = [Int]()
    var dogruTurkce = [String]()
    
    
    
    
    @IBOutlet var KelimeButtonları: [UIButton]!
    
    @IBAction func KelimeBasButton(_ sender: UIButton) {
        
        let buttonIndex = KelimeButtonları.index(of: sender)
        if ingVeTrSozluk[IngilizceKelimeLabel.text!] == KelimeButtonları[buttonIndex!].currentTitle {
            TestEt(isTrue: true, buttonIndex: buttonIndex!)
            }
        else {
            TestEt(isTrue: false, buttonIndex: buttonIndex!)
        }
       
    }
    @IBOutlet weak var IngilizceKelimeLabel: UILabel!
    
    @IBOutlet weak var AcıklamaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IngilizceKelimeLabel.layer.masksToBounds = true
        IngilizceKelimeLabel.layer.cornerRadius = 25
        
        for button in KelimeButtonları {
            button.layer.cornerRadius = 25
        }
        
        turkceDizisi = db.TurkceKelimeler()
        ingVeTrSozluk = db.IngVeTr()
        if ingVeTrSozluk.isEmpty {
            
            for button in KelimeButtonları {
                button.isHidden = true
            }
            IngilizceKelimeLabel.isHidden = true
            AcıklamaLabel.text = " Bugün Öğrenilicek Kelime Yok!"
        }
        else {
        for (key, value) in ingVeTrSozluk {
            self.dogruTurkce.append(value)
            self.ingilizceDizisi.append(key)
        }
        
            
        let kelimeSayısı = ingilizceDizisi.count
        let rasgeleSayı: Int = Int(arc4random_uniform(UInt32(kelimeSayısı)))
        IngilizceKelimeLabel.text = ingilizceDizisi[rasgeleSayı]
        
        olanSayilarim.removeAll()
        buttonRandomIndex.shuffle()
        turkceDizisi.removeAll { $0 == dogruTurkce[rasgeleSayı] }

        KelimeButtonları[buttonRandomIndex[0]].setTitle(dogruTurkce[rasgeleSayı], for: .normal)
        KelimeButtonları[buttonRandomIndex[1]].setTitle(turkceDizisi[RandomNumber(olanSayilar: olanSayilarim)], for: .normal)
        KelimeButtonları[buttonRandomIndex[2]].setTitle(turkceDizisi[RandomNumber(olanSayilar: olanSayilarim)], for: .normal)
        KelimeButtonları[buttonRandomIndex[3]].setTitle(turkceDizisi[RandomNumber(olanSayilar: olanSayilarim)], for: .normal)
            
        }
    }
  
    @IBAction func GeriButton(_ sender: UIBarButtonItem) {
        self.viewDidLoad()
    }
    func RandomNumber(olanSayilar: [Int]) -> Int {
        var randomSayi = Int(arc4random_uniform(UInt32(turkceDizisi.count)))
        for sayi in olanSayilar {
            if sayi == randomSayi {
                while sayi == randomSayi {
                    randomSayi = Int(arc4random_uniform(UInt32(turkceDizisi.count)))
                }
            }
        }
        self.olanSayilarim.append(randomSayi)
        return randomSayi
    }
    
    func TestEt(isTrue: Bool, buttonIndex: Int) {
        if isTrue {
            print("correct answer")
            let id = db.KelimeIdBulma(idBulunucakKelime: IngilizceKelimeLabel.text!)
            db.OgrenmeSeviyesiniArttır(ogrenilenIngKelimeId: id)
            KelimeButtonları[buttonIndex].backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            KelimeButtonları[buttonIndex].setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.viewDidLoad()
                self.KelimeButtonları[buttonIndex].backgroundColor = #colorLiteral(red: 0.6937425137, green: 0.7284670472, blue: 0.9537917972, alpha: 1)
                self.KelimeButtonları[buttonIndex].setTitleColor(#colorLiteral(red: 0.1049376205, green: 0.1088921204, blue: 0.1458786726, alpha: 1), for: .normal)
            }
        }
        else {
            print("wrong answer")
            let id = db.KelimeIdBulma(idBulunucakKelime: IngilizceKelimeLabel.text!)
            db.OgrenmeSeviyesiSıfırla(sifirlanacakKelimeId: id)
            KelimeButtonları[buttonIndex].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.viewDidLoad()
                self.KelimeButtonları[buttonIndex].backgroundColor = #colorLiteral(red: 0.6937425137, green: 0.7284670472, blue: 0.9537917972, alpha: 1)
            }
        }
    }
    
    
 

}
