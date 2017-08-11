//
//  FirstViewController.swift
//  egasa
//
//  Created by rosario on 7/27/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import GlyuckDataGrid

class TurbinaViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    
    @IBOutlet weak var gifIamgeView: UIImageView!
    
    @IBOutlet weak var dataGridView: DataGridView!
    
    @IBOutlet weak var lblTurbina: UILabel!
    
    var cabeceras = ["Central", "Tiempo", "Diseno", "Porcentaje"]
    
    let datos = [
        ["C.H. 5","85.11", "1145.35", "58.35 %"],
        ["C.T.P ","71.46", "74.80", "95.2 %"],
        ["C.T.C ","9.86", "32.81", "29.98 %"]
     ]

    static override func initialize() {
        super.initialize()
        
        let dataGridAppearance = DataGridView.glyuck_appearanceWhenContained(in: self)!
        dataGridAppearance.row1BackgroundColor = nil
        dataGridAppearance.row2BackgroundColor = nil
        
        let cornerHeaderAppearance = DataGridViewCornerHeaderCell.glyuck_appearanceWhenContained(in: self)!
        cornerHeaderAppearance.backgroundColor = UIColor.white
        cornerHeaderAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        cornerHeaderAppearance.borderRightWidth = 1 / UIScreen.main.scale
        cornerHeaderAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
 
        /*let rowHeaderAppearance = DataGridViewRowHeaderCell.glyuck_appearanceWhenContained(in: self)!
        rowHeaderAppearance.backgroundColor = UIColor(white: 0.95, alpha: 1)
        rowHeaderAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        rowHeaderAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        */
        let columnHeaderAppearance = DataGridViewColumnHeaderCell.glyuck_appearanceWhenContained(in: self)!
        columnHeaderAppearance.borderRightWidth = 1 / UIScreen.main.scale
        columnHeaderAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
        
        let cellAppearance = DataGridViewContentCell.glyuck_appearanceWhenContained(in: self)!
        cellAppearance.borderRightWidth = 1 / UIScreen.main.scale
        cellAppearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
        cellAppearance.borderBottomWidth = 1 / UIScreen.main.scale
        cellAppearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        
        
        columnHeaderAppearance.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let labelAppearance = UILabel.glyuck_appearanceWhenContained(in: self)!
        labelAppearance.appearanceFont = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        labelAppearance.appearanceTextAlignment = .center
    }
    
    override func viewDidLoad() {
        self.gifIamgeView.image = UIImage.gif(name: "turbina")
        //dataGridView.dataSource = self
        
        //dataGridView.delegate = self
        dataGridView.dataSource = self
        lblTurbina.appearanceFont = UIFont.systemFont(ofSize: 30)
        dataGridView.rowHeaderWidth = 0
        dataGridView.columnHeaderHeight = 30
    }
    
    
    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return datos.count
    }
    
    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return cabeceras.count
    }
    
    // Then you'll need to provide titles for columns headers
    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        print("aquiii")
        
        return String("hi")
    }
    
    // And rows headers
    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        print(column)
        return cabeceras[column]
    }
    
    func dataGridView(_ dataGridView: DataGridView, textForCellAtIndexPath indexPath: IndexPath) -> String {
        return datos[indexPath.dataGridRow][indexPath.dataGridColumn]
        //return String((indexPath.dataGridRow + 1 ) * (indexPath.dataGridColumn + 1))
    }
    
    @IBAction func btnCerrarSesion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

