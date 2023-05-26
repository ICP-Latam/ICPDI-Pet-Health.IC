import { PetHealth_backend } from "../../declarations/PetHealth_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();

  const nombre = document.getElementById("nombre").value.toString();
  const especie = document.getElementById("especie").value.toString();
  const raza = document.getElementById("raza").value.toString();
  const sexo = document.getElementById("sexo").value.toString();
  const color = document.getElementById("color").value.toString();
  const fecha_nacimiento = document.getElementById("fecha_nacimiento").value.toString();
  const senas_particulares = document.getElementById("senas_particulares").value.toString();

  const mascota = {
    nombre,
    especie,
    raza,
    sexo,
    color,
    fecha_nacimiento,
    senas_particulares,
    vacunas: []
  }

  //button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const mascotaRegistrada = await PetHealth_backend.registrarMascota(mascota);
  alert(`${mascotaRegistrada.nombre} ha sido registrado existosamente!! `);

});
