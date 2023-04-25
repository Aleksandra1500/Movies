//
//  SearchView.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack {
                if texts.count > 0 {
                    List {
                        ForEach(texts) {text in
                            NavigationLink(
                                destination: ScrollView{Text(text.content).textSelection(.enabled)},
                                label: {
                                    Text(text.content).lineLimit(1)
                                })
                        }
                    }
                }
                else if (searchText.isEmpty) {
                    Text("Skorzystaj z wyszukiwarki lub zeskanuj tekst").font(.title)
                }
            }
            .navigationTitle("Wyszukaj film")
            
            .navigationBarItems(
                leading:
                    TextField("Wyszukaj film", text: $searchText)
                    .onSubmit {
                        Task {
                            await viewModel.searchForMovies(query: searchText)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    ,
                trailing:
                                    Button(action: {
                self.showScannerSheet = true
            }, label : {
                Image(systemName:
                        "doc.text.viewfinder")
                .font(.title)
            })
                                        .sheet(isPresented:
                                                $showScannerSheet, content: {
                makeScannerView()
            })
            )
            
            if viewModel.isLoading {
            } else {
                VStack {
                    searchResultsList(items: viewModel.searchResults)
                }
            }
        }
        
        
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }

            // search for movies
            self.searchText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            Task {
                await viewModel.searchForMovies(query: searchText)
            }
            
            self.showScannerSheet = false
        })
    }
}

func searchResultsList(items: [DashboardElement]) -> some View {
    VStack(alignment: .leading) {
        //        Text("Search Results")
        //            .font(.title2)
        //            .fontWeight(.bold)
        //            .padding(.leading, 10)
        //            .padding(.top, 10)
        
        Rectangle()
            .frame(width: 10, height: 1)
            .opacity(0)
        ForEach(items) { item in
            NavigationLink(destination: MovieDetailsView(movie: item)) {
                MovieSearchTile(item: item)
                    .padding(.horizontal, 10)
            }
        }
        Rectangle()
            .frame(width: 10, height: 1)
            .opacity(0)
    }
}

func MovieSearchTile(item: DashboardElement) -> some View {
    VStack(alignment: .leading) {
        HStack {
            if let backdropUrl = item.posterUrl {
                AsyncImage(url: URL(string: backdropUrl)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(4)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 75)
            }
            if let title = item.title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 12)
            }
        }
    }
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .topLeading
    )
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    // add grey border
    .cornerRadius(12)
    .border(Color.gray, width: 1)
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
