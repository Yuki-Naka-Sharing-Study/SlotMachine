//
//  ViewController.swift
//  SlotMachine
//
//  Created by 仲優樹 on 2023/08/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slotLabel: UILabel!
    @IBOutlet weak var emoji1Label: UILabel!
    @IBOutlet weak var emoji2Label: UILabel!
    @IBOutlet weak var emoji3Label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    private let emojis = ["🍎", "🍊", "🍒", "🍇", "🍓"] // Add more emojis as needed
    private var isSpinning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isSpinning { return }
        
        startSpinning()
    }
    
    private func startSpinning() {
        isSpinning = true
        startButton.isEnabled = false
        
        // Randomly select emojis
        let randomEmojis = (0..<emojis.count).map { _ in emojis.randomElement()! }
        
        // Animate emojis with random selections
        animateEmojis(emojis: randomEmojis, currentIndex: 0)
    }
    
//    private func animateEmojis(emojis: [String], currentIndex: Int) {
//        UIView.animate(withDuration: 1, delay: 5, options: .curveLinear, animations: {
//            self.emoji1Label.text = emojis[(currentIndex + 0) % emojis.count]
//            self.emoji2Label.text = emojis[(currentIndex + 1) % emojis.count]
//            self.emoji3Label.text = emojis[(currentIndex + 2) % emojis.count]
//        }) { _ in //emojis.count * 3
//            if currentIndex < emojis.count { // Control the number of rotations
//                self.animateEmojis(emojis: emojis, currentIndex: currentIndex + 1)
//            } else {
//                self.stopSpinning(finalEmoji: emojis[currentIndex % emojis.count])
//            }
//        }
//    }
    
    private func animateEmojis(emojis: [String], currentIndex: Int) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.emoji1Label.alpha = 0
            self.emoji2Label.alpha = 0
            self.emoji3Label.alpha = 0
        }) { _ in
            self.emoji1Label.text = emojis[(currentIndex + 0) % emojis.count]
            self.emoji2Label.text = emojis[(currentIndex + 1) % emojis.count]
            self.emoji3Label.text = emojis[(currentIndex + 2) % emojis.count]
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.emoji1Label.alpha = 1
                self.emoji2Label.alpha = 1
                self.emoji3Label.alpha = 1
            }) { _ in
                if currentIndex < emojis.count {
                    self.animateEmojis(emojis: emojis, currentIndex: currentIndex + 1)
                } else {
                    self.stopSpinning(finalEmoji: emojis[currentIndex % emojis.count])
                }
            }
        }
    }
    
    private func stopSpinning(finalEmoji: String) {
        isSpinning = false
        startButton.isEnabled = true
        
        emoji1Label.text = finalEmoji
        emoji2Label.text = finalEmoji
        emoji3Label.text = finalEmoji
        
        if emoji1Label.text == emoji2Label.text && emoji2Label.text == emoji3Label.text {
            showAlert(message: "当たり！")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
