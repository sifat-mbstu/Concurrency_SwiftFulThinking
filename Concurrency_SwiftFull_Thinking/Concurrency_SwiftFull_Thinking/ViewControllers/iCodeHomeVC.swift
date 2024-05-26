//
//  iCodeHomeVC.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 5/26/24.
//

import UIKit

class iCodeHomeVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(systemName: "arrowshape.backward.circle")
        var cfg = UIButton.Configuration.bordered()
        cfg.image = image
        backButton.configuration = cfg
        backButton.addSymbolEffect(.pulse)    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
