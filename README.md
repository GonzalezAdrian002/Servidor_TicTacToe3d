# Servidor_TicTacToe3D

Servidor **Node.js + Socket.IO** para un juego de **TicTacToe 3D (4×4×4)** que funciona por **WAN** (Internet) desplegado en **Render**.  
Incluye un cliente de ejemplo en **Python (Tkinter + python-socketio)** para conectarse desde cualquier equipo y demostrar que **no depende de la red WiFi local**.

> ✅ Este proyecto cumple con la condición de evaluación del 100%: **comunicación por WAN mediante un servidor en la nube**, funcionando al 100% sin necesitar el WiFi local.

---

## ✨ Características
- Tablero 3D de 4×4×4 (64 casillas) con detección de todas las líneas ganadoras posibles.
- Gestión de **turnos**, **reinicio** y **desconexión** de jugadores.
- **Socket.IO** para comunicación en tiempo real entre cliente y servidor.
- **CORS** abierto para permitir clientes externos.
- Health-check HTTP en `GET /` para verificar que el servicio está activo.
- Cliente Python (Tkinter) visual con botones y resaltado de la línea ganadora.

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
├── build.bat                # Script para generar el .exe del cliente
└── tictactoe3d_client.py    # Cliente Python
```

---

## 🚀 Cómo probar el proyecto (para el profesor)
1. **Servidor en la nube**: Ya está desplegado en Render. No necesita instalar Node ni correr nada localmente.
2. **Cliente**:
   - Opción A: Usa el `.exe` que se entrega (más fácil).
   - Opción B: Genera el `.exe` con `build.bat`:
     ```bat
     build.bat --serverURL https://servidor-tictactoe3d.onrender.com
     ```
     El ejecutable aparecerá en `dist/TicTacToe3D.exe`.
3. Ejecuta el `.exe` en **dos PCs diferentes** (o dos instancias) para jugar.
4. Para demostrar WAN, usa **dos redes distintas** (por ejemplo, una PC en WiFi y otra en datos móviles).

---

## 🖥 Crear ejecutable (.exe) del cliente Python
Para facilitar la distribución:
- Requisitos: Windows 10/11, Python 3.9+.
- Pasos:
  1. Coloca `tictactoe3d_client.py` y `build.bat` en la misma carpeta.
  2. Ejecuta:
     ```bat
     build.bat --serverURL https://servidor-tictactoe3d.onrender.com
     ```
  3. El `.exe` se genera en `dist/`.

Opciones:
- `--console`: muestra consola para depuración.
- `--icon icon.ico`: agrega ícono.
- `--name MiTicTacToe3D`: cambia nombre del ejecutable.

---

## ✅ Cómo demostrar el 100%
- Mostrar la URL pública del servidor.
- Ejecutar el cliente en **dos redes distintas**.
- Jugar y comprobar que funciona sin depender de WiFi local.

---

## 👤 Autor
**Adrián González**  
Proyecto: **Servidor_TicTacToe3D** (Node.js + Socket.IO) + Cliente Python
