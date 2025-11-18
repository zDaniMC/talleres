#  Taller Segundo Plano - José Daniel

Aplicación Flutter que demuestra el **manejo de tareas en segundo plano** usando:
- `Future`, `async` / `await` → asincronía controlada.
- `Timer` → temporización y ejecución periódica.
- `Isolate` → procesamiento pesado sin bloquear la UI.

Diseñada con un **tema oscuro moderno** y una interfaz minimalista con tres botones interactivos.

---

##  Características

| Funcionalidad | Descripción |
|----------------|--------------|
|  **Future / async / await** | Simula una consulta remota con `Future.delayed`. |
|  **Timer** | Ejecuta un contador o acción tras cierto tiempo. |
|  **Isolate** | Procesa una tarea intensiva (suma grande) sin afectar la UI. |

---

##  Flujo del Proyecto

1. **Pantalla principal** con texto informativo y tres botones.  
2. Cada botón ejecuta un proceso distinto:
   - **Future:** Espera 2 segundos antes de mostrar un resultado.
   - **Timer:** Muestra un mensaje después de 3 segundos.
   - **Isolate:** Realiza una operación matemática pesada en segundo plano.

---

##  Estructura del Proyecto

