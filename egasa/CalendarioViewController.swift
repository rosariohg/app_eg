//
//  CalendarioViewController.swift
//  egasa
//
//  Created by rosario on 7/27/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import FSCalendar
import HAActionSheet

class CalendarioViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{

    @IBOutlet weak var calendar: FSCalendar!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    let data = ["Turbina 4",
                "Turbina 5"]
    
    let data_indices = ["4","5"]
    
    var turbina_seleccionada = ""
    
    var fecha_seleccionada = [String]()
    
    var fecha = ""
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let calendar = FSCalendar(frame: CGRect(x:0, y:0, width:320, height: 300))
       
        calendar.dataSource = self
        calendar.delegate = self
        
        view.addSubview(calendar)
        //self.calendar = calendar
        
        //let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        fecha_seleccionada = [formatter.string(from: date)]
        fecha = fecha_seleccionada[0]
        print(fecha)
        
        let vista = HAActionSheet(fromView: self.view, sourceData: data)
        //view.buttonCornerRadius = 30
        vista.center = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5 + 30)
        vista.show { (canceled,index) in
            if !canceled {
                //print(self.data[index!])
                self.turbina_seleccionada = self.data_indices[index!]
                print(self.turbina_seleccionada)
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar!, didSelectDate date: NSDate!) {
        print("------------------------------")
        print("did select date \(self.dateFormatter.string(from: date as Date))")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        fecha_seleccionada = calendar.selectedDates.map({formatter.string(from: $0)})
        fecha = fecha_seleccionada[0]
        print("selected dates is \(fecha)")
        
    }
    
    

}

