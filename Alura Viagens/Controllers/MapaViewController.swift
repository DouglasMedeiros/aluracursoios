//
//  MapaViewController.swift
//  Alura Viagens
//
//  Created by Douglas Medeiros on 12/09/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    @IBOutlet weak var labelAddress: UILabel!
    
    var address: String?
    
    @IBOutlet weak var mapa: MKMapView!
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLGeocoder().geocodeAddressString(address ?? "") { (place, error) in
            
            self.labelAddress.text = place?.first?.name
            
            let point = MKPointAnnotation()
            point.subtitle = self.address ?? ""
            point.title = place?.first?.name
            guard let coordinate = place?.first?.location?.coordinate else {
                return
            }
            point.coordinate = coordinate
            
            let annotation = MKMapPointForCoordinate(coordinate)
            self.mapa.setVisibleMapRect(MKMapRectMake(annotation.x, annotation.y, 0.1, 0.1), animated: true)
            
            self.mapa.addAnnotation(point)
        }
    }
}
