//
//  TestEtView.swift
//  LearningGame_v0
//
//  Created by Alperen on 12.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit

class TestEtView: UIViewController {
    
    
    @IBOutlet weak var IngilizceKelimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        IngilizceKelimeLabel.layer.masksToBounds = true
        IngilizceKelimeLabel.layer.cornerRadius = 25
        IngilizceKelimeLabel.text = "kelime"

    }
    
    
    

   

}
