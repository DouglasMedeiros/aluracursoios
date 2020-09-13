//
//  ViagemDao.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire

class ViagemDao: NSObject {
    func retornaTodasAsViagens(completed: @escaping (Viagens) -> Void) {
        let request = AF.request("https://backend-formacao.herokuapp.com/viagens")
        request.responseDecodable { (data: DataResponse<Viagens, AFError>) in
            completed(data.value ?? [])
        }
    }
}
