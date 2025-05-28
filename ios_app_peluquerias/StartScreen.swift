import SwiftUI

struct StartScreen: View {
    @State private var navigateToLogin = false
    @State private var tipoUsuarioGlobal: String = "cliente"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 28/255, green: 45/255, blue: 60/255)
                    .ignoresSafeArea()

                VStack(spacing: 32) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)

                    VStack(spacing: 16) {
                        Button(action: {
                            tipoUsuarioGlobal = "cliente"
                            navigateToLogin = true
                        }) {
                            Text("Soy cliente")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 1.0, green: 0.42, blue: 0.55)) // Rosa
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }

                        Button(action: {
                            tipoUsuarioGlobal = "empresa"
                            navigateToLogin = true
                        }) {
                            Text("Soy empresa")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 24)

                    // Navegación a LoginScreen.swift
                    NavigationLink(destination: LoginScreen(tipoUsuario: tipoUsuarioGlobal), isActive: $navigateToLogin) {
                        EmptyView()
                    }
                }
            }
        }
    }
}
