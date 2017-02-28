 //
//  DateLable.swift
//  kero_test_swift_1
//
//  Created by Kero on 2/22/17.
//  Copyright © 2017 Kero. All rights reserved.
//

import UIKit
 

@IBDesignable
class DateButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var didChangeDateHandler :  ((Date) -> ()?)? = nil

    public enum PickerType : Int{
        case DateTime = 0
        case Date = 1
        case Time = 2
    }
    
    
    
    @IBInspectable var pickerType : PickerType = .DateTime

    
    var date: Date? = nil


    
    func setCurrentDate(_ date: Date?){
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        if(pickerType == .Date){
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        else if(pickerType == .Time){
            dateFormatter.dateFormat = "hh:mm a"
        }
        if(self.date == nil){
            self.setTitle("not set" , for: .normal)

        }else{
            let txt = dateFormatter.string(from: self.date!)
            self.setTitle(txt , for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector( dateShowPicker(_:) ), for: UIControlEvents.touchUpInside)
        self.date = Date()

        self.setCurrentDate(self.date!)
        
    }
    
    func dateShowPicker (_ sender:UIButton){
        var mode : UIDatePickerMode =  .dateAndTime
        if(pickerType == .Date){
            mode = .date
        }
        else if(pickerType == .Date){
            mode = .time
        }
        
        var date_1 = self.date
        //picker.cu
        if(date_1 == nil){
            date_1 = Date()
        }
        DatePickerDialog().show( "Task Name", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: date_1!, datePickerMode: mode ) {
            (date, text) -> Void in
            if(date != nil && text != "" ){
                self.setCurrentDate(date!)
                self.didChangeDateHandler?(self.date!)
            }
        }
    }
}
