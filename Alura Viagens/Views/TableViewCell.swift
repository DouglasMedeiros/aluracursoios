//
//  TableViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell {
    
    var parentViewController: ViewController!
    
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imagemViagem: UIImageView!
    
    var currentViagem: Viagem?
    
    @objc func longPressDisplayMap(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let mapViewController: MapaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
            mapViewController.address = currentViagem?.localizacao
            parentViewController.navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
    func addGesture() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressDisplayMap))
        recognizer.minimumPressDuration = 1.0
        self.contentView.addGestureRecognizer(recognizer)
    }
    func configuraCelula(_ viagem:Viagem) {
        
        addGesture()
        
        currentViagem = viagem
        
        labelTitulo.text = viagem.titulo
        labelQuantidadeDias.text = viagem.quantidadeDeDias == 1 ? "1 dia" : "\(viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(viagem.preco)"
        
        imagemViagem.layer.cornerRadius = 10
        
        AF.request(viagem.caminhoDaImagem).responseImage { response in
            if case .success(let image) = response.result {
                self.imagemViagem.image = image
            }
        }
    }
}
