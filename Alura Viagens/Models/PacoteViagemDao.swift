//
//  PacoteViagemDao.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire

class PacoteViagemDao: NSObject {
    func retornaTodasAsViagens(completed: @escaping (PacotesViagens) -> Void) {
        let request = AF.request("https://backend-formacao.herokuapp.com/pacotes")
        request.responseDecodable { (data: DataResponse<PacotesViagens, AFError>) in
            completed(data.value ?? [])
        }
    }
}
