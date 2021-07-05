import 'package:mensajeria3/Pantallas/adicionar.dart';
import 'package:mensajeria3/Pantallas/perfil.dart';
import 'package:mensajeria3/modelos/mensajeros.dart';
import 'package:mensajeria3/peticiones/mensajeroshttp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaMensajeros extends StatefulWidget {
  ListaMensajeros({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListaMensajerosState createState() => _ListaMensajerosState();
}

class _ListaMensajerosState extends State<ListaMensajeros> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listados Mensajeros'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Mensajero',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AgregarMensajero()));
              })
        ],
      ),

      body: getInfo(context),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getInfo(context);
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context) {
  return FutureBuilder(
    future: listarPost(http
        .Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? Vistamensajeros(mensajeros: snapshot.data)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class Vistamensajeros extends StatelessWidget {
  final List<Mensajero> mensajeros;

  const Vistamensajeros({Key key, this.mensajeros}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mensajeros == null ? 0 : mensajeros.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Perfilmensajero(
                          perfil: mensajeros, idperfil: posicion)));
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              child: Image.network(mensajeros[posicion].foto),
            ),
            title: Text(mensajeros[posicion].nombre),
            subtitle: Text(mensajeros[posicion].moto),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(mensajeros[posicion].placa),
            ),
          );
        });
  }
}
