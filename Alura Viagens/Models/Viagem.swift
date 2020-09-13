//
//  Viagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

typealias Viagens = [Viagem]

struct Viagem: Codable {
    
    let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let caminhoDaImagem: String
    let localizacao: String
    
    init(titulo: String, quantidadeDeDias: Int, preco: String, caminhoDaImagem: String, localizacao: String) {
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.caminhoDaImagem = caminhoDaImagem
        self.localizacao = localizacao
    }

    enum CodingKeys: String, CodingKey {
       case titulo, quantidadeDeDias, preco, localizacao
       case caminhoDaImagem = "imageUrl"
    }
}
