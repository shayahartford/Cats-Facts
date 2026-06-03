//
//  ContentView.swift
//  Cats Facts
//
//  Created by Shaya H on 03/06/26.
//

import SwiftUI

struct CatFact: Codable { // estrutura que representa o JSON recebido da API
    let fact: String // campo que queremos extrair do JSON
}

struct ContentView: View {

    @State private var fato = "Nenhum fato carregado" // variável observada pela interface; quando muda, a tela é atualizada automaticamente

    var body: some View {
        VStack { // empilha elementos verticalmente

            Text(fato) // exibe o valor atual da variável "fato"

            Button("Buscar fato") { // botão que executa uma ação ao ser clicado
                buscarFato()
            }
        }
        .padding() // adiciona um espaçamento nas bordas
    }

    func buscarFato() {

        let url = URL(string: "https://catfact.ninja/fact")!
        // cria uma URL apontando para a API
        // "fact" é o endpoint, ou seja, o caminho específico que fornece fatos sobre gatos

        URLSession.shared.dataTask(with: url) { data, response, error in
            // faz uma requisição HTTP para a API
            // essa operação acontece em segundo plano

            guard let data = data else { return }
            // verifica se algum dado foi recebido
            // se não recebeu nada, encerra a função

            if let resultado = try? JSONDecoder().decode(CatFact.self, from: data) {
                // converte o JSON recebido para a estrutura CatFact

                DispatchQueue.main.async {
                    // volta para a thread principal
                    // alterações na interface devem ser feitas aqui

                    fato = resultado.fact
                    // pega o texto recebido da API e atualiza a variável
                    // como "fato" é @State, a tela é redesenhada automaticamente
                }
            }

        }.resume()
        // inicia a requisição
        // sem isso, a requisição é criada mas nunca executada
    }
}

#Preview {
    ContentView() // mostra uma prévia da tela no Xcode
}
