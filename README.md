# Servidor_TicTacToe3D

Servidor **Node.js + Socket.IO** para un juego de **TicTacToe 3D (4×4×4)** que funciona por **WAN** (Internet) desplegado en **Render**.  
Incluye un cliente compilado en **.exe** para Windows, listo para ejecutarse en dos PCs diferentes y demostrar que **no depende de la red WiFi local**.

> ✅ Este proyecto cumple con la condición de evaluación del 100%: **comunicación por WAN mediante un servidor en la nube**, funcionando al 100% sin necesitar el WiFi local.

---

## ✨ Características
- Tablero 3D de 4×4×4 (64 casillas) con detección de todas las líneas ganadoras posibles.
- Gestión de **turnos**, **reinicio** y **desconexión** de jugadores.
- **Socket.IO** para comunicación en tiempo real entre cliente y servidor.
- **CORS** abierto para permitir clientes externos.
- Health-check HTTP en `GET /` para verificar que el servicio está activo.
- Cliente visual (Tkinter) incluido como `.exe` para Windows.

---

## 🌐 URL pública del servidor (Render)
```
https://servidor-tictactoe3d.onrender.com
```
Abre esta URL en el navegador para comprobar que el servidor está activo.

---

## 🗂 Estructura del repositorio
```
.
├── server.js                # Servidor Node.js con Socket.IO
├── package.json             # Dependencias y scripts (npm start)
├── README.md                # Instrucciones completas
├── tictactoe3d_client.py    # Código fuente del cliente (opcional)
└── TicTacToe3D.exe          # Cliente compilado listo para usar
```

---

## 🚀 Cómo probar el proyecto (para el profesor)
1. **Servidor en la nube**: Ya está desplegado en Render. No necesita instalar Node ni correr nada localmente.
2. **Cliente**:
   - Descargue el repositorio y localice el archivo `TicTacToe3D.exe`.
   - Copie el `.exe` a **dos PCs diferentes** (o dos instancias en la misma PC).
3. Ejecute el `.exe` en cada PC:
   - Cada cliente se conectará al servidor en la nube y se asignará como **Jugador 1** y **Jugador 2**.
4. Para demostrar WAN, use **dos redes distintas** (por ejemplo, una PC en WiFi y otra en datos móviles).

---

## ✅ Cómo demostrar el 100%
- Mostrar la URL pública del servidor.
- Ejecutar el cliente `.exe` en **dos redes distintas**.
- Jugar y comprobar que funciona sin depender de WiFi local.

---

## 🧪 Solución de problemas
- Si el `.exe` no abre:
  - Verifique que Windows permita ejecutar aplicaciones descargadas (SmartScreen puede bloquear).
  - Si falla la conexión, asegúrese de que la URL del servidor esté activa.
- Si Render está inactivo, puede tardar 50–60 segundos en responder la primera vez.

---

## 👤 Autor
**Adrián González**  
Proyecto: **Servidor_TicTacToe3D** (Node.js + Socket.IO) + Cliente compilado (.exe)
