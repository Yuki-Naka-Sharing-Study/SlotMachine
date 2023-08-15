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
    
    let emojis = ["🍎", "🍊", "🍒", "🍇", "🍓"] // Add more emojis as needed
    var isSpinning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !isSpinning {
            startSpinning()
        }
    }
    
    func startSpinning() {
        isSpinning = true
        startButton.isEnabled = false
        
        // Randomly select emojis
        let randomEmojis = (0..<emojis.count).map { _ in emojis.randomElement()! }
        
        // Animate emojis with random selections
        animateEmojis(emojis: randomEmojis, currentIndex: 0)
    }
    
    func animateEmojis(emojis: [String], currentIndex: Int) {
        UIView.animate(withDuration: 2, delay: 2, options: .curveLinear, animations: {
            self.emoji1Label.text = emojis[(currentIndex + 0) % emojis.count]
            self.emoji2Label.text = emojis[(currentIndex + 1) % emojis.count]
            self.emoji3Label.text = emojis[(currentIndex + 2) % emojis.count]
        }) { _ in
            if currentIndex < emojis.count * 3 { // Control the number of rotations
                self.animateEmojis(emojis: emojis, currentIndex: currentIndex + 1)
            } else {
                self.stopSpinning(finalEmoji: emojis[currentIndex % emojis.count])
            }
        }
    }
    
    func stopSpinning(finalEmoji: String) {
        isSpinning = false
        startButton.isEnabled = true
        
        emoji1Label.text = finalEmoji
        emoji2Label.text = finalEmoji
        emoji3Label.text = finalEmoji
        
        if emoji1Label.text == emoji2Label.text && emoji2Label.text == emoji3Label.text {
            showAlert(message: "当たり！")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
