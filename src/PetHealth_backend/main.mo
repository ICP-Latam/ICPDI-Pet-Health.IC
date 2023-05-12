import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Debug "mo:base/Debug";

actor PetCarnet {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  type Dueno = Principal;

  //Definimos un tipo abstracto para las mascotas
  type Mascota = {
    especie: Text;
    raza : Text;
    sexo : Text;
    color: Text;
    nombre: Text;
    fecha_nacimiento: Text;
    senas_particulares: Text;
    vacunas: [Vacuna];
  };

  //Definimos un tipo abstracto para las vacunas
  type Vacuna = {
    fecha: Text;
    etiqueta: Blob;
    vacuna: Text;
    fecha_prox_vacuna: Text;
    firma_veterinario: Principal;
  };

  //Creamos el hashmap para almacenar las mascotas y sus vacunas
  let mascotas = HashMap.HashMap<Principal, Mascota>(0, Principal.equal, Principal.hash);
  

  //Definimos la funcion para registrar la informacion de una mascota
  public shared (msg) func registrarMascota(mascota : Mascota) : async Mascota {
    //Accesamos a la informacion del usuario o canister que llamo a la funcion
    let dueno : Principal = msg.caller;

    mascotas.put(dueno, mascota);

    Debug.print("La informacion de tu mascota ha sido almacenada correctamente " # Principal.toText(dueno) # " gracias! :)");
    return mascota;
  };

  //funcion que obtiene un mascota en caso de que exista en el HashMap
  public func getMascota(account : Principal): async ?Mascota {
    return mascotas.get(account);
  };

  //Definimos la funcion para registrar la informacion de la vacuna a una mascota
  public shared (msg) func registrarVacuna(vacuna : Vacuna): async [Vacuna] {
    //Accesamos a la informacion del usuario o canister que llamo a la funcion
    let dueno : Principal = msg.caller;
    
    let mascota: ?Mascota = await getMascota(dueno);

    switch (mascota) {
        case (?mascota ) {
          var mascota_vacunas = mascota.vacunas;
          mascota_vacunas := Array.append<Vacuna>(mascota_vacunas, [vacuna]);
          return mascota_vacunas;
        };
        case (null) {};
    };

    Debug.print("Una nueva vacuna ha sido registrada correctamente " # Principal.toText(dueno) # " Hasta la proxima visita! :)");
    return [];
  };

  //Total de dueños y mascota registrados
  public func getTotalMascotas() : async Int {
    //se obtiene el numero de elementos del HashMap como numero de mascotas
    mascotas.size();
  };
};
