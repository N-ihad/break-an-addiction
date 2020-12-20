//
//  RelapseVC.swift
//  Break an Addiction
//
//  Created by Nihad on 12/15/20.
//

import UIKit

class RelapseVC: UIViewController {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+700)
        
        return scrollView
    }()
    
    private let whenRelapseHappenedDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .white
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        datePicker.addTarget(self, action: #selector(handleDatePickerChangedValue), for: UIControl.Event.valueChanged)
        
        return datePicker
    }()
    
    private let triggersTagCaptionLabel: UILabel = {
        let lbl = Utilities().labelCaption(text: .trigger, highlightAndUnderlineSubstring: "trigger")
        
        return lbl
    }()
    
    private let triggersView = TagView(frame: .zero, initializeWith: AddictionService.shared.getTriggers())
    
    private let solutionsTagCaptionLabel: UILabel = {
        let lbl = Utilities().labelCaption(text: .solution, highlightAndUnderlineSubstring: "trigger")
        
        return lbl
    }()
    
    private var relapseDateInString: String = ""
    private var relapseDate: Date = Date()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDatePickerChangedValue(sender: UIDatePicker) {
//        AddictionService.shared.addRelapse(date: sender.date, instruction: nil, trigger: nil)
        relapseDateInString = sender.date.toString
        relapseDate = sender.date
        
    }
    
    @objc func resetButtonPressed() {
        AddictionService.shared.addRelapse(date: relapseDate, instruction: nil, trigger: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .themeDarkGreen
        
        configureSubviews()
        configureDatePicker()
        configureNavBar()
    }
    
    func configureDatePicker() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        relapseDateInString = formatter.string(from: whenRelapseHappenedDatePicker.date)
    }
    
    func configureSubviews() {
        self.view.addSubview(scrollView)
        scrollView.pinTo(view)
        
        let stack = UIStackView(arrangedSubviews: [whenRelapseHappenedDatePicker, triggersTagCaptionLabel, triggersView])
        stack.axis = .vertical
        stack.spacing = 20;
        
        scrollView.addSubview(stack)
        stack.centerX(inView: scrollView, topAnchor: scrollView.topAnchor, paddingTop: 30)
    }
    
    func configureNavBar() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
        let resetItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetButtonPressed))
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = resetItem
    }
    
}
