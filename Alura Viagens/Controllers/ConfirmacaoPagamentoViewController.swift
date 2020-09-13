//
//  ConfirmacaoPagamentoViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ConfirmacaoPagamentoViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelHotelPacoteViagem: UILabel!
    @IBOutlet weak var labelDataPacoteViagem: UILabel!
    @IBOutlet weak var labelQuantidadePessoas: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    @IBOutlet weak var botaoVoltarHome: UIButton!
    
    // MARK: - Atributos
    
    var pacoteComprado: PacoteViagem?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraOutlets()
    }
    
    // MARK: - Metodos
    
    func configuraOutlets() {
        guard let pacote = pacoteComprado else { return }
        
        let viagem: Viagem = pacote.viagem()
        
        AF.request(viagem.caminhoDaImagem).responseImage { response in
            if case .success(let image) = response.result {
                self.imagemPacoteViagem.image = image
            }
        }
        
        labelHotelPacoteViagem.text = pacote.nomeDoHotel
        labelTituloPacoteViagem.text = viagem.titulo.uppercased()
        labelDataPacoteViagem.text = pacote.dataViagem
        labelDescricaoPacoteViagem.text = pacote.descricao
        
        imagemPacoteViagem.layer.cornerRadius = 10
        imagemPacoteViagem.layer.masksToBounds = true
        botaoVoltarHome.layer.cornerRadius = 8
    }
    
    // MARK: - IBActions
    
    @IBAction func botaoVoltarHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
