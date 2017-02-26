 //
//  DateLable.swift
//  kero_test_swift_1
//
//  Created by Kero on 2/22/17.
//  Copyright © 2017 Kero. All rights reserved.
//

import UIKit

class DateButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var date = Date()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addTarget(self, action: #selector( dateShowPicker(_:) ), for: UIControlEvents.touchUpInside)
//        self.date = Date()
//
//        self.setCurrentDate(self.date)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.addTarget(self, action: #selector( dateShowPicker(_:) ), for: UIControlEvents.touchUpInside)
//        self.date = Date()
//
//        self.setCurrentDate(self.date)
//    }
//    
    
    func setCurrentDate(_ date: Date){
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let txt = dateFormatter.string(from: self.date)

//        self.setAttributedTitle(nil , for: .normal)
//        self.setAttributedTitle(nil , for: .disabled)
//        self.setAttributedTitle(nil , for: .focused)
//        self.setAttributedTitle(nil , for: .highlighted)
//        self.setAttributedTitle(nil , for: .selected)
//        self.setAttributedTitle(nil , for: .application)
//        self.setAttributedTitle(nil , for: .reserved)
        
        self.setTitle(txt , for: .normal)
//        self.setTitle(txt , for: .disabled)
//        self.setTitle(txt , for: .focused)
//        self.setTitle(txt , for: .highlighted)
//        self.setTitle(txt , for: .selected)
//        self.setTitle(txt , for: .application)
//        self.setTitle(txt , for: .reserved)
        

        
    }
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        
//        self.addTarget(self, action: #selector( dateShowPicker(_:) ), for: UIControlEvents.touchUpInside)
//        self.date = Date()
//        
//        self.setCurrentDate(self.date)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector( dateShowPicker(_:) ), for: UIControlEvents.touchUpInside)
        self.date = Date()

        self.setCurrentDate(self.date)
        //dateTextInputPressed(self)
        
    }
    
    func dateShowPicker (_ sender:UIButton){
        
        //picker.cu
        DatePickerDialog().show( "Task Name", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: self.date, datePickerMode: .dateAndTime ) {
            (date, text) -> Void in
            if(date != nil && text != "" ){
                self.setCurrentDate(date!)
                
            }
        }
    }
}
