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

## 🗂 Estructura del repositorio

```
.
├── server.js                # Servidor Node.js con Socket.IO
├── package.json             # Dependencias y scripts (npm start)
├── .gitignore               # Opcional pero recomendado
├── render.yaml              # (Opcional) Configuración para Render
└── tictactoe3d_client.py    # Cliente Python (no necesario para Render)
```

> **Nota**: El servidor que corre en la nube solo necesita `server.js` y `package.json`.  
> El archivo `tictactoe3d_client.py` es para ejecutarlo en tu PC u otro dispositivo.

---

## 🌐 URL pública del servidor (Render)

> Reemplaza con tu URL si es distinta:

```
https://servidor-tictactoe3d.onrender.com
```

Puedes comprobar que el servidor está vivo visitando el **navegador** en esa URL:  
debería mostrar el texto: `Servidor TicTacToe 3D activo`.

---

## ⚙️ Requisitos

### Servidor (Node.js)
- Node.js **>= 18**
- npm (incluido con Node)

### Cliente (Python)
- Python 3.9+ (recomendado)
- Paquetes:
  - `python-socketio`
  - `tkinter` (suele venir por defecto; en Linux puede requerir `python3-tk`)

Instalación rápida del cliente:
```bash
pip install "python-socketio[client]"
# En Linux, si no tienes Tk:
# sudo apt-get install python3-tk
```

---

## 🚀 Ejecución local del servidor (desarrollo)

1. Instala dependencias:
   ```bash
   npm install
   ```

2. Arranca el servidor:
   ```bash
   npm start
   ```
   Salida esperada:
   ```
   Servidor TicTacToe 3D corriendo en puerto 3000
   ```

3. (Opcional) Prueba el health-check:  
   Abre `http://localhost:3000/` y deberías ver `Servidor TicTacToe 3D activo`.

> En local el servidor usa el puerto `3000`. En Render, usa automáticamente `process.env.PORT`.

---

## ☁️ Despliegue en Render (WAN)

### Opción A: Desde la interfaz de Render (rápido)
1. Crea un **nuevo servicio Web**.
2. Conecta tu repositorio de GitHub.
3. Establece:
   - **Runtime**: Node
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
4. Deploy. Cuando termine, Render mostrará tu **URL pública**.

### Opción B: Con `render.yaml` (opcional)
Si usas el archivo incluido:
```yaml
services:
  - type: web
    name: Servidor_TicTacToe3d
    env: node
    buildCommand: "npm install"
    startCommand: "npm start"
    autoDeploy: true
```

---

## 🕹 Uso del cliente (Python) por WAN

1. Edita en `tictactoe3d_client.py` la constante `SERVER_URL` si tu URL pública es distinta:
   ```python
   SERVER_URL = "https://servidor-tictactoe3d.onrender.com"
   ```

2. Ejecuta el cliente:
   ```bash
   python tictactoe3d_client.py
   ```

3. Abre el cliente en **dos equipos distintos** (o dos instancias) para tener **Jugador 1** y **Jugador 2**.  
   También puedes usar **datos móviles** en tu celular conectándose por hotspot para demostrar que **no depende del WiFi local**.

---

## 🔧 Eventos del Socket.IO (protocolo)

- **Servidor → Cliente**
  - `boardState`: estado inicial/tras reset  
    ```json
    {
      "board": [[[...]]], "currentPlayer": 1|2, "gameOver": false|true, "yourPlayer": 0|1|2
    }
    ```
  - `update`: actualización del tablero y turno  
    ```json
    {
      "board": [[[...]]], "currentPlayer": 1|2, "gameOver": false|true,
      "lastMove": {"x":0..3,"y":0..3,"z":0..3}
    }
    ```
  - `gameOver`: fin del juego  
    ```json
    { "winner": 1|2, "winLine": [[x,y,z], ...] }
    ```
  - `opponentLeft`: el oponente se desconectó  
    ```json
    { "leaver": 1|2 }
    ```

- **Cliente → Servidor**
  - `play`: realizar jugada  
    ```json
    { "x":0..3, "y":0..3, "z":0..3 }
    ```
  - `reset`: reiniciar partida (solo lo solicita Jugador 1)

---

## 🧪 Cómo demostrar el **100% (WAN)** al profesor

1. **Muestra la URL pública** de Render y el health-check (`GET /`).  
2. **Ejecuta el cliente en datos móviles** (por ejemplo, tu laptop conectada al hotspot del celular, o un segundo equipo fuera de la red local).  
3. Verifica que ambos clientes juegan y reciben eventos en tiempo real.  
4. Explica que el servidor corre **en la nube** y no requiere estar en la misma WiFi/LAN.

---

## 🩺 Solución de problemas (FAQ)

- **Render (plan Free) tarda en responder tras inactividad**  
  Es normal: la instancia “duerme” y puede demorar 50–60 s en “despertar”.  
  Espera unos segundos o vuelve a intentar.

- **CORS/Conexión bloqueada**  
  El servidor ya usa `cors({ origin: '*' })` y configura Socket.IO con CORS abierto.  
  Asegúrate de usar la **URL HTTPS** correcta.

- **El cliente no conecta**  
  - Verifica la **URL pública** en `SERVER_URL`.  
  - Asegúrate de que el deploy está **healthy** en Render (logs).  
  - Prueba el health-check en el navegador (`GET /`).

- **No se asignan dos jugadores**  
  - Cierra y vuelve a abrir el cliente para que se libere el slot.  
  - Si un jugador se desconecta, el servidor **resetea** el juego y emite `opponentLeft`.

---

## 🛡️ Justificación técnica

- El servidor escucha en `process.env.PORT || 3000` → Compatible con **Render** (la nube asigna el puerto).  
- `CORS` abierto y Socket.IO con CORS permite clientes desde **cualquier red** (WAN).  
- La presencia de `package.json` con `scripts.start = "node server.js"` asegura que Render puede arrancar el servicio.  
- La ruta `GET /` facilita pruebas rápidas y verificación desde navegador.

---

## 📄 Licencia

Este proyecto se distribuye con fines académicos.  
Puedes adaptarlo y reutilizarlo citando la fuente del trabajo.

---

## 👤 Autor

**Adrián González**  
Proyecto: **Servidor_TicTacToe3D** (Node.js + Socket.IO) + Cliente Python
