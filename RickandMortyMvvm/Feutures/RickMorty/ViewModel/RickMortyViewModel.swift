//
//  RickMortyViewModel.swift
//  RickandMortyMvvm
//
//  Created by Pınar Macit on 30.05.2022.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickMortyCharecters: [Result] { get set }
    var rickMortyService: IRickMortyService { get}
    
    var rickMortyOutput: RickMortyOutput? { get}
    
    func setDelegete(output: RickMortyOutput)
}

final class RickMortyViewModel: IRickMortyViewModel {
    
    var rickMortyOutput: RickMortyOutput?
    
    func setDelegete(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    
    var rickMortyCharecters: [Result] = []
    private var isloading = false
    let rickMortyService: IRickMortyService
    
    init() {
        rickMortyService = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickMortyCharecters = response ?? []
            self?.rickMortyOutput?.saveDatas(value: self?.rickMortyCharecters ?? [])
      }
    }
    
    func changeLoading() {
        isloading = !isloading
        rickMortyOutput?.changeLoading(isLoad: isloading)
    }
    
   
    
}
