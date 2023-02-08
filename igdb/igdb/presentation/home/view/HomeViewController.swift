//
//  
//  HomeViewController.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//
//  Created by Cristian Contreras 
//
import SwiftUI
import Rswift

struct HomeViewController: View {
    @StateObject private var viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)        
    }
    
    // MARK: - Body
    
    var body: some View {
        HomeCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        ZStack {
            switch viewModel.state {
            case .idle, .loading: splashView()
            case .failed(_): Text("Failed....")
            case .result(let value):
                generalView(home: value)
            }
        }.onAppear {
            viewModel.launchLoading()
        }
    }
    
    private func generalView(home: Home) -> some View {
        VStack {
            switch home.status {
            case .splash:
                splashView()
            case .home:
                homeView()
            }
        }
    }
    
    internal func homeView() -> some View {
        Text("HOME")
    }
    
    internal func splashView() -> some View {
        ZStack {
            if ($viewModel.showWelcome.wrappedValue) {
                welcomeView()
            } else {
                Image(imageResource: R.image.backgroundSplash)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack {
                    Spacer()
                    Text(R.string.localizable.splashViewControllerTitle())
                        .font(Font.dum.titleSplash).padding(.horizontal, 34)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
            }
        }
    }
    
    
    internal func welcomeView() -> some View {
        VStack {
            HStack {
                GeometryReader { geometry in
                    Image(imageResource: R.image.welcomeTop)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }.ignoresSafeArea()
            }
            Text(R.string.localizable.welcomeViewControllerTitle())
                .font(Font.dum.titleWelcome)
                .padding(.top, medium)
                .padding(.horizontal, medium)
            GeometryReader { geometry in
                ScrollView {
                    Text("Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.")
                        .lineLimit(nil)
                        .frame(width: geometry.size.width)
                }
            }.padding()
            Button(R.string.localizable.welcomeViewControllerButtonNext(),
                   action: {
                viewModel.welcomeShowed()
            })
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController(
            viewModel: HomeViewModel(
                useCase: HomeUseCase()))
    }
}

struct HomeNavViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController(
            viewModel: HomeViewModel(
                useCase: HomeUseCase())).homeView()
    }
}
