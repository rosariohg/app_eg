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
import NVActivityIndicatorView

class TurbinaViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    
    @IBOutlet weak var gifIamgeView: UIImageView!
    
    @IBOutlet weak var dataGridView: DataGridView!
    
    @IBOutlet weak var lblTurbina: UILabel!
    
    var cabeceras = ["Central", "Tiempo", "Diseño", "Porcentaje"]
    
    var datos = [[String]]()
    
    /*let datos = [
        ["C.H. 5","85.11", "1145.35", "58.35 %"],
        ["C.T.P ","71.46", "74.80", "95.2 %"],
        ["C.T.C ","9.86", "32.81", "29.98 %"]
    ]*/
    
    //var data : [[String]] = [[]]
    
    var timer : Timer?
    
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
    
    func parse() {
        let urlCompleto = "http://45.76.173.130:9090/"
        let objUrl = URL(string: urlCompleto)
        var data = [[String]]()

        print("iniciando llamada")
        let str = URLSession.shared.dataTask(with: objUrl!) {
            dats, codigoHTTP, error in
            if error != nil {
                print(error!)
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: dats!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    data = json["data"] as!  [[String]]
                    self.datos = data
                    DispatchQueue.main.async(){
                        //code
                        self.dataGridView.reloadData()
                        
                    }
                    
                }
                catch{
                    print("Hubo un error")
                }
            }
        }
        str.resume()
    }
    
    override func viewDidLoad() {
        self.gifIamgeView.image = UIImage.gif(name: "turbina")
        
        //dataGridView.dataSource = self
        dataGridView.delegate = self
        dataGridView.dataSource = self
        lblTurbina.appearanceFont = UIFont.systemFont(ofSize: 30)
        dataGridView.rowHeaderWidth = 0
        dataGridView.columnHeaderHeight = 30
                
        parse()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(parse), userInfo: nil, repeats: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    
    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return datos.count
    }
    
    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int {
        return cabeceras.count
    }
    
    // Then you'll need to provide titles for columns headers
    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return String("hi")
    }
    
    // And rows headers
    func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
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

