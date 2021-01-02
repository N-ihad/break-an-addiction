//
//  Utilities.swift
//  Break an Addiction
//
//  Created by Nihad on 12/12/20.
//

import UIKit

class Utilities {
    
    enum hintImageStyle: String {
        case thick = "thick"
        case medium = "medium"
        case thin = "thin"
        case normal = "hint"
    }
    
    enum textFieldPlaceholder: String {
        case trigger = "Enter trigger here"
        case relapse = "Enter substitute reaction here"
    }
    
    enum tagViewCaptionText: String {
        case trigger = "Choose or add your own trigger which leads you to a relapse"
        case solution = "Choose a healthy response to the trigger instead of a relapse"
        case motivationalQuote = "“The resistance that you fight physically in the gym and the resistance that you fight in life can only build a strong character.” Arnold Schwarzenegger"
    }
    
    func button(text: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.dropShadow(color: .black, opacity: 0.75, offSet: CGSize.zero, radius: 8)
        btn.setDimensions(width: btn.frame.width + 80, height: 38)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return btn
    }
    
    func label(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.41])
        
        return lbl
    }
    
    func labelCaption(text: tagViewCaptionText, highlightAndUnderlineSubstring: String? = nil) -> UILabel {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.attributedText = NSMutableAttributedString(string: text.rawValue, attributes: [NSAttributedString.Key.kern: -0.41])
        if let substr = highlightAndUnderlineSubstring {
            lbl.highlightAndUnderline(searchedText: substr)
        }
        
        return lbl
    }
    
    func labelInstruction(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.preferredMaxLayoutWidth = (UIScreen.main.bounds.width / 2) - 20
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .white
        lbl.layer.cornerRadius = 6
        lbl.layer.borderColor = UIColor.themeOrange.cgColor
        lbl.layer.borderWidth = 2
        lbl.setMargins()
        
        return lbl
    }
    
    func alertWithTextfields(caption: String, placeholders: [textFieldPlaceholder], completion: @escaping ([String]) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: caption, message: "", preferredStyle: UIAlertController.Style.alert)
        
        for placeholder in placeholders {
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = placeholder.rawValue
            }
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { alert -> Void in
            var textFieldsValues = [String]()
            for i in 0..<placeholders.count {
                textFieldsValues.append((alertController.textFields![i] as UITextField).text ?? "")
            }
            completion(textFieldsValues)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    func alertError(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}

