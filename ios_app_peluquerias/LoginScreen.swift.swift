import SwiftUI

struct LoginScreen: View {
    var tipoUsuario: String

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navegarRegistro = false

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

                // LOGO + texto superior
                VStack(spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)

                    Text("Inicia sesión para continuar")
                        .foregroundColor(Color(white: 0.85))
                        .font(.subheadline)
                }

                // EMAIL
                TextField("username", text: $email)
                    .padding()
                    .background(Color(red: 0.85, green: 0.95, blue: 1.0))
                    .cornerRadius(8)
                    .autocapitalization(.none)

                // PASSWORD + icono de ojo dentro
                ZStack(alignment: .trailing) {
                    Group {
                        if showPassword {
                            TextField("password", text: $password)
                        } else {
                            SecureField("password", text: $password)
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

                // OLVIDASTE CONTRASEÑA
                HStack {
                    Spacer()
                    Button(action: {
                        // Acción para recuperación
                    }) {
                        Text("¿Has olvidado tu contraseña?")
                            .font(.caption)
                            .foregroundColor(.pink)
                    }
                }

                // BOTÓN LOGIN
                Button(action: {
                    if email.isEmpty || password.isEmpty {
                        alertMessage = "Por favor completa todos los campos"
                        showAlert = true
                    } else {
                        print("Login como \(tipoUsuario)")
                        // Aquí lógica de autenticación
                    }
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 1.0, green: 0.42, blue: 0.55))
                        .cornerRadius(8)
                }

                // NO TIENES CUENTA
                HStack {
                    Text("¿No tienes cuenta?")
                        .foregroundColor(.white)
                    Button("Crea una ahora") {
                        navegarRegistro = true
                    }
                    .foregroundColor(.pink)
                    .bold()
                }

                // NAVIGATION A REGISTRO
                NavigationLink(
                    destination: tipoUsuario == "cliente"
                        ? AnyView(RegistroUsuarioScreen())
                        : AnyView(RegistroNegocioScreen()),
                    isActive: $navegarRegistro
                ) {
                    EmptyView()
                }

                // SELECCIONASTE MAL TU ROL
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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(tipoUsuario: "cliente")
    }
}
