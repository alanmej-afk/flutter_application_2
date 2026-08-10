import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(const VetHills());
}
// CAMBIA ESTE LINK POR TU GIF
const String logoGif =
    "https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExN2xzcGJqbWJrY213NngweTViMTJ2ZDVhcm45c2I0a2JmcXgxMTd5YyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/H4XImflNDhzByzGDkl/giphy.gif";
class VetHills extends StatelessWidget{
  const VetHills({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(
        useMaterial3:true,
        colorScheme:ColorScheme.fromSeed(
          seedColor:Color.fromARGB(255, 233, 151, 29),
        ),
      ),
      home:const Splash(),
    );
  }
}
class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState()=>_SplashState();
}
class _SplashState extends State<Splash>{

  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds:4),
      (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:(_)=>const LoginPage(),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
  super.didChangeDependencies();
  precacheImage(
    const AssetImage("assets/images/logo.gif"),
    context,
  );
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:

      const Color.fromARGB(255, 233, 151, 29),
      body:Center(
        child:Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children:[
            ClipRRect(
  borderRadius: BorderRadius.circular(200),
  child: Image.asset(
  'assets/images/logo.gif',
  width: 250,
  height: 250,
  fit: BoxFit.contain,
)
),
const SizedBox(height:25),
  const Text(
  "Veterinaria Hills",
  style:TextStyle(
  color:Colors.white,
  fontSize:34,
  fontWeight:
  FontWeight.bold,
 ),
 ),
 ],
 ),
 ),
  );
  }
}
class Producto {
  final String nombre;
  final String precio;
  final String imagen;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imagen,
  });

}

class Usuario {
  String? foto;
  String nombre;
  String edad;
  String mascota;
  String raza;
  String fecha;
  String correo;
  String password;

  Usuario({
  this.foto,
  required this.nombre,
  required this.edad,
  required this.mascota,
  required this.raza,
  required this.fecha,
  required this.correo,
  required this.password,
});
}

class CitaAgendada {
  final String mascota;
  final String duenio;
  final String especie;
  final String fecha;
  final String imagenMascota;

  final String veterinario;
  final String especialidadVeterinario;
  final String telefonoVeterinario;
  final String correoVeterinario;
  final String tituloVeterinario;
  final String curriculumVeterinario;
  final String imagenVeterinario;
  final String fechaAtencion;
  final String sucursalVeterinario;

  CitaAgendada({
    required this.mascota,
    required this.duenio,
    required this.especie,
    required this.fecha,
    required this.imagenMascota,

    required this.veterinario,
    required this.especialidadVeterinario,
    required this.telefonoVeterinario,
    required this.correoVeterinario,
    required this.tituloVeterinario,
    required this.curriculumVeterinario,
    required this.imagenVeterinario,
    required this.fechaAtencion,
    required this.sucursalVeterinario,
  });
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {

  final nombre = TextEditingController();
  final edad = TextEditingController();
  final mascota = TextEditingController();
  final raza = TextEditingController();
  final fecha = TextEditingController();
  final correo = TextEditingController();
  final password = TextEditingController();

  InputDecoration caja(String texto) {
    return InputDecoration(
      hintText: texto,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Cuenta"),
      ),
      body: Center(
  child: Container(
    margin: const EdgeInsets.all(25),
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 212, 103, 1), // verde agua oscuro
      borderRadius: BorderRadius.circular(25),
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Crear Cuenta",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nombre,
            decoration: caja("Nombre"),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: edad,
            decoration: caja("Edad"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: mascota,
            decoration: caja("Nombre de la mascota"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: raza,
            decoration: caja("Tipo/Raza"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: fecha,
            decoration: caja("Fecha"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: correo,
            decoration: caja("Correo"),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: password,
            obscureText: true,
            decoration: caja("Contraseña"),
          ),
          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {

  Usuario usuario = Usuario(
    nombre: nombre.text,
    edad: edad.text,
    mascota: mascota.text,
    raza: raza.text,
    fecha: fecha.text,
    correo: correo.text,
    password: password.text,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Bienvenido, ya estás registrado"),
      backgroundColor: Colors.orange,
      duration: Duration(seconds: 2),
    ),
  );

  Future.delayed(const Duration(seconds: 2), () {
    // ignore: use_build_context_synchronously
    // ignore: use_build_context_synchronously
    Navigator.pop(context, usuario);
  });
},
  child: const Text("Entrar"),
  ),
  ),
  ],
  ),
  ),
  ),
  ),
  );
  }
}
class EditarPerfil extends StatefulWidget {
  final Usuario usuario;

  const EditarPerfil({
    super.key,
    required this.usuario,
  });

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  late TextEditingController nombre;
  late TextEditingController correo;
  late TextEditingController mascota;
  late TextEditingController fecha;

  @override

  void initState() {
    super.initState();
    nombre = TextEditingController(text: widget.usuario.nombre);
    correo = TextEditingController(text: widget.usuario.correo);
    mascota = TextEditingController(text: widget.usuario.mascota);
    fecha = TextEditingController(text: widget.usuario.fecha);
  }

  InputDecoration caja(String texto) {

    return InputDecoration(
      labelText: texto,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: const Color(0xffedf2f0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            /// FOTO DE PERFIL

            Stack(
              alignment: Alignment.bottomRight,
              children: [

                const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 70,
                  ),
                ),

                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    // Aquí posteriormente puedes abrir la galería
                  },

                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),

            TextField(
              controller: nombre,
              decoration: caja("Tu nombre"),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: correo,
              decoration: caja("Correo"),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: mascota,
              decoration: caja("Nombre de tu mascota"),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: fecha,
              decoration: caja("Fecha"),
            ),
            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,

                    Usuario(
                      nombre: nombre.text,
                      edad: widget.usuario.edad,
                      mascota: mascota.text,
                      raza: widget.usuario.raza,
                      fecha: fecha.text,
                      correo: correo.text,
                      password: widget.usuario.password,
                    ),
                  );
                },
                child: const Text(
                  "Guardar cambios",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:
      const Color.fromARGB(255, 252, 243, 232),
      body:Center(
        child:Container(
          margin:
          const EdgeInsets.all(25),
          padding:
          const EdgeInsets.all(25),
          decoration:BoxDecoration(
            color:
            const Color.fromARGB(255, 223, 120, 4),
            borderRadius:
            BorderRadius.circular(25),
          ),

          child:Column(
            mainAxisSize:
            MainAxisSize.min,
            children:[

              const Text(
                "Veterinaria Hills",
                style:TextStyle(
                  color:Colors.white,
                  fontSize:28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height:20),

              TextField(
                decoration:
                input("Email"),
              ),
              const SizedBox(height:15),

              TextField(
                obscureText:true,
                decoration:
                input("Contraseña"),
              ),
              const SizedBox(height:25),

              SizedBox(
                width:double.infinity,
                child:ElevatedButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Home(
                       usuario: null,
                        ),
                      )
                    );
                  },
                  child:
                  const Text(
                    "Acceder",
                  ),
                ),
              ),

              TextButton(
  onPressed: () async {
    final Usuario? usuario = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterPage(),
      ),
    );
    if (usuario != null) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder:(_)=>const Home(
            usuario: null,
        )
        ),
      );
    }
  },
  child: const Text(
    "Crear Cuenta Nueva",
    style: TextStyle(
      color: Colors.white,
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration input(String t){
    return InputDecoration(
      hintText:t,
      filled:true,
      fillColor:
      Colors.white,
      border:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(20),
        borderSide:
        BorderSide.none,
      ),
    );
  }

} class Home extends StatefulWidget {

  final Usuario? usuario;
  const Home({
  super.key,
  this.usuario,
  });
  @override

  State<Home> createState() => _HomeState();

} 

  class _HomeState extends State<Home>{
  @override
  void initState() {
  super.initState();
  registrado = widget.usuario != null;
}

bool registrado = false;
int pagina = 0;
bool menuAbierto = false;

// Fecha de la cita
int? diaSeleccionado;
int? mesSeleccionado;
int? anioSeleccionado;

final List<String> meses = [
  "Enero",
  "Febrero",
  "Marzo",
  "Abril",
  "Mayo",
  "Junio",
  "Julio",
  "Agosto",
  "Septiembre",
  "Octubre",
  "Noviembre",
  "Diciembre",
];

// Citas agendadas
List<CitaAgendada> citasAgendadas = [];

// Datos de la mascota
final TextEditingController duenioCitaController =
    TextEditingController();

final TextEditingController mascotaCitaController =
    TextEditingController();

final TextEditingController especieCitaController =
    TextEditingController();

final TextEditingController correoCitaController =
    TextEditingController();

final TextEditingController buscadorController = TextEditingController();
List<String> resultadosBusqueda = [];

final List<Map<String, String>> veterinariosDisponibles = [
  {
    "nombre": "Dra. Andrea López",
    "especialidad": "Medicina General Veterinaria",
    "telefono": "(55) 1234-4567",
    "correo": "andrea@vethills.com",
    "titulo": "2018",
    "curriculum":
        "Médica Veterinaria especializada en medicina general para perros y gatos. Cuenta con experiencia en consultas preventivas, vacunación, nutrición y seguimiento clínico.",
    "imagen":
        "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=800",
  },
  {
    "nombre": "Dr. Carlos Hernández",
    "especialidad": "Cirugía Veterinaria",
    "telefono": "(55) 2345-6789",
    "correo": "carlos@vethills.com",
    "titulo": "2016",
    "curriculum":
        "Médico Veterinario especializado en procedimientos quirúrgicos y atención postoperatoria. Cuenta con experiencia en cirugía de tejidos blandos y atención de urgencias.",
    "imagen":
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=800",
  },
  {
    "nombre": "Dra. Sofía Martínez",
    "especialidad": "Dermatología Veterinaria",
    "telefono": "(55) 3456-7890",
    "correo": "sofia@vethills.com",
    "titulo": "2019",
    "curriculum":
        "Médica Veterinaria enfocada en dermatología. Su experiencia incluye diagnóstico y tratamiento de alergias, infecciones de piel y problemas dermatológicos en mascotas.",
    "imagen":
        "https://media.istockphoto.com/id/1861987838/es/foto/doctora-sonriente-mirando-a-la-c%C3%A1mara-en-la-consulta-m%C3%A9dica.jpg?s=612x612&w=0&k=20&c=H-56UpUIZBhbnhcf1MQ31x4kn0R4FN6PZBLCUR8jav4=",
  },
  {
    "nombre": "Dr. Miguel Ramírez",
    "especialidad": "Traumatología Veterinaria",
    "telefono": "(55) 4567-8901",
    "correo": "miguel@vethills.com",
    "titulo": "2017",
    "curriculum":
        "Médico Veterinario especializado en traumatología y rehabilitación. Cuenta con experiencia en lesiones musculares, fracturas y recuperación física de mascotas.",
    "imagen":
        "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
  },
];
void mostrarVeterinario(Map<String, String> veterinario) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // IMAGEN
                // =========================

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    veterinario["imagen"]!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // ignore: unnecessary_underscores
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 250,
                        color: Colors.orange.shade100,
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.orange,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // NOMBRE
                // =========================

                Text(
                  veterinario["nombre"]!,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // =========================
                // ESPECIALIDAD
                // =========================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.medical_services,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        veterinario["especialidad"]!,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // =========================
                // TITULACIÓN
                // =========================

                const Text(
                  "Año de titulación",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  veterinario["titulo"]!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // CURRÍCULUM
                // =========================

                const Text(
                  "Currículum",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  veterinario["curriculum"]!,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // CORREO
                // =========================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        veterinario["correo"]!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // =========================
                // TELÉFONO
                // =========================

                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        veterinario["telefono"]!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // =========================
                // CONTACTAR
                // =========================

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Contactar",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      final telefono =
                          veterinario["telefono"]!;

                      final telefonoLimpio =
                          telefono.replaceAll(
                        RegExp(r'[^0-9+]'),
                        '',
                      );

                      final uri = Uri(
                        scheme: 'tel',
                        path: telefonoLimpio,
                      );

                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // =========================
                // CERRAR
                // =========================

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cerrar",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


String imagenSegunEspecie(String especie) {
  final especieNormalizada = especie.toLowerCase().trim();

  if (especieNormalizada.contains("gato") ||
      especieNormalizada.contains("gata")) {
    return "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?w=800";
  }

  if (especieNormalizada.contains("perro") ||
      especieNormalizada.contains("perra")) {
    return "https://images.unsplash.com/photo-1552053831-71594a27632d?w=800";
  }

  if (especieNormalizada.contains("conejo")) {
    return "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=800";
  }

  if (especieNormalizada.contains("ave") ||
      especieNormalizada.contains("pajaro") ||
      especieNormalizada.contains("pájaro")) {
return "https://images.unsplash.com/photo-1444464666168-49d633b86797?w=800";
  }

  // Imagen predeterminada
  return "https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=800";
}

void agendarCita() {
  // Validar datos
  if (duenioCitaController.text.trim().isEmpty ||
      mascotaCitaController.text.trim().isEmpty ||
      especieCitaController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Completa los datos de la mascota y del dueño",
        ),
        backgroundColor: Colors.red,
      ),
    );

    return;
  }

  if (diaSeleccionado == null ||
      mesSeleccionado == null ||
      anioSeleccionado == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Selecciona el día, mes y año de la cita",
        ),
        backgroundColor: Colors.red,
      ),
    );

    return;
  }

  // ==================================
  // ELEGIR VETERINARIO ALEATORIO
  // ==================================

  final veterinario =
      (List<Map<String, String>>.from(veterinariosDisponibles)
            ..shuffle())
          .first;

  final fecha =
      "$diaSeleccionado de ${meses[mesSeleccionado! - 1]} de $anioSeleccionado";

final sucursal =
    (List<String>.from(sucursalesDisponibles)..shuffle()).first;

  // ==================================
  // CREAR LA CITA
  // ==================================


  final nuevaCita = CitaAgendada(
  mascota: mascotaCitaController.text.trim(),
  duenio: duenioCitaController.text.trim(),
  especie: especieCitaController.text.trim(),
  fecha: fecha,
  imagenMascota:
      imagenSegunEspecie(especieCitaController.text),

  veterinario: veterinario["nombre"]!,
  especialidadVeterinario:
      veterinario["especialidad"]!,
  telefonoVeterinario:
      veterinario["telefono"]!,
  correoVeterinario:
      veterinario["correo"]!,
  tituloVeterinario:
      veterinario["titulo"]!,
  curriculumVeterinario:
      veterinario["curriculum"]!,
  imagenVeterinario:
      veterinario["imagen"]!,
  fechaAtencion: fecha,
  sucursalVeterinario: sucursal,
);

  setState(() {
    citasAgendadas.add(nuevaCita);
  });

  // Limpiar formulario
  duenioCitaController.clear();
  mascotaCitaController.clear();
  especieCitaController.clear();
  correoCitaController.clear();

  diaSeleccionado = null;
  mesSeleccionado = null;
  anioSeleccionado = null;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Cita agendada con ${veterinario["nombre"]}",
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    ),
  );
}
final List<String> sucursalesDisponibles = [
  "Sucursal Centro - Ciudad de México",
  "Sucursal Norte - Lindavista",
  "Sucursal Sur - Coyoacán",
  "Sucursal Oriente - Iztapalapa",
];
  final productos=[
    "Comida perro",
    "Transportadora",
    "Medicamento",
    "Accesorios",
  ];

  List<Producto> carrito = []; 

  void agregarCarrito(Producto producto) {
  setState(() {
    carrito.add(producto);
  });
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("${producto.nombre} añadido al carrito"),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green,
    ),
  );
} Widget dato(String titulo, String valor) {

  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      title: Text(
        titulo,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(valor),
    ),
  );
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
backgroundColor:
const Color(0xffedf2f0),
body: Stack(
children:[
Scaffold(
backgroundColor:
const Color(0xffedf2f0),
appBar: PreferredSize(

  preferredSize: const Size.fromHeight(125),

  child: AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color.fromARGB(255, 255, 145, 0),
    elevation: 0,
    flexibleSpace: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [

            // =========================
            // FILA SUPERIOR
            // =========================
            Expanded(
              child: Row(
                children: [
                 // BOTÓN MENÚ (3 rayas)

IconButton(
  onPressed: () {
    setState(() {
      menuAbierto = true;
    });
  },

  icon: const Icon(
    Icons.menu,
    color: Colors.white,
    size: 32,
  ),

),
const SizedBox(width: 8),

const Text(

  "Veterinaria\nHills",

  style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 1,

  ),

),
const SizedBox(width: 12),

 // BUSCADOR
Expanded(
  child: Offstage(
    offstage: false,
    child: SizedBox(
      height: 40,
      child: Stack(
      children: [
    Container(
    height: 36,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
    controller: buscadorController,
    textAlignVertical: TextAlignVertical.center,
    decoration: const InputDecoration(
      hintText: "Buscar",
      prefixIcon: Icon(
        Icons.search,
        size: 20,
      ),
      border: InputBorder.none,
      isDense: true,
      contentPadding: EdgeInsets.zero,
    ),
  ),
),
        ],
      ),
    ),
  ),
),
          

  // CARRITO
  IconButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, actualizarCarrito) {
            final int cantidadProductos = carrito.length;

            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Carrito de compras",
                    ),
                  ),

                  // CANTIDAD TOTAL
                  if (cantidadProductos > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "$cantidadProductos",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),

              content: SizedBox(
                width: 400,
                height: 450,
                child: cantidadProductos == 0
                    ? const Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80,
                              color: Colors.orange,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "No hay productos en el carrito",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: carrito.length,
                        itemBuilder: (context, index) {
                          final Producto producto =
                              carrito[index];

                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  // ==========================
                                  // IMAGEN DEL PRODUCTO
                                  // ==========================

                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                    child: Image.network(
                                      producto.imagen,
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) {
                                        return Container(
                                          width: 75,
                                          height: 75,
                                          color: Colors
                                              .orange
                                              .shade100,
                                          child: const Icon(
                                            Icons.pets,
                                            size: 40,
                                            color:
                                                Colors.orange,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // ==========================
                                  // NOMBRE Y PRECIO
                                  // ==========================

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          producto.nombre,
                                          maxLines: 2,
                                          overflow:
                                              TextOverflow
                                                  .ellipsis,
                                          style:
                                              const TextStyle(
                                            fontSize: 17,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          producto.precio,
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.orange,
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ==========================
                                  // ELIMINAR
                                  // ==========================

                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      actualizarCarrito(() {
                                        carrito.removeAt(index);
                                      });

                                      setState(() {});

                                      if (carrito.isEmpty) {
                                        // El diálogo permanece abierto
                                        // mostrando el carrito vacío.
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // =============================================
              // BOTONES INFERIORES
              // =============================================

              actions: [
                // ==========================
                // COMPRAR
                // ==========================

                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            cantidadProductos == 0
                                ? Colors.grey
                                : Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(
                        Icons.shopping_bag,
                      ),
                      label: Text(
                        cantidadProductos == 0
                            ? "Comprar"
                            : cantidadProductos == 1
                                ? "Comprar"
                                : "Comprar ($cantidadProductos productos)",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: cantidadProductos == 0
                          ? null
                          : () {
                              // AQUÍ POSTERIORMENTE
                              // PUEDES COLOCAR EL PROCESO
                              // DE COMPRA.

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Compraste $cantidadProductos "
                                    "producto${cantidadProductos > 1 ? 's' : ''}",
                                  ),
                                  backgroundColor:
                                      Colors.green,
                                ),
                              );

                              Navigator.pop(context);
                            },
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // ==========================
                // CERRAR
                // ==========================

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cerrar",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  },
  icon: const Icon(
    Icons.shopping_cart_outlined,
    color: Colors.white,
    size: 30,
  ),
),
                ],
              ),
            ),

// MENÚ SUPERIOR
SizedBox(
  height: 40,
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      children: [
        botonSuperior("Inicio", 0),
        botonSuperior("Productos", 1),
        botonSuperior("Citas", 2),
        botonSuperior("Veterinarios", 6),
        ],
        ),
        ),
        ),

        const SizedBox(height: 6),
          ],
        ),
      ),
    ),
  ),
),

body: pagina == 0
    ? inicio()
    : pagina == 1
    ? productosPage()
    : pagina == 2
    ? citasPage()
    : pagina == 3
    ? perfilPage()
    : pagina == 4
    ? configuracionPage()
    : pagina == 5
    ? acercaPage()
    : pagina == 6
    ? doctoresPage()
    : citasAgendadasPage(),
),

// EFECTO BLUR
if(menuAbierto)

GestureDetector(
onTap:(){
setState((){
menuAbierto=false;
});
},
child:BackdropFilter(
filter:ImageFilter.blur(
sigmaX:8,
sigmaY:8,
),
child:Container(
color:
Colors.transparent,
),
),
),

// MENU LATERAL

AnimatedPositioned(
duration:

const Duration(milliseconds:300),
left:
menuAbierto
? 0
: -MediaQuery.of(context).size.width * 0.5,

top:0,
bottom:0,

child:Container(
width:
MediaQuery.of(context).size.width * 0.5,
color:
const Color.fromARGB(255, 218, 107, 4),

child:ListView(
padding:EdgeInsets.zero,


children:[

DrawerHeader(

  child: Row(

    crossAxisAlignment: CrossAxisAlignment.center,

    children: [
      Image.network(
        logoGif,
        width: 55,
        height: 55,
      ),
      const SizedBox(width: 12),
      const Expanded(
        child: Text(
          "Veterinaria Hills",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),

menuItem(
Icons.home,
"Inicio",
0,
),

menuItem(
Icons.store,
"Productos",
1,
),

menuItem(
Icons.calendar_month,
"Crear cita",
2,

),
menuItem(
  Icons.event_available,
  "Citas Agendadas",
  7,
),

menuItem(
Icons.medical_services,
"Veterinarios",
6,
),

menuItem(
Icons.person,
"Perfil",
3,
),

menuItem(
Icons.settings,
"Configuración",
4,
),

menuItem(
Icons.info,
"Acerca de",
5,
),
],
),
),
),
],
),
);
}    
     Widget menuItem(

      IconData icon,

      String texto,

      int valor

      ){



    return ListTile(



      leading:Icon(

        icon,

        color:Colors.white,

      ),

      title:Text(
        texto,
        style:
        const TextStyle(
          color:Colors.white,
        ),

      ),

      onTap:(){
setState((){
pagina=valor;
menuAbierto=false;
});
});

  } Widget botonSuperior(String texto, int paginaDestino) {

  return TextButton(

    onPressed: () {

      setState(() {
        pagina = paginaDestino;
      });
    },

    child: Text(

      texto,

      style: const TextStyle(

        color: Colors.white,

        fontWeight: FontWeight.bold,

        fontSize: 15,

      ),
    ),
  );


}

  Widget inicio(){
    return ListView(
      padding:
      const EdgeInsets.all(20),
      children:[

 const SizedBox(height: 20),
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 5),
  child: GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 0.60,
),

    itemBuilder: (context, index) {

      final productos = [

        {
          "nombre": "Shampoo",
          "precio": "\$250",
          "imagen":
              "https://arteli.vtexassets.com/arquivos/ids/264546/7501022107379_00.jpg?v=638635829964730000",

        },

        {
          "nombre": "Arena para gato",
          "precio": "\$60",
          "imagen":

              "https://i5.walmartimages.com.mx/mg/gm/3pp/asr/72c0aa6f-9d9a-4d81-9af8-d346d423612b.f8b354e48aba17ec9de3e28098e6648a.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff",

        },

        {
          "nombre": "Cepillo",
          "precio": "\$120",
          "imagen":
              "https://www.latiendadefrida.com/cdn/shop/files/M_PETS_10105899_HAIRDO_Double_sided_PIN_Brush_591x591.jpg",

        },

        {
          "nombre": "Juguete",
          "precio": "\$90",
          "imagen":
              "https://image.made-in-china.com/251f0j00FYzRCgGsYthw/made-in-china.jpg",
        },

        {
          "nombre": "Peine",
          "precio": "\$95",
          "imagen":

              "https://animall.com.mx/cdn/shop/files/Pelu2CepilloColorNaranjaconCerdasdePlasticoMediano_4.png?v=1755212402&width=1445",
        },

        {
          "nombre": "Toallitas",
          "precio": "\$75",
          "imagen":

              "https://animall.com.mx/cdn/shop/files/Toallitas_humedas_para_perros.jpg?v=1766269184",

        }
      ];



      return Card(
  elevation: 4,
  margin: EdgeInsets.zero,
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      // IMAGEN
      Expanded(
        flex: 6,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.network(
            productos[index]["imagen"]!,
            fit: BoxFit.cover,
            // ignore: unnecessary_underscores
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Icon(
                  Icons.pets,
                  size: 60,
                  color: Colors.orange,
                ),
              );
            },
          ),
        ),
      ),

      // NOMBRE
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          productos[index]["nombre"]!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),

      // PRECIO
      Text(
        productos[index]["precio"]!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 8),

      // COMPRAR
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 28,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Compraste ${productos[index]["nombre"]}",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Comprar",
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 5),

      // AÑADIR AL CARRITO
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: SizedBox(
          height: 28,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: Colors.deepOrange,
              side: const BorderSide(
                color: Colors.orange,
                width: 1.5,
              ),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart,
              size: 14,
              color: Colors.orange,
            ),
            label: const Text(
              "Añadir",
              style: TextStyle(
                fontSize: 11,
                color: Colors.orange,
              ),
            ),
            onPressed: () {
              agregarCarrito(
                Producto(
                  nombre: productos[index]["nombre"]!,
                  precio: productos[index]["precio"]!,
                  imagen: productos[index]["imagen"]!,
                ),
              );
            },
          ),
        ),
      ),
    ],
  ),
  );

  },
  ),
  )
  ]);
  } 
  void buscarProducto(String texto){

  final lista = productos
      .where(
        (producto) => producto
            .toLowerCase()
            .contains(texto.toLowerCase()),
      )
      .toList();

  setState(() {
    resultadosBusqueda = lista;
  });

}

Widget productosPage(){
    return GridView.builder(
      padding:
      const EdgeInsets.all(15),

      itemCount:
      productos.length,
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 0.60, // antes .75
       ),
      itemBuilder:(context,i){

        return Card(
          elevation:5,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(10),
          ),
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,

  children: [
    // Imagen

    Expanded(
      flex: 6,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Image.network(
          imagenProducto(i),
          fit: BoxFit.cover,
          // ignore: unnecessary_underscores

          // ignore: unnecessary_underscores
          errorBuilder: (_, __, ___) {

            return const Center(

              child: Icon(

                Icons.pets,

                size: 80,

                color: Colors.orange,

              ),

            );

          },

        ),

      ),

    ),



    // Nombre

    Padding(

      padding: const EdgeInsets.all(8),

      child: Text(

        productos[i],

        textAlign: TextAlign.center,

        style: const TextStyle(

          fontWeight: FontWeight.bold,

          fontSize: 16,

        ),

      ),

    ),



    // Botón Comprar

    Padding(

      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

        backgroundColor: Colors.orange,

        foregroundColor: Colors.white,

        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12))

        ),

        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Compraste ${productos[i]}",
      ),
      backgroundColor: Colors.green,
          ),
         );
        },
        child: const Text("Comprar"),
      ),
      ),



    // Botón Añadir al carrito

    Padding(

      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),

      child: OutlinedButton.icon(

      style: OutlinedButton.styleFrom(

      backgroundColor: Colors.orange.shade50,

      foregroundColor: Colors.deepOrange,

      side: const BorderSide(

      color: Colors.orange,

      width: 2,

    ),

      padding: const EdgeInsets.symmetric(vertical: 12),

      shape: RoundedRectangleBorder(

      borderRadius: BorderRadius.circular(12),

    ),

     ),



    onPressed: () {
    agregarCarrito(
    Producto(
      nombre: productos[i],
      precio: "\$0",
      imagen: imagenProducto(i),
       ),
      );
     },
     icon: const Icon(Icons.add_shopping_cart),
     label: const Text("Añadir al carrito"),
    ),
    )
      ],
      )
      );
      },
    );
  }
  String imagenProducto(int i){
    final fotos=[
      "https://lagranbodega.vteximg.com.br/arquivos/ids/282795-1000-1000/7502002871167.jpg?v=637544425228870000",
      "https://ss345.liverpool.com.mx/xl/1154628602.jpg",
      "https://benitomoda.mx/cdn/shop/files/VERMIPLEX_bba75101-487d-4c2c-85d2-8b6d623c988e_4480x.jpg?v=1784411224",
      "https://img.nihaojewelry.com/fit-in/360x360/product/2024/1/9/1744605805648416768/Solid-Color-Dog-Leash-1-Piece-In-Simple-Style-With-PVC-Coated-And-Polyester-Webbing-For-All-Seasons-Ideal-For-Holiday-Use.jpg",

    ];
    return fotos[i];
  }

  Widget citasPage() {
  return ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        "Crear una cita",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 20),

      // ===============================
      // DUEÑO
      // ===============================

      TextField(
        controller: duenioCitaController,
        decoration: InputDecoration(
          hintText: "Nombre del dueño",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),

      const SizedBox(height: 15),

      // ===============================
      // MASCOTA
      // ===============================

      TextField(
        controller: mascotaCitaController,
        decoration: InputDecoration(
          hintText: "Nombre de la mascota",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),

      const SizedBox(height: 15),

      // ===============================
      // ESPECIE
      // ===============================

      TextField(
        controller: especieCitaController,
        decoration: InputDecoration(
          hintText: "Especie (Perro, Gato, Conejo...)",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),

      const SizedBox(height: 20),

      const Text(
        "Fecha de la cita",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 12),

      // ===============================
// FECHA RESPONSIVA
// ===============================

Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [

    // DÍA Y MES
    Row(
      children: [

        // DÍA
        Expanded(
          child: DropdownButtonFormField<int>(
            // ignore: deprecated_member_use
            value: diaSeleccionado,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: "Día",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            items: List.generate(
              31,
              (index) {
                final dia = index + 1;

                return DropdownMenuItem<int>(
                  value: dia,
                  child: Text(
                    "$dia",
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
            onChanged: (valor) {
              setState(() {
                diaSeleccionado = valor;
              });
            },
          ),
        ),

        const SizedBox(width: 10),

        // MES
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<int>(
            // ignore: deprecated_member_use
            value: mesSeleccionado,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: "Mes",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            items: List.generate(
              meses.length,
              (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text(
                    meses[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
            onChanged: (valor) {
              setState(() {
                mesSeleccionado = valor;
              });
            },
          ),
        ),
      ],
    ),

    const SizedBox(height: 10),

    // AÑO
    DropdownButtonFormField<int>(
      // ignore: deprecated_member_use
      value: anioSeleccionado,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Año",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      items: List.generate(
        31,
        (index) {
          final anio = 2000 + index;

          return DropdownMenuItem<int>(
            value: anio,
            child: Text("$anio"),
          );
        },
      ),
      onChanged: (valor) {
        setState(() {
          anioSeleccionado = valor;
        });
      },
    ),
  ],
),
      const SizedBox(height: 15),

      // ===============================
      // CORREO
      // ===============================

      TextField(
        controller: correoCitaController,
        decoration: InputDecoration(
          hintText: "Correo",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),

      const SizedBox(height: 25),

      // ===============================
      // AGENDAR
      // ===============================

      SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: agendarCita,
          child: const Text(
            "Agendar cita",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

  Widget campo(String texto){

    return Padding(
      padding:
      const EdgeInsets.only(bottom:15),

      child:TextField(
        decoration:
        InputDecoration(
          hintText:texto,
          filled:true,
          fillColor:
          Colors.white,
          border:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(20),
            borderSide:
            BorderSide.none,
          ),
        ),
      ),
    );
  } 

  Widget citasAgendadasPage() {
  if (citasAgendadas.isEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              size: 90,
              color: Colors.orange.shade300,
            ),

            const SizedBox(height: 20),

            const Text(
              "No tienes citas agendadas",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Cuando agendes una cita aparecerá aquí.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.all(18),
    itemCount: citasAgendadas.length,
    itemBuilder: (context, index) {
      final cita = citasAgendadas[index];

      return Card(
        elevation: 5,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===============================
              // IMAGEN DE LA MASCOTA
              // ===============================

              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.orange.shade50,
                  child: Image.network(
                    cita.imagenMascota,
                    fit: BoxFit.cover,
                    // ignore: unnecessary_underscores
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.pets,
                        size: 90,
                        color: Colors.orange,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ===============================
              // DATOS DE LA MASCOTA
              // ===============================

              Text(
                cita.mascota,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.pets,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Especie: ${cita.especie}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Dueño: ${cita.duenio}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Fecha: ${cita.fecha}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 30,
                thickness: 1,
              ),

              // ===============================
              // VETERINARIO ASIGNADO
              // ===============================

              const Text(
                "Veterinario asignado",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 12),

              InkWell(
  borderRadius: BorderRadius.circular(15),
  onTap: () {
    mostrarVeterinario({
      "nombre": cita.veterinario,
      "especialidad": cita.especialidadVeterinario,
      "telefono": cita.telefonoVeterinario,
      "correo": cita.correoVeterinario,
      "titulo": cita.tituloVeterinario,
      "curriculum": cita.curriculumVeterinario,
      "imagen": cita.imagenVeterinario,
    });
  },
  child: Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            cita.imagenVeterinario,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            // ignore: unnecessary_underscores
            errorBuilder: (_, __, ___) {
              return const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.medical_services,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                cita.veterinario,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                cita.especialidadVeterinario,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.orange,
        ),
      ],
    ),
  ),
),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cita.telefonoVeterinario,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.event_available,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Podrá atenderte el: ${cita.fechaAtencion}",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

// ===============================
// SUCURSAL ASIGNADA
// ===============================

Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Icon(
      Icons.location_on,
      color: Colors.deepOrange,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        "Sucursal: ${cita.sucursalVeterinario}",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
                 ),
                ),
               ),
              ],
             ),
            ],
          ),
        ),
      );
    },
  );
}

   Widget perfilPage() {
  Usuario usuario = widget.usuario ??

      Usuario(
        nombre: "",
        edad: "",
        mascota: "",
        raza: "",
        fecha: "",
        correo: "",
        password: "",

      );

  return SingleChildScrollView(

    padding: const EdgeInsets.all(25),

    child: Column(

      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [

            const CircleAvatar(

              radius: 65,

              backgroundColor: Colors.orange,

              child: Icon(

                Icons.person,

                color: Colors.white,

                size: 70,

              ),

            ),

            CircleAvatar(

              radius: 20,

              backgroundColor: Colors.white,

              child: IconButton(

                icon: const Icon(

                  Icons.camera_alt,

                  color: Colors.orange,

                ),

                onPressed: () {

                  // aquí irá image_picker

                },

              ),

            ),

          ],

        ),
        const SizedBox(height: 30),

        TextField(

          controller: TextEditingController(text: usuario.nombre),

          decoration: const InputDecoration(

            labelText: "Tu nombre",

          ),

        ),
        const SizedBox(height: 15),

        TextField(

          controller: TextEditingController(text: usuario.correo),

          decoration: const InputDecoration(

            labelText: "Correo",

          ),

        ),
        const SizedBox(height: 15),

        TextField(

          controller: TextEditingController(text: usuario.mascota),

          decoration: const InputDecoration(

            labelText: "Nombre de tu mascota",

          ),

        ),



        const SizedBox(height: 15),



        TextField(

          controller: TextEditingController(text: usuario.fecha),

          decoration: const InputDecoration(
            labelText: "Fecha",
          ),
        ),
        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Guardar cambios"),
          ),
        ),
      ],
    ),
  );
}
Widget doctoresPage() {

  return ListView.builder(
    padding: const EdgeInsets.all(18),
    itemCount: veterinariosDisponibles.length,
    itemBuilder: (context, index) {
      final vet = veterinariosDisponibles[index];

      return Card(
        margin: const EdgeInsets.only(bottom: 18),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        // ==================================
        // CARD INTERACTIVA
        // ==================================

        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            mostrarVeterinario(vet);
          },

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 260,
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: Image.network(
                      vet["imagen"]!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const Icon(
                          Icons.person,
                          size: 90,
                          color: Colors.orange,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  vet["nombre"]!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.medical_services,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vet["especialidad"]!,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      vet["telefono"]!,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // INDICADOR DE QUE ES INTERACTIVA
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.touch_app,
                      color: Colors.orange,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Toca para ver información",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget configuracionPage() {

  return ListView(

    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        "Configuración",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),

      SwitchListTile(
        value: true,
        onChanged: (v) {},
        secondary: const Icon(Icons.notifications),
        title: const Text("Notificaciones"),
      ),

      SwitchListTile(
        value: false,
        onChanged: (v) {},
        secondary: const Icon(Icons.dark_mode),
        title: const Text("Modo oscuro"),
      ),

      ListTile(
        leading: const Icon(Icons.language),
        title: const Text("Idioma"),
        subtitle: const Text("Español"),
      ),

      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text("Cambiar contraseña"),
      ),
      ListTile(
        leading: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: const Text("Cerrar sesión"),
      ),
    ],
  );
}
// ignore: non_constant_identifier_names
Widget acercaPage() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.orange.shade200,
          child: const Icon(
            Icons.pets,

            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),

        const Text(

          "VetHill Veterinaria",

          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        const Text(

          "Versión 1.0.0",

          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 25),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const Text(
    "VetHill es una aplicación diseñada para facilitar la atención veterinaria. Permite consultar productos para mascotas, agendar citas, administrar perfiles de usuarios y ofrecer una experiencia rápida y segura para los propietarios de mascotas.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 25),

const SizedBox(height: 30),

const Text(
  "Síguenos en nuestras redes sociales",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 15),

Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  child: Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [

        ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.facebook,
            color: Colors.blue,
            size: 35,
          ),
          title: const Text(
            "Facebook",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            "Veterinaria Hills",
          ),
          onTap: () {
            // Aquí puedes abrir Facebook
          },
        ),

        ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.purple,
            size: 35,
          ),
          title: const Text(
            "Instagram",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            "@veterinariahills",
          ),
          onTap: () {
            // Aquí puedes abrir Instagram
          },
        ),

        ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.tiktok,
            color: Colors.black,
            size: 35,
          ),
          title: const Text(
            "TikTok",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            "@vethills",
          ),
          onTap: () {
            // Aquí puedes abrir TikTok
          },
        ),
      ],
    ),
  ),
),

const SizedBox(height: 30),



const SizedBox(height: 30),

const Text(

  "Encuéntranos",

  style: TextStyle(

    fontSize: 22,

    fontWeight: FontWeight.bold,

  ),

),
const SizedBox(height: 25),

const Text(
  "Nuestras sucursales",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,

  ),

),
const SizedBox(height: 15),

ClipRRect(
  borderRadius: BorderRadius.circular(15),
  child: Image.network(
    "https://www.google.com/maps/vt/data=TVSEUFOTuxshoK8Dpuv_crWyx9jhEneTF0u_kba_COs-N7zbZxpn16pMf8OCHxsS03LLFKfcp2psuHJ3Cd-Ezoh7NQ2FNU1wATnA86PQCVhKne8QUoPMaJXVNM2M0MHoFm1aeRphfsVzfMRj1zDncoPcmvH213JH8xlxy0v_P8vNjFvvTQNpLOwaFyDJ0vSE0pvvb48ba0Mx09SZ9HsBYtwixJth1yicN5gjGfbENmSNAmkbnska4yeEb1mDW3aj-TjAY450a6oy2YILEG9VFA",

    fit: BoxFit.cover,
  ),
),
        const SizedBox(height: 20),
        const ListTile(

          leading: Icon(Icons.phone, color: Colors.deepOrange),
          title: Text("Teléfono"),
          subtitle: Text("(55) 1234-5678"),

        ),

        const ListTile(
          leading: Icon(Icons.email, color: Colors.deepOrangeAccent),
          title: Text("Correo"),
          subtitle: Text("contacto@vethill.com"),

        ),

        const ListTile(
          leading: Icon(Icons.location_on, color: Colors.deepOrange),
          title: Text("Dirección"),
          subtitle: Text("Ciudad de México"),

        ),
      ],
    ),
  );
}
}