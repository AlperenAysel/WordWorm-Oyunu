//
//  TestYapStartView.swift
//  LearningGame_v0
//
//  Created by Alperen on 12.03.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit

class TestYapStartView: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var VazgecButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        StartButton.layer.cornerRadius = 0.5 * StartButton.bounds.size.width
        VazgecButton.layer.cornerRadius = 0.5 * VazgecButton.bounds.size.width

       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
