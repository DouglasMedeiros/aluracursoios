//
//  DetalhesViagemViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetalhesViagemViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var labelPrecoPacoteViagem: UILabel!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var textFieldData: UITextField!
    
    // MARK: - Atributos
    
    var pacoteSelecionado: PacoteViagem?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(redimensionaScrollView(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teste(_:)), name: .UIKeyboardDidHide, object: self)
        configuraOutlets()
    }
    
    // MARK: - Metodos
    
    func configuraOutlets() {
        guard let pacote = pacoteSelecionado else { return }
        let viagem = pacote.viagem()
        
        AF.request(viagem.caminhoDaImagem).responseImage { response in
            if case .success(let image) = response.result {
                self.imagemPacoteViagem.image = image
            }
        }
        
        labelTituloPacoteViagem.text = viagem.titulo
        labelDescricaoPacoteViagem.text = pacote.descricao
        labelDataViagem.text = pacote.dataViagem
        labelPrecoPacoteViagem.text = viagem.preco
    }
    
    @objc func redimensionaScrollView(_ notification: Notification) {
        if let frameTeclado: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            scrollViewPrincipal.contentSize = CGSize(width: scrollViewPrincipal.frame.width, height: scrollViewPrincipal.frame.height + frameTeclado.cgRectValue.height)
        }
    }
    
    @objc func teste(_ notification: Notification) {
        view.layoutIfNeeded()
    }
    
    @objc func exibeDataTextField(_ sender: UIDatePicker) {
        let formatador = DateFormatter()
        formatador.dateFormat = "dd MM yyyy"
        textFieldData.text = formatador.string(from: sender.date)
    }
    
    // MARK: - IBActions
    
    @IBAction func textFieldDataDidBegin(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(exibeDataTextField(_:)), for: .valueChanged)
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func botaoFinalizarCompra(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "confirmacaoPagamento") as! ConfirmacaoPagamentoViewController
        controller.pacoteComprado = pacoteSelecionado
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
