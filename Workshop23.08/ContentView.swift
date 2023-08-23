//
//  ContentView.swift
//  Workshop23.08
//
//  Created by Илья Шаповалов on 23.08.2023.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    typealias CocktailModelRequest = (Endpoint) -> AnyPublisher<CocktailModel, HTTPError>
    let fetchAllCocktails: CocktailModelRequest
    var cancellables: Set<AnyCancellable> = .init()
    
    @Published var cocktails: [Cocktail] = .init()
    
    init(fetchAllCocktails: @escaping CocktailModelRequest = ApiClient().downloadRequest(endpoint:)) {
        self.fetchAllCocktails = fetchAllCocktails
    }
    
    func fetchCocktails() {
        let endpoint = CocktailEndpoint()
        
        fetchAllCocktails(endpoint)
            .map(\.results)
            .compactMap { $0 }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$cocktails)
    }
    
    func handle(completion: Subscribers.Completion<HTTPError>) {
        switch completion {
        case .finished:
            print("Publisher finished!")
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func set(cocktails: CocktailModel) {
        self.cocktails = cocktails.results ?? []
    }
}

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            List {
                LazyVStack {
                    ForEach(vm.cocktails) { cocktail in
                        Text(cocktail.name ?? "unknown")
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: vm.fetchCocktails)
    }
}

#Preview {
    ContentView()
}
