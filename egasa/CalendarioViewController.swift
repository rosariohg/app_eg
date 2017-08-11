//
//  CalendarioViewController.swift
//  egasa
//
//  Created by rosario on 7/27/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarioViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{

    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let calendar = FSCalendar(frame: CGRect(x:0, y:0, width:320, height: 300))
       
        calendar.dataSource = self
        calendar.delegate = self
        
        view.addSubview(calendar)
        //self.calendar = calendar
    }
    
    

}

