//
//  ContentView.swift
//  Cats Facts
//
//  Created by Shaya H on 03/06/26.
//

import SwiftUI

struct CatFact: Codable { //estrutura para ler o JSON
    let fact: String
}

struct ContentView: View {
    
    @State private var fato = "Nenhum fato carregado" // variável de estado
    
    var body: some View {
        VStack { // (ou EMPILHARV em português) permite juntar dois ou mais conjuntos de dados empilhando-os verticalmente, um abaixo do outro.
            Text(fato)
            
            Button("Buscar fato") {
                buscarFato()
                
            }
        }
        .padding()
    }
    
    

    
    
    func buscarFato() {
        let url = URL(string: "https://catfact.ninja/fact")! //isso é a forma como eu acesso a API
        //fact é um endpoint (a porta de acesso)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
         
            guard let data = data else { return } //ve se esta vazio
            
            if let resultado = try? JSONDecoder().decode(CatFact.self, from: data) {
                
                DispatchQueue.main.async {
                    //fato = resultado.fact //comentario
                    fato = resultado.fact //comentario
                    // Oi Cheguei
                }
            }
            
        }.resume()
        /oiiii
    }
    
}

#Preview {
        ContentView()
    }
    

