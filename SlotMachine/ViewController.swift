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
        
        // Randomly select emojis for each slot
        let randomEmojis1 = emojis.randomElement()!
        let randomEmojis2 = emojis.randomElement()!
        let randomEmojis3 = emojis.randomElement()!
        
        // Animate emojis with random selections
        animateEmojis(emoji1: randomEmojis1, emoji2: randomEmojis2, emoji3: randomEmojis3)
    }
    
    private func animateEmojis(emoji1: String, emoji2: String, emoji3: String) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.emoji1Label.alpha = 0
            self.emoji2Label.alpha = 0
            self.emoji3Label.alpha = 0
        }) { _ in
            self.emoji1Label.text = emoji1
            self.emoji2Label.text = emoji2
            self.emoji3Label.text = emoji3
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.emoji1Label.alpha = 1
                self.emoji2Label.alpha = 1
                self.emoji3Label.alpha = 1
            }) { _ in
                self.stopSpinning()
            }
        }
    }
    
    private func stopSpinning() {
        isSpinning = false
        startButton.isEnabled = true
        
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
