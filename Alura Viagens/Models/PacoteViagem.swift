//
//  PacoteViagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

typealias PacotesViagens = [PacoteViagem]

struct PacoteViagem: Codable {
    
    let id: Int
    let nomeDoHotel: String
    let descricao: String
    let dataViagem: String
    
    let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let caminhoDaImagem: String
    let localizacao: String
    
    func viagem() -> Viagem {
        return Viagem(titulo: titulo, quantidadeDeDias: quantidadeDeDias, preco: preco, caminhoDaImagem: caminhoDaImagem, localizacao: localizacao)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nomeDoHotel
        case descricao = "servico"
        case dataViagem = "data"
        
        case titulo, quantidadeDeDias, preco
        case caminhoDaImagem = "imageUrl"
        case localizacao = "localizacao"
    }
    
    
}
