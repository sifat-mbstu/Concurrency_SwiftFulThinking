//
//  14) iCodeConcurrency.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 5/26/24.
//

import UIKit
import SwiftUI

struct iCodeConcurrency: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let icodeStoryboard = UIStoryboard(name: "iCode", bundle: nil)
        guard let icodeHomeVC = icodeStoryboard.instantiateViewController(withIdentifier: "iCode") as? iCodeHomeVC else {
            fatalError()
        }
        icodeHomeVC.modalPresentationStyle = .fullScreen
        return icodeHomeVC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    
    }
}
