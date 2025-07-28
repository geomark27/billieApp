# BillieOne - Sistema POS 📱💰

BillieOne es una aplicación completa de sistema POS (Point of Sale) desarrollada en Flutter, diseñada para gestionar ventas, inventario, clientes, proveedores y mucho más. La aplicación ofrece una solución integral para pequeñas y medianas empresas que necesitan digitalizar sus procesos de venta.

## 🚀 Características Principales

### 💼 Módulo de Ventas
- **Punto de Venta (POS)**: Interfaz intuitiva para ventas rápidas
- **Gestión de Ventas**: Crear, editar y consultar ventas
- **Facturación**: Generación automática de facturas
- **Múltiples Métodos de Pago**: Efectivo, tarjeta, transferencia
- **Sistema de Cupones**: Descuentos y promociones
- **Tarjetas de Regalo**: Gestión de gift cards
- **Entregas**: Control de entregas y logística
- **Devoluciones**: Procesamiento de devoluciones y reembolsos

### 📦 Control de Inventario
- **Gestión de Productos**: CRUD completo de productos
- **Categorías**: Organización por categorías y subcategorías
- **Control de Stock**: Seguimiento en tiempo real del inventario
- **Ajustes de Inventario**: Correcciones y ajustes de stock
- **Conteo de Stock**: Herramientas para inventarios físicos
- **Códigos de Barras**: Generación e impresión de códigos
- **Transferencias**: Movimientos entre almacenes
- **Historial**: Seguimiento de movimientos de productos

### 👥 Gestión de Personas
- **Clientes**: Base de datos completa de clientes
- **Proveedores**: Gestión de proveedores y contactos
- **Perfiles Detallados**: Información completa y historial
- **Segmentación**: Clasificación por tipos y categorías

### 💰 Sistema Contable
- **Ingresos**: Registro y seguimiento de ingresos
- **Gastos**: Control de gastos operativos
- **Reportes Financieros**: Estados financieros automáticos
- **Flujo de Caja**: Seguimiento de efectivo

### 📊 Reportes y Analytics
- **Dashboard Interactivo**: Métricas clave en tiempo real
- **Reportes de Ventas**: Análisis detallado de ventas
- **Reportes de Inventario**: Estado del stock y movimientos
- **Reportes Financieros**: Estados de resultados y balance
- **Analytics**: Tendencias y patrones de ventas

### 🏭 Manufactura
- **Órdenes de Producción**: Gestión de procesos productivos
- **Bill of Materials (BOM)**: Lista de materiales
- **Control de Calidad**: Seguimiento de estándares

### 👨‍💼 Recursos Humanos (HRM)
- **Gestión de Empleados**: Perfiles y datos del personal
- **Roles y Permisos**: Control de acceso granular
- **Asistencia**: Control de horarios y asistencia

### 🔧 Configuraciones Avanzadas
- **Personalización**: Configuración según necesidades del negocio
- **Temas**: Modo claro y oscuro
- **Multiidioma**: Soporte para múltiples idiomas
- **Backup**: Respaldo y restauración de datos

## 🛠️ Tecnologías Utilizadas

### Framework y Lenguaje
- **Flutter** (3.5.4+): Framework de desarrollo multiplataforma
- **Dart**: Lenguaje de programación optimizado para UI

### Gestión de Estado y Navegación
- **Provider** (6.1.2): Gestión de estado reactiva
- **SharedPreferences** (2.3.3): Persistencia local de datos

### UI/UX y Diseño
- **Google Fonts** (6.2.1): Tipografías personalizadas
- **HeroIcons** (0.11.0): Iconos consistentes
- **Font Awesome Flutter** (10.8.0): Librería de iconos extendida
- **Flutter Animate** (4.5.2): Animaciones fluidas
- **Lottie** (3.2.0): Animaciones complejas

### Networking y APIs
- **HTTP** (1.2.2): Cliente HTTP para comunicación con APIs
- **Cached Network Image** (3.4.1): Cache de imágenes de red

### Funcionalidades Específicas
- **OneSignal Flutter** (5.2.9): Notificaciones push
- **File Picker** (8.3.7): Selección de archivos
- **Flutter Barcode Scanner Plus** (3.0.8): Escaneo de códigos de barras
- **Flutter Dynamic Icon Plus** (1.2.1): Iconos dinámicos de la app
- **Quill HTML Editor V2** (2.2.10): Editor de texto enriquecido
- **Intl** (0.20.2): Internacionalización y formateo
- **Liquid Pull to Refresh** (3.0.1): Funcionalidad de "pull to refresh"
- **CountUp** (0.1.4): Animaciones de contadores
- **Awesome Snackbar Content** (0.1.4): Notificaciones in-app

### Herramientas de Desarrollo
- **Flutter Lints** (5.0.0): Reglas de linting para código limpio
- **Flutter Launcher Icons** (0.14.2): Generación de iconos para diferentes plataformas

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── api/                      # Servicios de API y comunicación con backend
│   ├── auth.dart            # Autenticación
│   ├── base.dart            # Cliente base para APIs
│   ├── client.dart          # Cliente HTTP
│   ├── dashboard.dart       # API del dashboard
│   └── get_registration_data.dart
├── constants/               # Constantes globales
│   ├── colors.dart          # Paleta de colores
│   ├── theme_colors.dart    # Colores por tema
│   ├── theme_fonts.dart     # Configuración de fuentes
│   └── theme_appearence.dart # Apariencia general
├── models/                  # Modelos de datos
│   ├── user.dart           # Modelo de usuario
│   ├── dashboard.dart      # Datos del dashboard
│   ├── data.dart           # Modelo de datos generales
│   ├── message.dart        # Mensajes
│   ├── nav_link.dart       # Enlaces de navegación
│   ├── role.dart           # Roles de usuario
│   └── short_payment.dart  # Pagos resumidos
├── providers/              # Gestión de estado con Provider
│   ├── common_data_provider.dart  # Datos comunes
│   └── theme_provider.dart        # Gestión de temas
├── screens/                # Pantallas de la aplicación
│   ├── auth/              # Sistema de autenticación
│   ├── home.dart          # Pantalla principal/dashboard
│   ├── sales/             # Módulo de ventas
│   │   ├── add_sale.dart        # Crear ventas
│   │   ├── edit_sale.dart       # Editar ventas
│   │   ├── sales_list.dart      # Lista de ventas
│   │   ├── pos/                 # Punto de venta
│   │   ├── invoice_generator.dart # Generador de facturas
│   │   ├── coupons/             # Sistema de cupones
│   │   ├── gift_cards/          # Tarjetas de regalo
│   │   └── delivery_list.dart   # Lista de entregas
│   ├── products/          # Gestión de productos
│   │   ├── add_product.dart     # Agregar productos
│   │   ├── edit_product.dart    # Editar productos
│   │   ├── product_list.dart    # Lista de productos
│   │   ├── categories/          # Categorías
│   │   ├── adjustments/         # Ajustes de inventario
│   │   ├── count_stocks/        # Conteo de stock
│   │   └── print_barcode.dart   # Impresión de códigos de barras
│   ├── people/            # Gestión de personas (clientes/proveedores)
│   ├── purchases/         # Módulo de compras
│   ├── accounting/        # Sistema de contabilidad
│   │   ├── incomes/           # Gestión de ingresos
│   │   └── expenses/          # Gestión de gastos
│   ├── reports/           # Sistema de reportes
│   ├── returns/           # Gestión de devoluciones
│   ├── quotations/        # Sistema de cotizaciones
│   ├── transfers/         # Transferencias de inventario
│   ├── settings/          # Configuraciones del sistema
│   ├── HRM/              # Recursos Humanos
│   ├── manufacturing/     # Módulo de manufactura
│   └── addons/           # Complementos adicionales
├── themes/               # Configuración de temas
│   ├── light_theme.dart  # Tema claro
│   └── dark_theme.dart   # Tema oscuro
├── utils/                # Utilidades y helpers
│   └── get_theme_color.dart # Utilidad para colores de tema
└── widgets/              # Widgets reutilizables
```

## 🏗️ Arquitectura de la Aplicación

### Patrón de Arquitectura
BillieOne utiliza el patrón **Provider** para la gestión de estado, proporcionando:
- **Separación de responsabilidades**: Lógica de negocio separada de la UI
- **Reactividad**: Actualizaciones automáticas de la interfaz
- **Escalabilidad**: Fácil mantenimiento y extensión del código

### Gestión de Estado
- **ThemeProvider**: Maneja el cambio entre tema claro y oscuro
- **CommonDataProvider**: Gestiona datos compartidos entre pantallas

### Comunicación con APIs
- **Cliente HTTP personalizado**: Manejo centralizado de peticiones
- **Autenticación**: Sistema seguro de login y gestión de sesiones
- **Manejo de errores**: Respuestas consistentes para errores de red

## 🚀 Instalación y Configuración

### Prerrequisitos

- Flutter SDK (>=3.5.4)
- Dart SDK
- Android Studio / VS Code
- Git

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/geomark27/billieApp.git
   cd billieApp
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar OneSignal** (opcional)
   - Agregar tu App ID de OneSignal en el código
   - Configurar las credenciales necesarias

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎨 Características de UI/UX

- **Material Design 3**: Diseño moderno y adaptativo
- **Modo Oscuro/Claro**: Soporte completo para ambos temas
- **Iconografía Consistente**: Uso de HeroIcons y FontAwesome
- **Animaciones Fluidas**: Transiciones suaves con Lottie y Flutter Animate
- **Responsive Design**: Adaptable a diferentes tamaños de pantalla
- **Tipografía**: Google Fonts para una experiencia visual mejorada

## 🔧 Configuración de Desarrollo

### Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto (si es necesario):

```env
API_BASE_URL=https://your-api-endpoint.com
ONESIGNAL_APP_ID=your-onesignal-app-id
```

### Scripts Útiles

```bash
# Limpiar proyecto
flutter clean && flutter pub get

# Generar iconos de la app
flutter pub run flutter_launcher_icons:main

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Build para producción (Android)
flutter build apk --release

# Build para producción (iOS)
flutter build ios --release
```

## 🤝 Contribución

Las contribuciones son bienvenidas. Para contribuir:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autor

**Zarif Sadman**
- Empresa: ZS Software Studio
- Website: [zarifprogrammer.com](https://zarifprogrammer.com/)

## 📞 Soporte

Si tienes alguna pregunta o necesitas soporte, puedes:

- Abrir un issue en GitHub
- Contactar al desarrollador a través de su website

---

## 📚 Recursos Adicionales de Flutter

- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [Cookbook de Flutter](https://docs.flutter.dev/cookbook)
- [Lab: Escribe tu primera app Flutter](https://docs.flutter.dev/get-started/codelab)
- [API Reference](https://api.flutter.dev/)

---

*Desarrollado con ❤️ usando Flutter*
