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
        setBackButtonUI()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension iCodeHomeVC {
    private func setBackButtonUI() {
        let buttonImage = UIImage(systemName: "arrowshape.backward.circle.fill")
        var config = UIButton.Configuration.borderless()
        config.image = buttonImage
        config.buttonSize = .large
        config.imagePadding = .zero
        config.contentInsets =  NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        backButton.configuration = config
        backButton.addSymbolEffect(.pulse.byLayer)
    }
}
