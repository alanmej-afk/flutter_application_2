import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    _abrirSesion();
  }

  Future<void> _abrirSesion() async {
    await Future.delayed(const Duration(milliseconds: 900));
    final usuario = await FirebaseRestService.restaurarSesion();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => usuario == null
            ? const LoginPage()
            : Home(usuario: usuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 233, 151, 29),
      body:Container(
        width:double.infinity,
        decoration:const BoxDecoration(
          gradient:LinearGradient(
            begin:Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors:[
              Color.fromARGB(255, 245, 166, 42),
              Color.fromARGB(255, 218, 107, 4),
            ],
          ),
        ),
        child:Center(
          child:Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Container(
                width:270,
                height:270,
                padding:const EdgeInsets.all(10),
                decoration:BoxDecoration(
                  // ignore: deprecated_member_use
                  color:Colors.white.withOpacity(.96),
                  shape:BoxShape.circle,
                  boxShadow:[
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color:Colors.black.withOpacity(.20),
                      blurRadius:28,
                      offset:const Offset(0,12),
                    ),
                  ],
                ),
                child:ClipOval(
                  child:Image.network(
                    logoGif,
                    width:250,
                    height:250,
                    fit:BoxFit.cover,
                    gaplessPlayback:true,
                    loadingBuilder:(context,child,progress){
                      if(progress==null) return child;
                      return const Center(
                        child:CircularProgressIndicator(
                          color:Color.fromARGB(255, 233, 151, 29),
                        ),
                      );
                    },
                    errorBuilder:(context,error,stack){
                      return Image.asset(
                        'assets/images/logo.gif',
                        fit:BoxFit.cover,
                        errorBuilder:(context,error,stack){
                          return const Icon(
                            Icons.pets,
                            size:110,
                            color:Color.fromARGB(255, 233, 151, 29),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height:28),
              const Text(
                'Veterinaria Hills',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:34,
                  fontWeight:FontWeight.bold,
                  letterSpacing:.5,
                ),
              ),
              const SizedBox(height:8),
              const Text(
                'Cuidamos a quienes más quieres 🐾',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:15,
                  fontWeight:FontWeight.w500,
                ),
              ),
            ],
          ),
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
  final String hora;
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
    required this.hora,
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

  Map<String, dynamic> toMap() => {
    'mascota': mascota,
    'duenio': duenio,
    'especie': especie,
    'fecha': fecha,
    'hora': hora,
    'imagenMascota': imagenMascota,
    'veterinario': veterinario,
    'especialidadVeterinario': especialidadVeterinario,
    'telefonoVeterinario': telefonoVeterinario,
    'correoVeterinario': correoVeterinario,
    'tituloVeterinario': tituloVeterinario,
    'curriculumVeterinario': curriculumVeterinario,
    'imagenVeterinario': imagenVeterinario,
    'fechaAtencion': fechaAtencion,
    'sucursalVeterinario': sucursalVeterinario,
  };

  factory CitaAgendada.fromMap(Map<String, dynamic> data) => CitaAgendada(
    mascota: data['mascota']?.toString() ?? '',
    duenio: data['duenio']?.toString() ?? '',
    especie: data['especie']?.toString() ?? '',
    fecha: data['fecha']?.toString() ?? '',
    hora: data['hora']?.toString() ?? '09:00',
    imagenMascota: data['imagenMascota']?.toString() ?? '',
    veterinario: data['veterinario']?.toString() ?? '',
    especialidadVeterinario: data['especialidadVeterinario']?.toString() ?? '',
    telefonoVeterinario: data['telefonoVeterinario']?.toString() ?? '',
    correoVeterinario: data['correoVeterinario']?.toString() ?? '',
    tituloVeterinario: data['tituloVeterinario']?.toString() ?? '',
    curriculumVeterinario: data['curriculumVeterinario']?.toString() ?? '',
    imagenVeterinario: data['imagenVeterinario']?.toString() ?? '',
    fechaAtencion: data['fechaAtencion']?.toString() ?? '',
    sucursalVeterinario: data['sucursalVeterinario']?.toString() ?? '',
  );
}

class FirebaseRestService {
  static const String baseUrl = 'https://veterianaria-hill-default-rtdb.firebaseio.com';
  static const String sessionKey = 'vethills_session_email';

  static String claveCorreo(String correo) {
    return correo.trim().toLowerCase()
        .replaceAll('.', '_')
        .replaceAll('@', '_');
  }

  static Map<String, dynamic> _map(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }

  static Usuario _usuarioDesdeMapa(Map<String, dynamic> data, String fallbackEmail) {
    return Usuario(
      foto: data['foto']?.toString(),
      nombre: data['nombre']?.toString() ?? '',
      edad: data['edad']?.toString() ?? '',
      mascota: data['mascota']?.toString() ?? '',
      raza: data['raza']?.toString() ?? data['especie']?.toString() ?? '',
      fecha: data['fechaNacimiento']?.toString() ?? data['fecha']?.toString() ?? '',
      correo: data['correo']?.toString() ?? fallbackEmail,
      password: data['password']?.toString() ?? '',
    );
  }

  static Future<bool> guardarUsuario(Usuario usuario) async {
    try {
      final email = usuario.correo.trim().toLowerCase();
      final id = claveCorreo(email);
      final existente = await http.get(Uri.parse('$baseUrl/usuarios/$id.json'));
      if (existente.statusCode == 200 && existente.body != 'null') {
        return false;
      }
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': usuario.nombre,
          'edad': usuario.edad,
          'mascota': usuario.mascota,
          'raza': usuario.raza,
          'especie': usuario.raza.split(' • ').first,
          'fechaNacimiento': usuario.fecha,
          'fecha': usuario.fecha,
          'correo': email,
          'password': usuario.password,
          'estadoMascota': 'Sin revisión registrada',
          'ultimaVacuna': 'Sin vacunas registradas',
          'ultimoControl': 'Sin control registrado',
          'observacionesMascota': '',
          'creadoEn': DateTime.now().toIso8601String(),
          'actualizadoEn': DateTime.now().toIso8601String(),
        }),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint('Firebase guardarUsuario ERROR: $e');
      return false;
    }
  }

  static Future<Usuario?> obtenerUsuario(String correo) async {
    try {
      final email = correo.trim().toLowerCase();
      final response = await http.get(Uri.parse('$baseUrl/usuarios/${claveCorreo(email)}.json'));
      if (response.statusCode != 200 || response.body == 'null') return null;
      final data = _map(jsonDecode(response.body));
      if (data.isEmpty) return null;
      return _usuarioDesdeMapa(data, email);
    } catch (e) {
      debugPrint('Firebase obtenerUsuario ERROR: $e');
      return null;
    }
  }

  static Future<Usuario?> iniciarSesion(String correo, String password) async {
    try {
      final usuario = await obtenerUsuario(correo);
      if (usuario == null || usuario.password != password) return null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(sessionKey, usuario.correo);
      return usuario;
    } catch (e) {
      debugPrint('Firebase iniciarSesion ERROR: $e');
      return null;
    }
  }

  static Future<Usuario?> restaurarSesion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(sessionKey);
      if (email == null || email.trim().isEmpty) return null;
      return await obtenerUsuario(email);
    } catch (e) {
      debugPrint('Firebase restaurarSesion ERROR: $e');
      return null;
    }
  }

  static Future<void> cerrarSesion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(sessionKey);
    } catch (e) {
      debugPrint('Firebase cerrarSesion ERROR: $e');
    }
  }

  static Future<bool> actualizarUsuario(Usuario usuario) async {
    try {
      final id = claveCorreo(usuario.correo);
      final response = await http.patch(
        Uri.parse('$baseUrl/usuarios/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': usuario.nombre,
          'edad': usuario.edad,
          'mascota': usuario.mascota,
          'raza': usuario.raza,
          'fechaNacimiento': usuario.fecha,
          'correo': usuario.correo,
          'actualizadoEn': DateTime.now().toIso8601String(),
        }),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint('Firebase actualizarUsuario ERROR: $e');
      return false;
    }
  }

  static Future<bool> guardarCita(String correo, CitaAgendada cita) async {
    try {
      final id = claveCorreo(correo);
      final response = await http.post(
        Uri.parse('$baseUrl/citas/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({...cita.toMap(), 'creadaEn': DateTime.now().toIso8601String(), 'estado': 'Pendiente'}),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) return false;

      await http.post(
        Uri.parse('$baseUrl/usuarios/$id/citas.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({...cita.toMap(), 'creadaEn': DateTime.now().toIso8601String(), 'estado': 'Pendiente'}),
      );
      return true;
    } catch (e) {
      debugPrint('Firebase guardarCita ERROR: $e');
      return false;
    }
  }

  static Future<List<CitaAgendada>> obtenerCitas(String correo) async {
    try {
      final id = claveCorreo(correo);
      final response = await http.get(Uri.parse('$baseUrl/citas/$id.json'));
      if (response.statusCode != 200 || response.body == 'null') return [];
      final data = jsonDecode(response.body);
      if (data is! Map) return [];
      final citas = <CitaAgendada>[];
      for (final value in data.values) {
        if (value is Map) citas.add(CitaAgendada.fromMap(Map<String, dynamic>.from(value)));
      }
      citas.sort((a, b) => '${a.fecha} ${a.hora}'.compareTo('${b.fecha} ${b.hora}'));
      return citas;
    } catch (e) {
      debugPrint('Firebase obtenerCitas ERROR: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> obtenerCarnet(String correo) async {
    try {
      final id = claveCorreo(correo);
      final response = await http.get(Uri.parse('$baseUrl/carnets/$id.json'));
      if (response.statusCode != 200 || response.body == 'null') return {};
      return _map(jsonDecode(response.body));
    } catch (e) {
      debugPrint('Firebase obtenerCarnet ERROR: $e');
      return {};
    }
  }

  static Future<bool> guardarCarnet(String correo, Map<String, dynamic> carnet) async {
    try {
      final id = claveCorreo(correo);
      final datos = {
        ...carnet,
        'correo': correo.trim().toLowerCase(),
        'actualizadoEn': DateTime.now().toIso8601String(),
      };
      final response = await http.put(
        Uri.parse('$baseUrl/carnets/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(datos),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) return false;

      // También queda dentro del usuario para que el carnet esté ligado a su perfil.
      await http.patch(
        Uri.parse('$baseUrl/usuarios/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'carnetMascota': datos,
          'actualizadoEn': DateTime.now().toIso8601String(),
        }),
      );
      return true;
    } catch (e) {
      debugPrint('Firebase guardarCarnet ERROR: $e');
      return false;
    }
  }

  static Future<bool> guardarPedido(String correo, Map<String, dynamic> pedido) async {
    try {
      final id = claveCorreo(correo);
      final response = await http.post(
        Uri.parse('$baseUrl/pedidos/$id.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pedido),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint('Firebase guardarPedido ERROR: $e');
      return false;
    }
  }
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

  int? dia;
  int? mes;
  int? anio;
  String especie = 'Perro';
  bool mostrarPassword = false;
  bool guardando = false;

  final especies = const ['Perro', 'Gato', 'Ave', 'Conejo', 'Otro'];

  InputDecoration caja(String texto, IconData icono) => InputDecoration(
    hintText: texto,
    prefixIcon: Icon(icono, color: Colors.deepOrange),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Colors.orange, width: 2)),
  );

  @override
  void dispose() {
    nombre.dispose(); edad.dispose(); mascota.dispose(); raza.dispose(); fecha.dispose(); correo.dispose(); password.dispose();
    super.dispose();
  }

  Widget seccion(String titulo, String subtitulo, IconData icono) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(13),
      // ignore: deprecated_member_use
      decoration: BoxDecoration(color: Colors.white.withOpacity(.13), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withOpacity(.18))),
      child: Row(children: [
        Container(width: 42, height: 42, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icono, color: Colors.deepOrange)),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitulo, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ])),
      ]),
    );
  }

  Widget selectorFecha(String texto, int? valor, List<int> valores, ValueChanged<int?> onChanged) {
    return Expanded(child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(child: DropdownButton<int>(
        value: valor, isExpanded: true, hint: Text(texto), icon: const Icon(Icons.keyboard_arrow_down, color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(15),
        items: valores.map((v) => DropdownMenuItem(value: v, child: Text(v.toString().padLeft(2, '0')))).toList(),
        onChanged: onChanged,
      )),
    ));
  }

  void actualizarFecha() {
    if (dia != null && mes != null && anio != null) {
      fecha.text = '${dia!.toString().padLeft(2, '0')}/${mes!.toString().padLeft(2, '0')}/$anio';
    }
  }

  bool validar() {
    final nombreValido = RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñÜü ]+$").hasMatch(nombre.text.trim());
    final mascotaValida = RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñÜü0-9 ]+$").hasMatch(mascota.text.trim());
    final edadNumero = int.tryParse(edad.text.trim());
    final anioActual = DateTime.now().year;
    if (nombre.text.trim().isEmpty || !nombreValido) return _error('El nombre solo debe contener letras.');
    if (edadNumero == null || edadNumero < 16 || edadNumero > 100) return _error('La edad debe ser un número entre 16 y 100 años.');
    if (mascota.text.trim().isEmpty || !mascotaValida) return _error('Escribe correctamente el nombre de tu mascota.');
    if (raza.text.trim().isEmpty) return _error('Indica la raza o tipo de mascota.');
    if (dia == null || mes == null || anio == null) return _error('Selecciona día, mes y año de nacimiento.');
    if (anio! > 2009 || anio! < anioActual - 100) return _error('Selecciona un año de nacimiento válido (2009 o anterior).');
    if (!correo.text.trim().contains('@') || !correo.text.trim().contains('.')) return _error('Ingresa un correo electrónico válido.');
    if (password.text.length < 6) return _error('La contraseña debe tener al menos 6 caracteres.');
    return true;
  }

  bool _error(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje), backgroundColor: Colors.deepOrange));
    return false;
  }

  Future<void> crearCuenta() async {
    if (!validar() || guardando) return;
    setState(() => guardando = true);
    final usuario = Usuario(
      nombre: nombre.text.trim(), edad: edad.text.trim(), mascota: mascota.text.trim(),
      raza: '$especie • ${raza.text.trim()}', fecha: fecha.text,
      correo: correo.text.trim().toLowerCase(), password: password.text,
    );
    final ok = await FirebaseRestService.guardarUsuario(usuario);
    if (!mounted) return;
    setState(() => guardando = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? '¡Cuenta creada y guardada en Firebase!' : 'Ese correo ya existe o Firebase no está disponible.'),
      backgroundColor: ok ? Colors.green : Colors.red,
      duration: const Duration(seconds: 2),
    ));
    if (ok) Future.delayed(const Duration(milliseconds: 900), () { if (mounted) Navigator.pop(context, usuario); });
  }

  @override
  Widget build(BuildContext context) {
    final anios = List.generate(101, (i) => DateTime.now().year - 17 - i);
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, title: const Text('Crear Cuenta', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.orange.shade50, Colors.white, Colors.orange.shade50])),
        child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(18), child: Container(
          constraints: const BoxConstraints(maxWidth: 560), padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
          // ignore: deprecated_member_use
          decoration: BoxDecoration(color: const Color.fromARGB(255, 212, 103, 1), borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.deepOrange.withOpacity(.24), blurRadius: 24, offset: const Offset(0, 9))]),
          child: Column(children: [
            // ignore: unnecessary_underscores
            Container(width: 78, height: 78, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: ClipOval(child: Image.network(logoGif, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.person_add_alt_1, color: Colors.deepOrange, size: 40)))),
            const SizedBox(height: 12),
            const Text('Crear tu cuenta', style: TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Completa tu perfil paso a paso', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              // ignore: deprecated_member_use
              decoration: BoxDecoration(color: Colors.white.withOpacity(.14), borderRadius: BorderRadius.circular(18)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.looks_one, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text('Datos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.white54, size: 18),
                  SizedBox(width: 8),
                  Icon(Icons.pets, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text('Mascota', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.white54, size: 18),
                  SizedBox(width: 8),
                  Icon(Icons.lock, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text('Acceso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            seccion('1. Tus datos', '¿Cómo podemos identificarte?', Icons.person_outline),
            TextField(controller: nombre, textCapitalization: TextCapitalization.words, decoration: caja('Nombre completo', Icons.person_outline)),
            const SizedBox(height: 12),
            TextField(controller: edad, keyboardType: TextInputType.number, decoration: caja('¿Cuántos años tienes?', Icons.cake_outlined)),
            const SizedBox(height: 18),
            seccion('2. Fecha de nacimiento', 'Selecciona tu día, mes y año', Icons.calendar_month),
            Row(children: [
              selectorFecha('Día', dia, List.generate(31, (i) => i + 1), (v) => setState(() { dia = v; actualizarFecha(); })), const SizedBox(width: 8),
              selectorFecha('Mes', mes, List.generate(12, (i) => i + 1), (v) => setState(() { mes = v; actualizarFecha(); })), const SizedBox(width: 8),
              selectorFecha('Año', anio, anios, (v) => setState(() { anio = v; actualizarFecha(); })),
            ]),
            if (fecha.text.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Align(alignment: Alignment.centerLeft, child: Text('Nacimiento: ${fecha.text}', style: const TextStyle(color: Colors.white70, fontSize: 13)))),
            const SizedBox(height: 18),
            seccion('3. Tu mascota', 'Cuéntanos quién recibirá los cuidados', Icons.pets),
            Align(alignment: Alignment.centerLeft, child: const Text('¿Qué mascota tienes?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: especies.map((e) => ChoiceChip(label: Text(e), avatar: Icon(e == 'Perro' ? Icons.pets : e == 'Gato' ? Icons.pets : Icons.favorite, size: 18), selected: especie == e, selectedColor: Colors.white, backgroundColor: Colors.white24, labelStyle: TextStyle(color: especie == e ? Colors.deepOrange : Colors.white, fontWeight: FontWeight.bold), onSelected: (_) => setState(() => especie = e))).toList()),
            const SizedBox(height: 12),
            TextField(controller: mascota, textCapitalization: TextCapitalization.words, decoration: caja('Nombre de tu mascota', Icons.pets)),
            const SizedBox(height: 12),
            TextField(controller: raza, textCapitalization: TextCapitalization.words, decoration: caja('Raza o tipo', Icons.category_outlined)),
            const SizedBox(height: 18),
            seccion('4. Acceso', 'Estos datos te permitirán volver a entrar', Icons.lock_outline),
            TextField(controller: correo, keyboardType: TextInputType.emailAddress, decoration: caja('Correo electrónico', Icons.email_outlined)),
            const SizedBox(height: 12),
            TextField(controller: password, obscureText: !mostrarPassword, decoration: caja('Contraseña', Icons.lock_outline).copyWith(suffixIcon: IconButton(onPressed: () => setState(() => mostrarPassword = !mostrarPassword), icon: Icon(mostrarPassword ? Icons.visibility_off : Icons.visibility, color: Colors.deepOrange)))),
            const SizedBox(height: 7),
            const Align(alignment: Alignment.centerLeft, child: Text('Mínimo 6 caracteres.', style: TextStyle(color: Colors.white70, fontSize: 12))),
            const SizedBox(height: 22),
            SizedBox(width: double.infinity, height: 55, child: ElevatedButton.icon(onPressed: guardando ? null : crearCuenta, icon: guardando ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check_circle_outline), label: Text(guardando ? 'Guardando...' : 'Crear cuenta', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.deepOrange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))))),
            const SizedBox(height: 10),
            const Text('Tu información se guardará en Firebase para que puedas recuperarla al iniciar sesión.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
        ))),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final correo = TextEditingController();
  final password = TextEditingController();
  bool mostrarPassword = false;
  bool entrando = false;

  @override
  void dispose() { correo.dispose(); password.dispose(); super.dispose(); }

  Future<void> entrar() async {
    if (correo.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escribe tu correo y contraseña.')));
      return;
    }
    setState(() => entrando = true);
    final usuario = await FirebaseRestService.iniciarSesion(correo.text, password.text);
    if (!mounted) return;
    setState(() => entrando = false);
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Correo o contraseña incorrectos.'), backgroundColor: Colors.red));
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home(usuario: usuario)));
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // 1. Fondo con degradado
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF64B5F6),
              ],
            ),
          ),
        ),

        // 2. Elementos decorativos de fondo (Huellas)
        Positioned(
          top: -35,
          left: -25,
          child: _fondoPata(105),
        ),
        Positioned(
          top: 90,
          right: -35,
          child: _fondoPata(125),
        ),
        Positioned(
          bottom: 65,
          left: -45,
          child: _fondoPata(135),
        ),
        Positioned(
          bottom: -30,
          right: -25,
          child: _fondoPata(110),
        ),

        // 3. Encabezado superior (Logo y Títulos)
        Positioned(
          top: MediaQuery.of(context).size.height * .07,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(.18),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    logoGif,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    // ignore: unnecessary_underscores
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.pets,
                      size: 52,
                      color: Color.fromARGB(255, 233, 151, 29),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bienvenido a Veterinaria Hills',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Todo el cuidado de tu mascota en un solo lugar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        // 4. Formulario de Inicio de Sesión
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 205, 25, 25),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 120, 4),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(.22),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.lock_outline, color: Colors.white, size: 34),
                  const SizedBox(height: 7),
                  const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ingresa tus datos para continuar',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 22),

                  // Campo de Email
                  TextField(
                    controller: correo,
                    keyboardType: TextInputType.emailAddress,
                    decoration: input('Email').copyWith(
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Campo de Contraseña
                  TextField(
                    controller: password,
                    obscureText: !mostrarPassword,
                    decoration: input('Contraseña').copyWith(
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => mostrarPassword = !mostrarPassword),
                        icon: Icon(
                          mostrarPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Botón de Acceso
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: entrando ? null : entrar,
                      icon: entrando
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        entrando ? 'Comprobando...' : 'Acceder',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 223, 120, 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Divisor "o"
                  Row(
                    children: [
                      Expanded(
                        // ignore: deprecated_member_use
                        child: Divider(color: Colors.white.withOpacity(.45)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'o',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(
                        // ignore: deprecated_member_use
                        child: Divider(color: Colors.white.withOpacity(.45)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Botón de Registro
                  TextButton.icon(
                    onPressed: () async {
                      final usuario = await Navigator.push<Usuario?>(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                      if (usuario != null && context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Home(usuario: usuario)),
                        );
                      }
                    },
                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                    label: const Text(
                      'Crear cuenta nueva',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
static Widget _fondoPata(double size) => Opacity(
        opacity: .10,
        child: Icon(
          Icons.pets,
          size: size,
          color: Colors.white,
        ),
      );

  InputDecoration input(String t) => InputDecoration(
        hintText: t,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      );
}


class Home extends StatefulWidget {

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
    _prepararPerfil();
    if (widget.usuario != null) {
      cargarCitasFirebase();
      cargarCarnetFirebase();
    }
  }

  void _prepararPerfil() {
    final u = widget.usuario;
    perfilNombreController.text = u?.nombre ?? '';
    perfilCorreoController.text = u?.correo ?? '';
    perfilMascotaController.text = u?.mascota ?? '';
    perfilEdadController.text = u?.edad ?? '';
    perfilRazaController.text = u?.raza ?? '';
    perfilFechaController.text = u?.fecha ?? '';
  }

  Future<void> cargarCitasFirebase() async {
    final correo = widget.usuario?.correo;
    if (correo == null || correo.isEmpty) return;
    setState(() => cargandoCitas = true);
    final datos = await FirebaseRestService.obtenerCitas(correo);
    if (!mounted) return;
    setState(() {
      citasAgendadas = datos;
      cargandoCitas = false;
    });
  }

  Future<void> cargarCarnetFirebase() async {
    final correo = widget.usuario?.correo;
    if (correo == null || correo.isEmpty) return;
    setState(() => cargandoCarnet = true);
    final data = await FirebaseRestService.obtenerCarnet(correo);
    if (!mounted) return;
    setState(() {
      carnetVacunasController.text = data['vacunas']?.toString() ?? '';
      carnetControlesController.text = data['controles']?.toString() ?? '';
      carnetObservacionesController.text = data['observaciones']?.toString() ?? '';
      carnetEstadoController.text = data['estado']?.toString() ?? 'Activo';
      carnetPesoController.text = data['peso']?.toString() ?? '';
      cargandoCarnet = false;
    });
  }

  Future<void> guardarCarnetFirebase() async {
    final correo = widget.usuario?.correo ?? perfilCorreoController.text.trim();
    if (correo.isEmpty) return;
    setState(() => guardandoCarnet = true);
    final usuario = widget.usuario;
    final carnet = {
      'nombreMascota': perfilMascotaController.text.trim().isEmpty ? (usuario?.mascota ?? '') : perfilMascotaController.text.trim(),
      'dueno': perfilNombreController.text.trim().isEmpty ? (usuario?.nombre ?? '') : perfilNombreController.text.trim(),
      'especieRaza': perfilRazaController.text.trim().isEmpty ? (usuario?.raza ?? '') : perfilRazaController.text.trim(),
      'fechaNacimiento': perfilFechaController.text.trim().isEmpty ? (usuario?.fecha ?? '') : perfilFechaController.text.trim(),
      'edad': perfilEdadController.text.trim().isEmpty ? (usuario?.edad ?? '') : perfilEdadController.text.trim(),
      'peso': carnetPesoController.text.trim(),
      'vacunas': carnetVacunasController.text.trim(),
      'controles': carnetControlesController.text.trim(),
      'observaciones': carnetObservacionesController.text.trim(),
      'estado': carnetEstadoController.text.trim().isEmpty ? 'Activo' : carnetEstadoController.text.trim(),
      'citasRegistradas': citasAgendadas.length,
    };
    final ok = await FirebaseRestService.guardarCarnet(correo, carnet);
    if (!mounted) return;
    setState(() => guardandoCarnet = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? '🐾 Carnet guardado en Firebase.' : 'No se pudo guardar el carnet.'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    duenioCitaController.dispose();
    mascotaCitaController.dispose();
    especieCitaController.dispose();
    correoCitaController.dispose();
    buscadorController.dispose();
    perfilNombreController.dispose();
    perfilCorreoController.dispose();
    perfilMascotaController.dispose();
    perfilEdadController.dispose();
    perfilRazaController.dispose();
    perfilFechaController.dispose();
    carnetVacunasController.dispose();
    carnetControlesController.dispose();
    carnetObservacionesController.dispose();
    carnetEstadoController.dispose();
    carnetPesoController.dispose();
    super.dispose();
  }

bool registrado = false;
int pagina = 0;
bool menuAbierto = false;

// Fecha de la cita
int? diaSeleccionado;
int? mesSeleccionado;
int? anioSeleccionado;
String? horaSeleccionada;
bool cargandoCitas = false;

final List<String> horariosDisponibles = [
  for (int hora = 8; hora <= 18; hora++) ...[
    '${hora.toString().padLeft(2, '0')}:00',
    if (hora < 18) '${hora.toString().padLeft(2, '0')}:30',
  ],
];

final perfilNombreController = TextEditingController();
final perfilCorreoController = TextEditingController();
final perfilMascotaController = TextEditingController();
final perfilEdadController = TextEditingController();
final perfilRazaController = TextEditingController();
final perfilFechaController = TextEditingController();
final carnetVacunasController = TextEditingController();
final carnetControlesController = TextEditingController();
final carnetObservacionesController = TextEditingController();
final carnetEstadoController = TextEditingController();
final carnetPesoController = TextEditingController();
bool cargandoCarnet = false;
bool guardandoCarnet = false;


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
                    onPressed: () {
                      final telefono = veterinario["telefono"]!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Teléfono: $telefono"),
                          backgroundColor: Colors.green,
                        ),
                      );
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

Future<void> agendarCita() async {
  if (duenioCitaController.text.trim().isEmpty ||
      mascotaCitaController.text.trim().isEmpty ||
      especieCitaController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Completa los datos de la mascota y del dueño'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  if (diaSeleccionado == null || mesSeleccionado == null || anioSeleccionado == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Selecciona el día, mes y año de la cita'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  if (horaSeleccionada == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Selecciona una hora disponible'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  final fechaElegida = DateTime(anioSeleccionado!, mesSeleccionado!, diaSeleccionado!);
  if (fechaElegida.year != anioSeleccionado ||
      fechaElegida.month != mesSeleccionado ||
      fechaElegida.day != diaSeleccionado) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('La fecha seleccionada no es válida.'),
      backgroundColor: Colors.red,
    ));
    return;
  }
  final hoy = DateTime.now();
  final soloHoy = DateTime(hoy.year, hoy.month, hoy.day);
  if (fechaElegida.isBefore(soloHoy)) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No puedes agendar una cita en una fecha pasada.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  final veterinario = (List<Map<String, String>>.from(veterinariosDisponibles)..shuffle()).first;
  final fecha = '$diaSeleccionado de ${meses[mesSeleccionado! - 1]} de $anioSeleccionado';
  final sucursal = (List<String>.from(sucursalesDisponibles)..shuffle()).first;
  final nuevaCita = CitaAgendada(
    mascota: mascotaCitaController.text.trim(),
    duenio: duenioCitaController.text.trim(),
    especie: especieCitaController.text.trim(),
    fecha: fecha,
    hora: horaSeleccionada!,
    imagenMascota: imagenSegunEspecie(especieCitaController.text),
    veterinario: veterinario['nombre']!,
    especialidadVeterinario: veterinario['especialidad']!,
    telefonoVeterinario: veterinario['telefono']!,
    correoVeterinario: veterinario['correo']!,
    tituloVeterinario: veterinario['titulo']!,
    curriculumVeterinario: veterinario['curriculum']!,
    imagenVeterinario: veterinario['imagen']!,
    fechaAtencion: fecha,
    sucursalVeterinario: sucursal,
  );

  final correoFirebase = widget.usuario?.correo.trim().isNotEmpty == true
      ? widget.usuario!.correo
      : correoCitaController.text.trim();
  if (correoFirebase.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Inicia sesión para guardar la cita en Firebase.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  final guardada = await FirebaseRestService.guardarCita(correoFirebase, nuevaCita);
  if (!mounted) return;
  if (!guardada) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No se pudo guardar la cita en Firebase.'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  setState(() {
    citasAgendadas.add(nuevaCita);
    diaSeleccionado = null;
    mesSeleccionado = null;
    anioSeleccionado = null;
    horaSeleccionada = null;
  });

  duenioCitaController.clear();
  mascotaCitaController.clear();
  especieCitaController.clear();
  correoCitaController.clear();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Cita guardada con ${veterinario['nombre']} a las ${nuevaCita.hora}'),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
  ));
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

  // ==============================================================
  // CATÁLOGO PROFESIONAL DE VETERINARIA HILLS
  // ==============================================================
  // Se mantiene el estilo naranja del proyecto original. El catálogo
  // se guarda en memoria durante la sesión y permite buscar, filtrar,
  // ordenar, agregar, editar y eliminar productos.
  final List<Map<String, dynamic>> catalogoProfesional = [
    {
      "nombre": "Shampoo Pet",
      "precio": 250.0,
      "categoria": "Higiene",
      "descripcion": "Shampoo suave para perros y gatos.",
      "stock": 18,
      "imagen": "https://arteli.vtexassets.com/arquivos/ids/264546/7501022107379_00.jpg?v=638635829964730000",
    },
    {
      "nombre": "Arena para gato",
      "precio": 60.0,
      "categoria": "Higiene",
      "descripcion": "Arena absorbente para mantener limpio el arenero.",
      "stock": 25,
      "imagen": "https://i5.walmartimages.com.mx/mg/gm/3pp/asr/72c0aa6f-9d9a-4d81-9af8-d346d423612b.f8b354e48aba17ec9de3e28098e6648a.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff",
    },
    {
      "nombre": "Alimento Premium",
      "precio": 550.0,
      "categoria": "Alimentos",
      "descripcion": "Alimento balanceado para perros adultos.",
      "stock": 14,
      "imagen": "https://lagranbodega.vteximg.com.br/arquivos/ids/282795-1000-1000/7502002871167.jpg?v=637544425228870000",
    },
    {
      "nombre": "Transportadora",
      "precio": 850.0,
      "categoria": "Accesorios",
      "descripcion": "Transportadora cómoda y resistente para mascotas.",
      "stock": 7,
      "imagen": "https://ss345.liverpool.com.mx/xl/1154628602.jpg",
    },
    {
      "nombre": "Antipulgas",
      "precio": 320.0,
      "categoria": "Salud",
      "descripcion": "Producto de higiene y cuidado antipulgas.",
      "stock": 20,
      "imagen": "https://benitomoda.mx/cdn/shop/files/VERMIPLEX_bba75101-487d-4c2c-85d2-8b6d623c988e_4480x.jpg?v=1784411224",
    },
    {
      "nombre": "Correa para perro",
      "precio": 180.0,
      "categoria": "Accesorios",
      "descripcion": "Correa resistente para paseos diarios.",
      "stock": 30,
      "imagen": "https://img.nihaojewelry.com/fit-in/360x360/product/2024/1/9/1744605805648416768/Solid-Color-Dog-Leash-1-Piece-In-Simple-Style-With-PVC-Coated-And-Polyester-Webbing-For-All-Seasons-Ideal-For-Holiday-Use.jpg",
    },
    {
      "nombre": "Pasta dental veterinaria",
      "precio": 180.0,
      "categoria": "Higiene",
      "descripcion": "Cuidado dental para mascotas.",
      "stock": 12,
      "imagen": "https://arteli.vtexassets.com/arquivos/ids/264546/7501022107379_00.jpg?v=638635829964730000",
    },
    {
      "nombre": "Juguete Kong",
      "precio": 290.0,
      "categoria": "Juguetes",
      "descripcion": "Juguete resistente para entretenimiento.",
      "stock": 16,
      "imagen": "https://i5.walmartimages.com/asr/fd87a610-a9ec-4634-b1c6-2f72897cdc75.85bf760e0cf9792646f96e1c43f78da5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
    },
    {
      "nombre": "Cama suave",
      "precio": 460.0,
      "categoria": "Accesorios",
      "descripcion": "Cama acolchada para descanso.",
      "stock": 9,
      "imagen": "https://i5.walmartimages.com.mx/asr/6d9a4f45-6a88-4f6c-8e55-4c9c6d6b8c1d.3b3d3d3d3d3d3d3d.jpeg",
    },
    {
      "nombre": "Collar Seresto",
      "precio": 650.0,
      "categoria": "Salud",
      "descripcion": "Collar de protección para perros.",
      "stock": 11,
      "imagen": "https://img.nihaojewelry.com/fit-in/360x360/product/2024/1/9/1744605805648416768/Solid-Color-Dog-Leash-1-Piece-In-Simple-Style-With-PVC-Coated-And-Polyester-Webbing-For-All-Seasons-Ideal-For-Holiday-Use.jpg",
    },
    {
      "nombre": "Vitaminas para mascotas",
      "precio": 210.0,
      "categoria": "Salud",
      "descripcion": "Complemento de cuidado general.",
      "stock": 21,
      "imagen": "https://benitomoda.mx/cdn/shop/files/VERMIPLEX_bba75101-487d-4c2c-85d2-8b6d623c988e_4480x.jpg?v=1784411224",
    },
    {
      "nombre": "Comedero elevado",
      "precio": 340.0,
      "categoria": "Accesorios",
      "descripcion": "Comedero práctico para perros y gatos.",
      "stock": 13,
      "imagen": "https://i5.walmartimages.com.mx/mg/gm/3pp/asr/72c0aa6f-9d9a-4d81-9af8-d346d423612b.f8b354e48aba17ec9de3e28098e6648a.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff",
    },
    {
      "nombre": "Premios dentales",
      "precio": 95.0,
      "categoria": "Alimentos",
      "descripcion": "Premios para complementar la higiene dental.",
      "stock": 35,
      "imagen": "https://arteli.vtexassets.com/arquivos/ids/264546/7501022107379_00.jpg?v=638635829964730000",
    },
    {
      "nombre": "Rascador para gato",
      "precio": 520.0,
      "categoria": "Juguetes",
      "descripcion": "Rascador para juego y entretenimiento felino.",
      "stock": 8,
      "imagen": "https://i5.walmartimages.com/asr/fd87a610-a9ec-4634-b1c6-2f72897cdc75.85bf760e0cf9792646f96e1c43f78da5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
    },
    {
      "nombre": "Toallitas húmedas",
      "precio": 120.0,
      "categoria": "Higiene",
      "descripcion": "Toallitas para limpieza rápida.",
      "stock": 28,
      "imagen": "https://animall.com.mx/cdn/shop/files/Toallitas_humedas_para_perros.jpg?v=1766269184",
    },
    {
      "nombre": "Placa de identificación",
      "precio": 140.0,
      "categoria": "Accesorios",
      "descripcion": "Placa personalizable para identificación.",
      "stock": 19,
      "imagen": "https://img.nihaojewelry.com/fit-in/360x360/product/2024/1/9/1744605805648416768/Solid-Color-Dog-Leash-1-Piece-In-Simple-Style-With-PVC-Coated-And-Polyester-Webbing-For-All-Seasons-Ideal-For-Holiday-Use.jpg",
    },
  ];

  String categoriaProducto = "Todos";
  String ordenProductos = "Nombre";
  String busquedaProducto = "";
  String ultimoPedido = "";
  double totalUltimoPedido = 0;


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
  }

  double precioCarrito(Producto producto) {
    final limpio = producto.precio.replaceAll(RegExp(r'[$,]'), '');
    return double.tryParse(limpio) ?? 0;
  }

  int cantidadProductoCarrito(String nombre) {
    return carrito.where((producto) => producto.nombre == nombre).length;
  }

  List<Producto> productosUnicosCarrito() {
    final vistos = <String>{};
    final resultado = <Producto>[];
    for (final producto in carrito) {
      if (vistos.add(producto.nombre)) resultado.add(producto);
    }
    return resultado;
  }

  void cambiarCantidadCarrito(Producto producto, int cambio) {
    final cantidadActual = cantidadProductoCarrito(producto.nombre);
    if (cambio > 0) {
      final catalogo = catalogoProfesional.where((p) => p['nombre'].toString() == producto.nombre);
      final stock = catalogo.isEmpty ? 99 : (catalogo.first['stock'] as int? ?? 99);
      if (cantidadActual >= stock) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ya alcanzaste el stock disponible.'), backgroundColor: Colors.orange));
        return;
      }
      setState(() => carrito.add(producto));
    } else if (cantidadActual > 0) {
      final indice = carrito.lastIndexWhere((item) => item.nombre == producto.nombre);
      if (indice >= 0) setState(() => carrito.removeAt(indice));
    }
  }

  void cerrarSesionDesdeHome() async {
    await FirebaseRestService.cerrarSesion();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  void mostrarCarritoProfesional() {
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, actualizar) {
          final unicos = productosUnicosCarrito();
          final total = carrito.fold<double>(0, (sum, p) => sum + precioCarrito(p));
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Row(children: [
              const Icon(Icons.shopping_cart, color: Colors.orange),
              const SizedBox(width: 10),
              const Expanded(child: Text('Carrito de compras')),
              if (carrito.isNotEmpty) Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(20)),
                child: Text('${carrito.length}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ]),
            content: SizedBox(
              width: 470,
              height: 470,
              child: carrito.isEmpty
                  ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_cart_outlined, size: 82, color: Colors.orange), SizedBox(height: 15), Text('Tu carrito está vacío', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 6), Text('Agrega productos de la tienda para comenzar.', textAlign: TextAlign.center)]))
                  : ListView.separated(
                      itemCount: unicos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final producto = unicos[index];
                        final cantidad = cantidadProductoCarrito(producto.nombre);
                        final subtotal = precioCarrito(producto) * cantidad;
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(producto.imagen, width: 72, height: 72, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 72, height: 72, color: Colors.orange.shade50, child: const Icon(Icons.pets, color: Colors.orange, size: 38)))),
                              const SizedBox(width: 10),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(producto.nombre, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(height: 4),
                                Text(producto.precio, style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 7),
                                Row(children: [
                                  IconButton(onPressed: () { cambiarCantidadCarrito(producto, -1); actualizar(() {}); }, icon: const Icon(Icons.remove_circle_outline, color: Colors.orange)),
                                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)), child: Text('$cantidad', style: const TextStyle(fontWeight: FontWeight.bold))),
                                  IconButton(onPressed: () { cambiarCantidadCarrito(producto, 1); actualizar(() {}); }, icon: const Icon(Icons.add_circle, color: Colors.orange)),
                                ]),
                              ])),
                              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), IconButton(onPressed: () { setState(() => carrito.removeWhere((p) => p.nombre == producto.nombre)); actualizar(() {}); }, icon: const Icon(Icons.delete_outline, color: Colors.red))]),
                            ]),
                          ),
                        );
                      },
                    ),
            ),
            actions: [
              if (carrito.isNotEmpty) TextButton(onPressed: () { setState(() => carrito.clear()); actualizar(() {}); }, child: const Text('Vaciar')),
              Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.deepOrange)),
              const SizedBox(width: 4),
              ElevatedButton.icon(onPressed: carrito.isEmpty ? null : () { Navigator.pop(dialogContext); mostrarCheckoutProfesional(); }, icon: const Icon(Icons.shopping_bag), label: const Text('Comprar'), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white)),
            ],
          );
        },
      ),
    );
  }

  Widget dato(String titulo, String valor) {

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
    onChanged: (texto) {
       final consulta = texto.trim();
       setState(() {
         busquedaProducto = consulta;
         if (consulta.isNotEmpty) pagina = 1;
       });
     },
     onSubmitted: (texto) {
       setState(() {
         busquedaProducto = texto.trim();
         pagina = 1;
       });
     },
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
    tooltip: 'Carrito de compras',
    onPressed: mostrarCarritoProfesional,
    icon: Badge(
      label: Text('${carrito.length}'),
      isLabelVisible: carrito.isNotEmpty,
      child: const Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
        size: 30,
      ),
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
        botonSuperior("Nuestro equipo", 6),
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
    : pagina == 8
    ? carnetMascotaPage()
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
Icons.badge,
"Carnet de mi mascota",
8,
),

menuItem(
Icons.info,
"Acerca de",
5,
),

menuItem(
Icons.groups,
"Nuestro equipo",
6,
),

ListTile(
  leading: const Icon(Icons.logout, color: Colors.white),
  title: const Text(
    "Cerrar sesión",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  onTap: cerrarSesionDesdeHome,
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
              "https://i5.walmartimages.com/asr/fd87a610-a9ec-4634-b1c6-2f72897cdc75.85bf760e0cf9792646f96e1c43f78da5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
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
              agregarCarrito(Producto(
                nombre: productos[index]["nombre"]!,
                precio: productos[index]["precio"]!,
                imagen: productos[index]["imagen"]!,
              ));
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
    final consulta = texto.trim().toLowerCase();
    setState(() {
      busquedaProducto = consulta;
      resultadosBusqueda = catalogoProfesional
          .where((producto) {
            final stock = (producto['stock'] as num?)?.toInt() ?? 0;
            if (stock <= 0) return false;
            final nombre = producto['nombre'].toString().toLowerCase();
            final categoria = producto['categoria'].toString().toLowerCase();
            final descripcion = producto['descripcion'].toString().toLowerCase();
            return consulta.isEmpty || nombre.contains(consulta) || categoria.contains(consulta) || descripcion.contains(consulta);
          })
          .map((producto) => producto['nombre'].toString())
          .toList();
      if (consulta.isNotEmpty) pagina = 1;
    });
  }

Widget productosPage() {
  final categorias = <String>[
    "Todos",
    "Alimentos",
    "Higiene",
    "Salud",
    "Accesorios",
    "Juguetes",
  ];

  final filtrados = catalogoProfesional.where((producto) {
    final texto = busquedaProducto.toLowerCase();
    final stock = (producto["stock"] as num?)?.toInt() ?? 0;
    final coincideTexto = producto["nombre"].toString().toLowerCase().contains(texto) ||
        producto["categoria"].toString().toLowerCase().contains(texto) ||
        producto["descripcion"].toString().toLowerCase().contains(texto);
    final coincideCategoria = categoriaProducto == "Todos" || producto["categoria"] == categoriaProducto;
    return stock > 0 && coincideTexto && coincideCategoria;
  }).toList();

  if (ordenProductos == "Precio menor") {
    filtrados.sort((a, b) => (a["precio"] as double).compareTo(b["precio"] as double));
  } else if (ordenProductos == "Precio mayor") {
    filtrados.sort((a, b) => (b["precio"] as double).compareTo(a["precio"] as double));
  } else if (ordenProductos == "Stock") {
    filtrados.sort((a, b) => (b["stock"] as int).compareTo(a["stock"] as int));
  } else {
    filtrados.sort((a, b) => a["nombre"].toString().compareTo(b["nombre"].toString()));
  }

  return ListView(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
    children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade700, Colors.orange.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.storefront, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tienda VetHills", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Productos para el cuidado de tu mascota", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Badge(
              label: Text("${carrito.length}"),
              child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        onChanged: (valor) => setState(() => busquedaProducto = valor),
        decoration: InputDecoration(
          hintText: "Buscar productos...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: busquedaProducto.isEmpty
              ? null
              : IconButton(
                  onPressed: () => setState(() => busquedaProducto = ""),
                  icon: const Icon(Icons.clear),
                ),
          filled: true,
          fillColor: Colors.orange.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 42,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            final categoria = categorias[index];
            final activa = categoria == categoriaProducto;
            return ChoiceChip(
              label: Text(categoria),
              selected: activa,
              selectedColor: Colors.orange,
              labelStyle: TextStyle(color: activa ? Colors.white : Colors.black87, fontWeight: FontWeight.w600),
              onSelected: (_) => setState(() => categoriaProducto = categoria),
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const Text("Ordenar por", style: TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          DropdownButton<String>(
            value: ordenProductos,
            items: const [
              DropdownMenuItem(value: "Nombre", child: Text("Nombre")),
              DropdownMenuItem(value: "Precio menor", child: Text("Precio menor")),
              DropdownMenuItem(value: "Precio mayor", child: Text("Precio mayor")),
              DropdownMenuItem(value: "Stock", child: Text("Más stock")),
            ],
            onChanged: (valor) {
              if (valor != null) setState(() => ordenProductos = valor);
            },
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text("${filtrados.length} productos disponibles", style: TextStyle(color: Colors.grey.shade700)),
      const SizedBox(height: 12),
      if (filtrados.isEmpty)
        Container(
          padding: const EdgeInsets.all(35),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(20)),
          child: const Column(
            children: [
              Icon(Icons.search_off, size: 65, color: Colors.orange),
              SizedBox(height: 12),
              Text("No encontramos productos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("Prueba con otra palabra o categoría.", textAlign: TextAlign.center),
            ],
          ),
        )
      else
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtrados.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .64,
          ),
          itemBuilder: (context, index) {
            final producto = filtrados[index];
            final stock = producto["stock"] as int;
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => mostrarDetalleProductoProfesional(producto),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.orange.shade50,
                        child: Image.network(
                          producto["imagen"],
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.pets, size: 60, color: Colors.orange)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(producto["nombre"], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(producto["categoria"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text("\$${(producto["precio"] as double).toStringAsFixed(0)}", style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Spacer(),
                              Icon(stock > 0 ? Icons.check_circle : Icons.cancel, size: 15, color: stock > 0 ? Colors.green : Colors.red),
                              const SizedBox(width: 3),
                              Text("$stock", style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                          const SizedBox(height: 7),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: stock <= 0 ? null : () => agregarProductoProfesional(producto),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              icon: const Icon(Icons.add_shopping_cart, size: 17),
                              label: const Text("Agregar"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    ],
  );
}

void agregarProductoProfesional(Map<String, dynamic> data) {
  final producto = Producto(
    nombre: data["nombre"].toString(),
    precio: "\$${(data["precio"] as double).toStringAsFixed(0)}",
    imagen: data["imagen"].toString(),
  );
  agregarCarrito(producto);
}

void mostrarDetalleProductoProfesional(Map<String, dynamic> producto) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    builder: (_) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 18),
              Container(height: 230, width: double.infinity, decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(22)), child: Image.network(producto["imagen"], fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 90, color: Colors.orange))),
              const SizedBox(height: 18),
              Text(producto["nombre"], style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(producto["categoria"], style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text("\$${(producto["precio"] as double).toStringAsFixed(0)}", style: const TextStyle(fontSize: 25, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(producto["descripcion"], style: const TextStyle(fontSize: 16, height: 1.4)),
              const SizedBox(height: 12),
              Row(children: [const Icon(Icons.inventory_2, color: Colors.orange), const SizedBox(width: 8), Text("Stock disponible: ${producto["stock"]}")]),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, height: 52, child: ElevatedButton.icon(onPressed: (producto["stock"] as int) <= 0 ? null : () { Navigator.pop(context); agregarProductoProfesional(producto); }, icon: const Icon(Icons.shopping_cart), label: const Text("Agregar al carrito"), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
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
    final contenidoCalendario = calendarioProfesional();

  return ListView(
    padding: const EdgeInsets.all(20),
    children: [
      contenidoCalendario,
      const SizedBox(height: 16),

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
        3,
        (index) {
          final anio = DateTime.now().year + index;

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

      const SizedBox(height: 15),
      const Text(
        'Hora de la cita',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        value: horaSeleccionada,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: 'Selecciona una hora',
          prefixIcon: const Icon(Icons.access_time, color: Colors.orange),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        items: horariosDisponibles.map((hora) => DropdownMenuItem(
          value: hora,
          child: Text(hora),
        )).toList(),
        onChanged: (valor) => setState(() => horaSeleccionada = valor),
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

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hora: ${cita.hora}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget carnetMascotaPage() {
    final usuario = widget.usuario;
    final nombreMascota = perfilMascotaController.text.trim().isEmpty ? (usuario?.mascota ?? 'Mi mascota') : perfilMascotaController.text.trim();
    final dueno = perfilNombreController.text.trim().isEmpty ? (usuario?.nombre ?? 'Sin registrar') : perfilNombreController.text.trim();
    final especieRaza = perfilRazaController.text.trim().isEmpty ? (usuario?.raza ?? 'Sin registrar') : perfilRazaController.text.trim();
    final fechaNacimiento = perfilFechaController.text.trim().isEmpty ? (usuario?.fecha ?? 'Sin registrar') : perfilFechaController.text.trim();
    final edad = perfilEdadController.text.trim().isEmpty ? (usuario?.edad ?? 'Sin registrar') : perfilEdadController.text.trim();

    if (cargandoCarnet) return const EstadoCargaVetHills(mensaje: 'Cargando carnet de tu mascota...');

    return RefreshIndicator(
      color: Colors.orange,
      onRefresh: cargarCarnetFirebase,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xfff59d17), Color(0xffd96b04)]),
              borderRadius: BorderRadius.circular(24),
              // ignore: deprecated_member_use
              boxShadow: [BoxShadow(color: Colors.orange.withOpacity(.25), blurRadius: 16, offset: const Offset(0, 8))],
            ),
            child: Row(children: [
              Container(
                width: 76, height: 76,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.pets, size: 44, color: Colors.orange),
              ),
              const SizedBox(width: 15),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('CARNET DIGITAL', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const SizedBox(height: 4),
                Text(nombreMascota, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                Text('Dueño: $dueno', style: const TextStyle(color: Colors.white, fontSize: 13)),
              ])),
            ]),
          ),
          const SizedBox(height: 18),
          SeccionVetHills(
            titulo: 'Datos de la mascota',
            icono: Icons.pets,
            child: Column(children: [
              TarjetaDatoVetHills(icono: Icons.category, titulo: 'Especie / raza', subtitulo: especieRaza),
              const SizedBox(height: 10),
              TarjetaDatoVetHills(icono: Icons.cake, titulo: 'Fecha de nacimiento', subtitulo: fechaNacimiento),
              const SizedBox(height: 10),
              TarjetaDatoVetHills(icono: Icons.calendar_today, titulo: 'Edad', subtitulo: '$edad años'),
            ]),
          ),
          SeccionVetHills(
            titulo: 'Estado actual',
            icono: Icons.favorite,
            child: TextField(
              controller: carnetEstadoController,
              decoration: const InputDecoration(labelText: 'Estado de la mascota', prefixIcon: Icon(Icons.favorite, color: Colors.orange), border: OutlineInputBorder()),
            ),
          ),
          SeccionVetHills(
            titulo: 'Control de salud',
            icono: Icons.monitor_heart,
            child: Column(children: [
              TextField(controller: carnetPesoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Peso (kg)', prefixIcon: Icon(Icons.monitor_weight, color: Colors.orange), border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: carnetControlesController, maxLines: 4, decoration: const InputDecoration(labelText: 'Controles veterinarios', hintText: 'Fecha, revisión, resultados...', prefixIcon: Icon(Icons.medical_information, color: Colors.orange), border: OutlineInputBorder())),
            ]),
          ),
          SeccionVetHills(
            titulo: 'Vacunas',
            icono: Icons.vaccines,
            child: TextField(
              controller: carnetVacunasController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Vacunas registradas', hintText: 'Ej. Rabia — 12/08/2026', prefixIcon: Icon(Icons.vaccines, color: Colors.orange), border: OutlineInputBorder()),
            ),
          ),
          SeccionVetHills(
            titulo: 'Observaciones',
            icono: Icons.notes,
            child: TextField(
              controller: carnetObservacionesController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Observaciones de la mascota', prefixIcon: Icon(Icons.notes, color: Colors.orange), border: OutlineInputBorder()),
            ),
          ),
          SeccionVetHills(
            titulo: 'Citas de esta mascota',
            icono: Icons.event_available,
            child: citasAgendadas.isEmpty
                ? const Padding(padding: EdgeInsets.all(12), child: Text('Todavía no hay citas registradas.'))
                : Column(children: citasAgendadas.map((cita) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.event, color: Colors.white)),
                      title: Text(cita.mascota.isEmpty ? nombreMascota : cita.mascota, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${cita.fecha} • ${cita.hora}\n${cita.veterinario}'),
                      isThreeLine: true,
                    ),
                  )).toList()),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: guardandoCarnet ? null : guardarCarnetFirebase,
              icon: guardandoCarnet ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.cloud_upload),
              label: Text(guardandoCarnet ? 'Guardando...' : 'Guardar carnet en Firebase'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
            ),
          ),
        ],
      ),
    );
  }

   Widget perfilPage() {
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
                child: Icon(Icons.person, color: Colors.white, size: 70),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.orange),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El perfil está listo para recibir una foto.'))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextField(controller: perfilNombreController, decoration: const InputDecoration(labelText: 'Tu nombre', prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 15),
          TextField(controller: perfilCorreoController, readOnly: true, decoration: const InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email))),
          const SizedBox(height: 15),
          TextField(controller: perfilMascotaController, decoration: const InputDecoration(labelText: 'Nombre de tu mascota', prefixIcon: Icon(Icons.pets))),
          const SizedBox(height: 15),
          TextField(controller: perfilEdadController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Edad', prefixIcon: Icon(Icons.cake))),
          const SizedBox(height: 15),
          TextField(controller: perfilRazaController, decoration: const InputDecoration(labelText: 'Raza o tipo', prefixIcon: Icon(Icons.category))),
          const SizedBox(height: 15),
          TextField(controller: perfilFechaController, readOnly: true, decoration: const InputDecoration(labelText: 'Fecha de nacimiento', prefixIcon: Icon(Icons.calendar_month))),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: guardarPerfilFirebase,
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> guardarPerfilFirebase() async {
    final correo = widget.usuario?.correo ?? perfilCorreoController.text.trim();
    if (correo.isEmpty) return;
    final actual = widget.usuario ?? Usuario(nombre: '', edad: '', mascota: '', raza: '', fecha: '', correo: correo, password: '');
    final actualizado = Usuario(
      foto: actual.foto,
      nombre: perfilNombreController.text.trim(),
      edad: perfilEdadController.text.trim(),
      mascota: perfilMascotaController.text.trim(),
      raza: perfilRazaController.text.trim(),
      fecha: perfilFechaController.text.trim(),
      correo: correo,
      password: actual.password,
    );
    final ok = await FirebaseRestService.actualizarUsuario(actualizado);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil guardado en Firebase.'), backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se pudo guardar el perfil.'), backgroundColor: Colors.red));
    }
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
                      // ignore: unnecessary_underscores
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

// ignore: non_constant_identifier_names

// ==============================================================
// CHECKOUT PROFESIONAL
// ==============================================================
void mostrarCheckoutProfesional() {
  if (carrito.isEmpty) return;

  final direccionController = TextEditingController();
  final telefonoController = TextEditingController();
  String metodoPago = "Tarjeta";
  bool procesando = false;

  double precioDeProducto(String precio) {
// ignore: dead_code, unnecessary_null_comparison
String limpio = precio != null ? precio.replaceAll(RegExp(r'[$,]'), '') : '';
    return double.tryParse(limpio) ?? 0;
  }

  double total = carrito.fold(0, (suma, producto) => suma + precioDeProducto(producto.precio));

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => StatefulBuilder(
      builder: (dialogContext, actualizar) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Row(children: [Icon(Icons.lock_outline, color: Colors.orange), SizedBox(width: 10), Text("Finalizar compra")]),
          content: SizedBox(
            width: 470,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Datos de entrega", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 10),
                  TextField(controller: direccionController, decoration: const InputDecoration(labelText: "Dirección", prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  TextField(controller: telefonoController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "Teléfono", prefixIcon: Icon(Icons.phone), border: OutlineInputBorder())),
                  const SizedBox(height: 18),
                  const Text("Método de pago", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  // ignore: deprecated_member_use
                  RadioListTile<String>(value: "Tarjeta", groupValue: metodoPago, title: const Text("Tarjeta de crédito / débito"), onChanged: (v) => actualizar(() => metodoPago = v!)),
                  // ignore: deprecated_member_use
                  RadioListTile<String>(value: "Transferencia", groupValue: metodoPago, title: const Text("Transferencia bancaria"), onChanged: (v) => actualizar(() => metodoPago = v!)),
                  // ignore: deprecated_member_use
                  RadioListTile<String>(value: "Efectivo", groupValue: metodoPago, title: const Text("Efectivo contra entrega"), onChanged: (v) => actualizar(() => metodoPago = v!)),
                  const Divider(height: 20),
                  Row(children: [const Text("Productos"), const Spacer(), Text("${carrito.length}")]),
                  const SizedBox(height: 6),
                  Row(children: [const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text("\$${total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 18))]),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: procesando ? null : () => Navigator.pop(dialogContext), child: const Text("Cancelar")),
            ElevatedButton.icon(
              onPressed: procesando
                  ? null
                  : () {
                      if (direccionController.text.trim().length < 8 || telefonoController.text.trim().length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Completa dirección y teléfono correctamente"), backgroundColor: Colors.red));
                        return;
                      }
                      actualizar(() => procesando = true);
                      () async {
                        final pedido = "VH-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";
                        final items = productosUnicosCarrito().map((p) => {
                          'nombre': p.nombre,
                          'precio': precioCarrito(p),
                          'cantidad': cantidadProductoCarrito(p.nombre),
                        }).toList();
                        final correo = widget.usuario?.correo ?? 'invitado';
                        final guardado = await FirebaseRestService.guardarPedido(correo, {
                          'numeroPedido': pedido,
                          'creadoEn': DateTime.now().toIso8601String(),
                          'direccion': direccionController.text.trim(),
                          'telefono': telefonoController.text.trim(),
                          'metodoPago': metodoPago,
                          'total': total,
                          'items': items,
                          'estado': 'Pendiente',
                        });
                        if (!mounted) return;
                        if (!guardado) {
                          actualizar(() => procesando = false);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se pudo guardar el pedido en Firebase.'), backgroundColor: Colors.red));
                          return;
                        }
                        setState(() {
                          ultimoPedido = pedido;
                          totalUltimoPedido = total;
                          carrito.clear();
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pop(dialogContext);
                        mostrarCompraExitosa(total);
                      }();
                    },
              icon: const Icon(Icons.check_circle),
              label: Text(procesando ? "Procesando..." : "Confirmar compra"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            ),
          ],
        );
      },
    ),
  );
}

void mostrarCompraExitosa(double total) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const CircleAvatar(radius: 36, backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white, size: 42)),
        const SizedBox(height: 15),
        const Text("¡Compra realizada!", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 7),
        const Text("Tu pedido fue confirmado y está listo para procesarse.", textAlign: TextAlign.center),
        const SizedBox(height: 15),
        Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(14)), child: Column(children: [const Text("Número de pedido"), const SizedBox(height: 4), Text(ultimoPedido, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text("Total: \$${total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange))])),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white), child: const Text("Continuar comprando"))),
      ]),
    ),
  );
}

// ==============================================================
// CALENDARIO PROFESIONAL
// ==============================================================
Widget calendarioProfesional() {
  final hoy = DateTime.now();
  final fechaElegida = (diaSeleccionado != null && mesSeleccionado != null && anioSeleccionado != null)
      ? DateTime(anioSeleccionado!, mesSeleccionado!, diaSeleccionado!)
      : hoy;

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.calendar_month, color: Colors.orange, size: 30), const SizedBox(width: 10), const Expanded(child: Text("Calendario de citas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))), IconButton(onPressed: () async { final fecha = await showDatePicker(context: context, initialDate: fechaElegida, firstDate: hoy, lastDate: DateTime(hoy.year + 2), builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)), child: child!)); if (fecha != null) { setState(() { diaSeleccionado = fecha.day; mesSeleccionado = fecha.month; anioSeleccionado = fecha.year; }); } }, icon: const Icon(Icons.edit_calendar, color: Colors.orange))]),
        const SizedBox(height: 10),
        Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade50, Colors.white]), borderRadius: BorderRadius.circular(16)), child: Row(children: [const Icon(Icons.event_available, color: Colors.deepOrange), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Fecha seleccionada", style: TextStyle(color: Colors.grey)), const SizedBox(height: 3), Text("${fechaElegida.day.toString().padLeft(2, '0')}/${fechaElegida.month.toString().padLeft(2, '0')}/${fechaElegida.year}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])])),
        const SizedBox(height: 14),
        Wrap(spacing: 8, runSpacing: 8, children: List.generate(7, (i) { final d = hoy.add(Duration(days: i)); final activo = d.day == fechaElegida.day && d.month == fechaElegida.month && d.year == fechaElegida.year; return InkWell(onTap: () => setState(() { diaSeleccionado = d.day; mesSeleccionado = d.month; anioSeleccionado = d.year; }), borderRadius: BorderRadius.circular(14), child: Container(width: 72, padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: activo ? Colors.orange : Colors.orange.shade50, borderRadius: BorderRadius.circular(14)), child: Column(children: [Text(["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"][d.weekday - 1], style: TextStyle(color: activo ? Colors.white : Colors.grey.shade700, fontSize: 12)), const SizedBox(height: 4), Text("${d.day}", style: TextStyle(color: activo ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 17))]))); }))
      ]),
    ),
  );
}

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

          "Versión 1.0.5",

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
          leading: const Icon(
            Icons.facebook,
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
          leading: const Icon(
            Icons.camera_alt,
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
          leading: const Icon(
            Icons.music_note,
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

MapaSucursalesWidget(),
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

// ============================================================================
// MAPA DE SUCURSALES VETHILLS
// ============================================================================
// Widget autónomo sin dependencias externas. Esto evita errores de paquetes y
// mantiene el proyecto funcionando aun cuando no exista conexión a mapas.
class MapaSucursalesWidget extends StatefulWidget {
  const MapaSucursalesWidget({super.key});

  @override
  State<MapaSucursalesWidget> createState() => _MapaSucursalesWidgetState();
}

class _MapaSucursalesWidgetState extends State<MapaSucursalesWidget> {
  int sucursalSeleccionada = 0;
  final sucursales = const [
    {"nombre": "Sucursal Centro", "direccion": "Av. Principal 123", "telefono": "55 1234 5678"},
    {"nombre": "Sucursal Norte", "direccion": "Av. Aguascalientes Norte 456", "telefono": "449 765 4321"},
    {"nombre": "Sucursal Sur", "direccion": "Coyoacán 789", "telefono": "55 9876 5432"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 230,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.orange.shade100),
          ),
          child: Stack(
            children: [
              CustomPaint(size: Size.infinite, painter: VetMapPainter()),
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final puntos = [
                      Offset(constraints.maxWidth * .25, constraints.maxHeight * .30),
                      Offset(constraints.maxWidth * .68, constraints.maxHeight * .42),
                      Offset(constraints.maxWidth * .47, constraints.maxHeight * .72),
                    ];
                    return Stack(
                      children: List.generate(puntos.length, (index) {
                        final seleccionado = index == sucursalSeleccionada;
                        return Positioned(
                          left: puntos[index].dx - 20,
                          top: puntos[index].dy - 42,
                          child: GestureDetector(
                            onTap: () => setState(() => sucursalSeleccionada = index),
                            child: AnimatedScale(
                              scale: seleccionado ? 1.15 : 1,
                              duration: const Duration(milliseconds: 180),
                              child: Column(
                                children: [
                                  Icon(Icons.location_on, size: 40, color: seleccionado ? Colors.deepOrange : Colors.orange),
                                  if (seleccionado)
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)]), child: Text(sucursales[index]["nombre"]!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Positioned(top: 12, right: 12, child: Container(padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.map, color: Colors.orange))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.location_on, color: Colors.white)),
            title: Text(sucursales[sucursalSeleccionada]["nombre"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${sucursales[sucursalSeleccionada]["direccion"]}\nTel. ${sucursales[sucursalSeleccionada]["telefono"]}"),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right, color: Colors.orange),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sucursales.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) => ChoiceChip(
              label: Text(sucursales[index]["nombre"]!),
              selected: index == sucursalSeleccionada,
              selectedColor: Colors.orange,
              labelStyle: TextStyle(color: index == sucursalSeleccionada ? Colors.white : Colors.black87),
              onSelected: (_) => setState(() => sucursalSeleccionada = index),
            ),
          ),
        ),
      ],
    );
  }
}

class VetMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fondo = Paint()..color = const Color(0xfff5f7f2);
    canvas.drawRect(Offset.zero & size, fondo);

    final calle = Paint()
      ..color = Colors.white
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke;
    final secundaria = Paint()
      ..color = const Color(0xffe7e9e4)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final rutas = [
      Path()..moveTo(0, size.height * .22)..quadraticBezierTo(size.width * .35, size.height * .45, size.width, size.height * .18),
      Path()..moveTo(0, size.height * .72)..quadraticBezierTo(size.width * .48, size.height * .55, size.width, size.height * .82),
      Path()..moveTo(size.width * .35, 0)..quadraticBezierTo(size.width * .58, size.height * .45, size.width * .42, size.height),
    ];
    for (final ruta in rutas) {
      canvas.drawPath(ruta, calle);
      canvas.drawPath(ruta, secundaria);
    }

    final parque = Paint()..color = const Color(0xffdcefd5);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * .04, size.height * .42, size.width * .20, size.height * .22), const Radius.circular(18)), parque);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * .70, size.height * .08, size.width * .24, size.height * .18), const Radius.circular(18)), parque);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// MODELO DE PRUEBAS Y VALIDACIONES
// ============================================================================
// Estas clases documentan las pruebas que la aplicación puede realizar y
// sirven como base para el manual técnico solicitado por la rúbrica.
class ResultadoValidacion {
  final bool correcto;
  final String mensaje;

  const ResultadoValidacion({required this.correcto, required this.mensaje});
}

class ValidacionesVetHills {
  static ResultadoValidacion obligatorio(String? valor, String campo) {
    if (valor == null || valor.trim().isEmpty) {
      return ResultadoValidacion(correcto: false, mensaje: "$campo es obligatorio.");
    }
    return const ResultadoValidacion(correcto: true, mensaje: "Correcto");
  }

  static ResultadoValidacion longitud(String? valor, String campo, int minimo) {
    if (valor == null || valor.trim().length < minimo) {
      return ResultadoValidacion(correcto: false, mensaje: "$campo debe tener al menos $minimo caracteres.");
    }
    return const ResultadoValidacion(correcto: true, mensaje: "Correcto");
  }

  static ResultadoValidacion correo(String? valor) {
    final patron = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (valor == null || !patron.hasMatch(valor.trim())) {
      return const ResultadoValidacion(correcto: false, mensaje: "Correo electrónico no válido.");
    }
    return const ResultadoValidacion(correcto: true, mensaje: "Correo válido.");
  }

  static ResultadoValidacion telefono(String? valor) {
    final patron = RegExp(r'^[0-9+()\-\s]{8,18}$');
    if (valor == null || !patron.hasMatch(valor.trim())) {
      return const ResultadoValidacion(correcto: false, mensaje: "Teléfono no válido.");
    }
    return const ResultadoValidacion(correcto: true, mensaje: "Teléfono válido.");
  }

  static ResultadoValidacion password(String? valor) {
    if (valor == null || valor.length < 6) {
      return const ResultadoValidacion(correcto: false, mensaje: "La contraseña debe tener mínimo 6 caracteres.");
    }
    return const ResultadoValidacion(correcto: true, mensaje: "Contraseña válida.");
  }
}

// ============================================================================
// CRUD DE PRODUCTOS PARA EL MANUAL TÉCNICO
// ============================================================================
class ProductoRepository {
  final List<Map<String, dynamic>> registros = [];

  void agregar(Map<String, dynamic> producto) {
    registros.add(Map<String, dynamic>.from(producto));
  }

  bool editar(int indice, Map<String, dynamic> producto) {
    if (indice < 0 || indice >= registros.length) return false;
    registros[indice] = Map<String, dynamic>.from(producto);
    return true;
  }

  bool eliminar(int indice) {
    if (indice < 0 || indice >= registros.length) return false;
    registros.removeAt(indice);
    return true;
  }

  List<Map<String, dynamic>> buscar(String texto) {
    final consulta = texto.toLowerCase().trim();
    return registros.where((item) => item.values.any((valor) => valor.toString().toLowerCase().contains(consulta))).toList();
  }

  List<Map<String, dynamic>> ordenarPorPrecio({bool ascendente = true}) {
    final copia = List<Map<String, dynamic>>.from(registros);
    copia.sort((a, b) {
      final aPrecio = (a["precio"] as num?)?.toDouble() ?? 0;
      final bPrecio = (b["precio"] as num?)?.toDouble() ?? 0;
      return ascendente ? aPrecio.compareTo(bPrecio) : bPrecio.compareTo(aPrecio);
    });
    return copia;
  }
}

// ============================================================================
// COMPONENTES REUTILIZABLES
// ============================================================================
class SeccionVetHills extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Widget child;
  final VoidCallback? accion;

  const SeccionVetHills({super.key, required this.titulo, required this.icono, required this.child, this.accion});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)), child: Icon(icono, color: Colors.orange)), const SizedBox(width: 10), Expanded(child: Text(titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), if (accion != null) IconButton(onPressed: accion, icon: const Icon(Icons.arrow_forward_ios, size: 17, color: Colors.orange))]),
          const SizedBox(height: 12),
          child,
        ]),
      ),
    );
  }
}

class TarjetaDatoVetHills extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;

  const TarjetaDatoVetHills({super.key, required this.icono, required this.titulo, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(15)),
      child: Row(children: [Icon(icono, color: Colors.orange), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 2), Text(subtitulo, style: TextStyle(color: Colors.grey.shade700))]))]),
    );
  }
}

class EstadoCargaVetHills extends StatelessWidget {
  final String mensaje;

  const EstadoCargaVetHills({super.key, this.mensaje = "Cargando información..."});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [const CircularProgressIndicator(color: Colors.orange), const SizedBox(height: 14), Text(mensaje)])));
  }
}

// ============================================================================
// DATOS DE EJEMPLO PARA DOCUMENTACIÓN Y PRUEBAS
// ============================================================================
const List<Map<String, String>> casosPruebaVetHills = [
  {"caso": "Navegación", "resultado": "Cambiar entre Inicio, Productos, Citas, Nuestro equipo, Perfil y Citas Agendadas."},
  {"caso": "Formulario vacío", "resultado": "Mostrar mensajes y evitar guardar datos incompletos."},
  {"caso": "Correo inválido", "resultado": "Rechazar correo sin estructura válida."},
  {"caso": "Contraseña corta", "resultado": "Rechazar contraseña menor a seis caracteres."},
  {"caso": "Registro", "resultado": "Crear usuario y mostrar confirmación."},
  {"caso": "Edición", "resultado": "Modificar datos del perfil."},
  {"caso": "Eliminación", "resultado": "Eliminar producto del carrito."},
  {"caso": "Búsqueda", "resultado": "Filtrar productos por nombre y categoría."},
  {"caso": "Ordenamiento", "resultado": "Ordenar por nombre, precio o stock."},
  {"caso": "Carrito", "resultado": "Agregar productos, revisar total y finalizar compra."},
  {"caso": "Compra", "resultado": "Generar número de pedido y vaciar el carrito."},
  {"caso": "Calendario", "resultado": "Seleccionar fecha de atención veterinaria."},
  {"caso": "Doctores", "resultado": "Abrir ficha detallada al tocar un veterinario."},
  {"caso": "Mapa", "resultado": "Seleccionar sucursales mediante marcadores."},
  {"caso": "Error de imagen", "resultado": "Mostrar icono de mascota como respaldo."},
];

// ============================================================================


// ============================================================================
// DOCUMENTACIÓN TÉCNICA EXTENDIDA VETHILLS
// ============================================================================
// Esta sección conserva reglas funcionales y ejemplos de validación del proyecto.
// No modifica la interfaz visual; sirve como referencia para mantenimiento.

class VetHillsReglasNegocio {
  static const String nombreAplicacion = 'Veterinaria Hills';
  static const String baseFirebase = 'https://veterianaria-hill-default-rtdb.firebaseio.com';
  static const String rutaUsuarios = '/usuarios';
  static const String rutaCitas = '/citas';
  static const String rutaPedidos = '/pedidos';

  static bool nombreValido(String valor) {
    return RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñÜü ]+$").hasMatch(valor.trim());
  }

  static bool correoValido(String valor) {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(valor.trim());
  }

  static bool edadValida(String valor) {
    final edad = int.tryParse(valor.trim());
    return edad != null && edad >= 16 && edad <= 100;
  }

  static bool fechaCitaValida(DateTime fecha) {
    final hoy = DateTime.now();
    final inicioHoy = DateTime(hoy.year, hoy.month, hoy.day);
    return !fecha.isBefore(inicioHoy);
  }

  static bool horaValida(String valor) {
    return RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(valor);
  }
}

class VetHillsAuditoria {
  final List<String> eventos = [];

  void registrar(String evento) {
    eventos.add('${DateTime.now().toIso8601String()} | $evento');
  }

  List<String> recientes([int cantidad = 20]) {
    if (eventos.length <= cantidad) return List<String>.from(eventos);
    return eventos.sublist(eventos.length - cantidad);
  }
}

class VetHillsCarritoResumen {
  static Map<String, dynamic> construir(List<Producto> productos, double Function(Producto) precio) {
    final cantidades = <String, int>{};
    final subtotales = <String, double>{};
    for (final producto in productos) {
      cantidades.update(producto.nombre, (valor) => valor + 1, ifAbsent: () => 1);
      subtotales.update(producto.nombre, (valor) => valor + precio(producto), ifAbsent: () => precio(producto));
    }
    final total = subtotales.values.fold<double>(0, (a, b) => a + b);
    return {
      'unidades': productos.length,
      'productos': cantidades,
      'subtotales': subtotales,
      'total': total,
    };
  }
}

// ============================================================================
// CASOS DE PRUEBA MANUALES
// ============================================================================
// 001 Registro válido
// 002 Registro con nombre numérico
// 003 Registro con correo inválido
// 004 Registro con correo repetido
// 005 Inicio de sesión correcto
// 006 Inicio de sesión incorrecto
// 007 Cerrar sesión
// 008 Restaurar sesión después de recargar
// 009 Guardar perfil
// 010 Guardar cita
// 011 Recuperar citas
// 012 Cita con fecha pasada
// 013 Cita sin hora
// 014 Buscar producto por nombre
// 015 Buscar producto por categoría
// 016 Buscar producto por descripción
// 017 Ocultar producto sin stock
// 018 Agregar producto al carrito
// 019 Aumentar cantidad
// 020 Disminuir cantidad
// 021 Eliminar producto
// 022 Vaciar carrito
// 023 Finalizar compra
// 024 Guardar pedido en Firebase
// 025 Abrir ficha del equipo veterinario
// 026 Abrir citas agendadas
// 027 Abrir calendario
// 028 Seleccionar día
// 029 Seleccionar mes
// 030 Seleccionar año
// 031 Seleccionar hora
// 032 Volver al inicio
// 033 Navegar a productos
// 034 Navegar a citas
// 035 Navegar a Nuestro equipo
// 036 Navegar a perfil
// 037 Cerrar sesión desde menú
// 038 Validar contraseña corta
// 039 Validar edad
// 040 Validar nombre
// 041 Validar fecha de nacimiento
// 042 Confirmar persistencia Firebase
// 043 Confirmar persistencia local
// 044 Confirmar contador carrito
// 045 Confirmar subtotal
// 046 Confirmar total
// 047 Confirmar estado de pedido
// 048 Confirmar estado de cita
// 049 Confirmar imagen de mascota
// 050 Confirmar imagen de veterinario
