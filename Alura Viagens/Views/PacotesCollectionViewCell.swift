//
//  PacotesCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreData

class PacotesCollectionViewCell: UICollectionViewCell {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    // MARK: - IBOutlets 
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var imagemViagem: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    
    var currentPacoteViagem: PacoteViagem? {
        didSet {
            let fetchRequest: NSFetchRequest<Favorito> = Favorito.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "identificador==\(Int64(currentPacoteViagem?.id ?? 0))")
            
            if let result = try? context.fetch(fetchRequest) {
                self.isFavorited = result.count > 0
            } else {
                self.isFavorited = false
            }
        }
    }
    // MARK: - Métodos
    
    var isFavorited: Bool = false {
        didSet {
            buttonFavorite?.setImage(UIImage(named: isFavorited ? "star-on" : "star-off"), for: .normal)
        }
    }
    
    func configuraCelula(_ pacoteViagem: PacoteViagem) {
        
        self.currentPacoteViagem = pacoteViagem
        
        let viagem = pacoteViagem.viagem()
        labelTitulo.text = viagem.titulo
        labelQuantidadeDias.text = "\(viagem.quantidadeDeDias) dias"
        labelPreco.text = "R$ \(viagem.preco)"
        
        AF.request(viagem.caminhoDaImagem).responseImage { response in
            if case .success(let image) = response.result {
                self.imagemViagem.image = image
            }
        }
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        layer.cornerRadius = 8
    }
    
    @IBAction func favorite() {
        guard let pacoteViagem = currentPacoteViagem else {
            return
        }
        
        if (!isFavorited) {
            let favorite = Favorito(context: context)
            favorite.identificador = Int64(pacoteViagem.id)
            favorite.nomeHotel = pacoteViagem.nomeDoHotel
            favorite.descricao = pacoteViagem.descricao
            favorite.dataViagem = pacoteViagem.dataViagem
            favorite.titulo = pacoteViagem.titulo
            favorite.quantidadeDias = Int64(pacoteViagem.quantidadeDeDias)
            favorite.preco = pacoteViagem.preco
            favorite.caminhoImagem = pacoteViagem.caminhoDaImagem
            favorite.localizacao = pacoteViagem.localizacao
        } else {
            let fetchRequest: NSFetchRequest<Favorito> = Favorito.fetchRequest()
            fetchRequest.predicate = NSPredicate.init(format: "identificador==\(Int64(pacoteViagem.id))")
            
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    context.delete(object)
                }
            }
        }
        
        isFavorited = !isFavorited
        
        try? context.save()
    }
}
