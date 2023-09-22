class ClientApp {
  int? id;
  String nome;
  String matricula;
  String email;
  String curso;
  String type;

  ClientApp({
    this.id,
    this.nome = '',
    this.matricula = '',
    this.email = '',
    this.curso = '',
    this.type = '',
  });

  factory ClientApp.fromJson(Map<String, dynamic> json) => ClientApp(
        id: json["id"],
        nome: json["nome"],
        matricula: json["matricula"],
        email: json["email"],
        curso: json["curso"],
        type: json["type"],
      );

  factory ClientApp.empty() => ClientApp(
        id: null,
        nome: '',
        matricula: '',
        email: '',
        curso: '',
        type: '',
      );
}
