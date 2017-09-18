//
//  HistoricoViewController.swift
//  egasa
//
//  Created by rosario on 8/1/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import Charts


class HistoricoViewController: UIViewController {
    
    @IBOutlet weak var imgIma1: UIImageView!
    @IBOutlet weak var imgIma2: UIImageView!
    @IBOutlet weak var imgIma3: UIImageView!
    
    var fecha_array = [String]()
    var potencia_array = [Double]()
    var frecuencia_array = [Double]()
    
    var datos = [[String]]()
    
    var turbina_selec = ""
    var fecha_selec = ""
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        parse(turb: turbina_selec, fecha: fecha_selec)
    }
    
    func parse(turb: String, fecha : String) {
        let fecha_ = fecha.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlCompleto = "http://45.76.173.130:9090/historico?turbina=\(turb)&fecha=\(fecha_!)"
        let objUrl = URL(string: urlCompleto)
        //var data = [[String]]()
        
        print("---------------")
        print(urlCompleto)
        
        let str = URLSession.shared.dataTask(with: objUrl!) {
            dats, codigoHTTP, error in
            if error != nil {
                print(error!)
            }else{
                do{
                    print("gettedd")
                    let json = try JSONSerialization.jsonObject(with: dats!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let dato_imagen = json["data"] as! [String]
                    let size = json["size"] as! Int
                    print("-------size------")
                    print(size)
                    DispatchQueue.main.async(){
                        var cont = 1
                        for i in dato_imagen{
                            //let imageData : Data = i.data(using: .utf8)!
                            //let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
                            let data : Data = Data(base64Encoded: i, options: .ignoreUnknownCharacters)!
                            //let dataImage = UIImage(data: data)
                            let dataImage = UIImage(data: data)
                        
                            if cont == 1{
                                self.imgIma1.image = dataImage
                            }
                            if cont == 2{
                                self.imgIma2.image = dataImage
                            }
                            if cont == 3{
                                self.imgIma3.image = dataImage
                            }
                            print("------------------------++++++")
                            cont = cont + 1
                            // print(i)
                            
                        }
                        
                        self.activityIndicator.stopAnimating()
                        
                    }
                    
                }
                catch{
                    print("Hubo un error")
                }
            }
        }
        str.resume()
    }
    
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "charcani4_2", withExtension: "json") {
                let data = try Data(contentsOf: file)
                
                var count = 0
                if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [[String]] {
                    for i in json{
                        if count % 300 == 0{
                            fecha_array.append(i[0])
                            potencia_array.append(Double(i[1])!)
                            frecuencia_array.append(Double(i[2])!)
                        }
                        count += 1
                    }
                    
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
