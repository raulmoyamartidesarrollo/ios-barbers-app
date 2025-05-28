import SwiftUI

struct RegistroNegocioScreen: View {
    @State private var nombreNegocio = ""
    @State private var telefono = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmarPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 45/255, blue: 60/255)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }

            VStack(spacing: 16) {
                Spacer()

                // LOGO y título
                VStack(spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)

                    Text("Crear Cuenta")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                }

                // Nombre del negocio
                TextField("Nombre del negocio", text: $nombreNegocio)
                    .padding()
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)

                // Teléfono
                TextField("Teléfono", text: $telefono)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)

                // Correo electrónico
                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)

                // Contraseña + Confirmar
                HStack(spacing: 8) {
                    ZStack(alignment: .trailing) {
                        Group {
                            if showPassword {
                                TextField("Contraseña", text: $password)
                            } else {
                                SecureField("Contraseña", text: $password)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                        .cornerRadius(8)

                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .padding(.trailing, 16)
                        }
                    }

                    ZStack(alignment: .trailing) {
                        Group {
                            if showConfirmPassword {
                                TextField("Confirmar", text: $confirmarPassword)
                            } else {
                                SecureField("Confirmar", text: $confirmarPassword)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                        .cornerRadius(8)

                        Button(action: {
                            showConfirmPassword.toggle()
                        }) {
                            Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .padding(.trailing, 16)
                        }
                    }
                }

                // Botón Crear cuenta
                Button(action: {
                    if nombreNegocio.isEmpty || telefono.isEmpty || email.isEmpty || password.isEmpty || confirmarPassword.isEmpty {
                        alertMessage = "Por favor completa todos los campos"
                        showAlert = true
                    } else if password != confirmarPassword {
                        alertMessage = "Las contraseñas no coinciden"
                        showAlert = true
                    } else {
                        print("Registro de negocio: \(nombreNegocio), \(telefono), \(email)")
                        // Aquí va la lógica de registro
                    }
                }) {
                    Text("Crear cuenta")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 1.0, green: 0.42, blue: 0.55))
                        .cornerRadius(8)
                }

                // Volver
                HStack {
                    Text("¿Seleccionaste mal tu rol?")
                        .foregroundColor(.white)
                    Button("Volver") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.pink)
                    .bold()
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct RegistroNegocioScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistroNegocioScreen()
    }
}
