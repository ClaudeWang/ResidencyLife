//
//  SecondQuestionPageController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/31/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class SecondQuestionPageController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var picker: UIPickerView!
    @IBOutlet var questionField: UILabel!
    @IBOutlet var question1: UISlider!
    @IBOutlet var question2: UISlider!
    var pickerData = ["On vacation", "Postcall/worked overnight", "Working days"]
    //automatically hide the keyboard when touching other part of UI.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getQuestionField()->String {
        print(questionField.text)
        return questionField.text!
    }
    
    override func viewDidLoad() {
        question1.value = 0
        question2.value = 0
    }
    
    internal func collectResponse()->[String: String] {
        var response = [String: String]()
        response["Today I feel"] = String(Int(floor(question1.value * 100)))
        response["I'm burned out"] = String(Int(floor(question2.value * 100)))
        response["I\'m"] = pickerData[picker.selectedRowInComponent(0)]
        return response
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
