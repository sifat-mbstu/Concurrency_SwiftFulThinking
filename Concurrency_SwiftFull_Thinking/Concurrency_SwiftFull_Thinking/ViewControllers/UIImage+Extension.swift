//
//  UIImage+Extension.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 5/26/24.
//

import UIKit

extension UIButton {
    private var imageView: UIImageView? {
        for subview in subviews {
            if let iv = subview as? UIImageView {
                return iv
            }
        }
        return nil
    }

    func addSymbolEffect(_ effect: some IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    func addSymbolEffect(_ effect: some DiscreteSymbolEffect & IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    func addSymbolEffect(_ effect: some DiscreteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    func removeSymbolEffect(ofType effect: some IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion:  completion)
    }

    func removeSymbolEffect(ofType effect: some DiscreteSymbolEffect & IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion:  completion)
    }

    func removeSymbolEffect(ofType effect: some DiscreteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion:  completion)
    }

    func removeAllSymbolEffects(options: SymbolEffectOptions = .default, animated: Bool = true) {
        imageView?.removeAllSymbolEffects(options: options, animated: animated)
    }
}
