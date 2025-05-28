import SwiftUI

struct RegistroUsuarioScreen: View {
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

                // LOGO + título
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

                // Teléfono
                TextField("Teléfono", text: $telefono)
                    .padding()
                    .keyboardType(.phonePad)
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)

                // Correo
                TextField("Correo electrónico", text: $email)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)

                // Contraseña y Confirmar en horizontal
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

                // Botón Crear Cuenta
                Button(action: {
                    if telefono.isEmpty || email.isEmpty || password.isEmpty || confirmarPassword.isEmpty {
                        alertMessage = "Por favor completa todos los campos"
                        showAlert = true
                    } else if password != confirmarPassword {
                        alertMessage = "Las contraseñas no coinciden"
                        showAlert = true
                    } else {
                        // Acción para crear cuenta
                        print("Creando cuenta con: \(telefono), \(email)")
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

                // Volver al rol
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

struct RegistroUsuarioScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistroUsuarioScreen()
    }
}
