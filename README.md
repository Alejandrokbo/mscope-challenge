# Tech Lead Plan - mscope

Proyecto Gradle profesional para generar documentación técnica en PDF con diagramas UML.

## Características

✅ Build automatizado con **Gradle**
✅ Generación de PDF con **Asciidoctor PDF**
✅ Diagramas UML con **PlantUML**
✅ Tema personalizado profesional
✅ Numeración automática de secciones
✅ Tabla de contenidos clicable
✅ Syntax highlighting para código

## Requisitos

- **Java 11+** (para Gradle y PlantUML)
- **Gradle 8.5** (incluido via wrapper)

## Estructura del Proyecto

```
tech-lead-plan/
├── build.gradle                    # Configuración de build
├── settings.gradle                 # Configuración del proyecto
├── gradlew / gradlew.bat          # Gradle Wrapper
├── src/
│   └── docs/
│       ├── asciidoc/
│       │   ├── plan-tech-lead.adoc    # Documento principal
│       │   └── themes/
│       │       └── mscope-theme.yml   # Tema PDF personalizado
│       └── diagrams/
│           ├── arquitectura-general.puml
│           ├── microservicios.puml
│           ├── pipeline-cicd.puml
│           ├── modelo-multitenant.puml
│           └── arquitectura-ia.puml
└── build/
    ├── docs/pdf/                  # PDFs generados
    └── Plan_Tech_Lead_mscope.pdf  # PDF final
```

## Uso Rápido

### Windows

```batch
gradlew generatePdf
```

### Linux/Mac

```bash
./gradlew generatePdf
```

El PDF se genera en: `build/Plan_Tech_Lead_mscope.pdf`

## Comandos Disponibles

```bash
# Generar PDF completo (diagramas + documento)
gradlew generatePdf

# Solo generar diagramas UML
gradlew generateDiagrams

# Generar y abrir PDF automáticamente
gradlew openPdf

# Limpiar builds anteriores
gradlew clean

# Ver todas las tareas disponibles
gradlew tasks
```

## Diagramas UML Incluidos

1. **arquitectura-general.puml** - Vista general del sistema multipaís
2. **microservicios.puml** - Diagrama de componentes de microservicios
3. **pipeline-cicd.puml** - Pipeline de integración y despliegue continuo
4. **modelo-multitenant.puml** - Modelo de datos con RLS
5. **arquitectura-ia.puml** - Componentes de IA (Fraude, Bedrock, Churn)

## Personalización

### Modificar el Tema

Edita `src/docs/asciidoc/themes/mscope-theme.yml`:

```yaml
brand:
  primary: 2C5AA0    # Azul corporativo
  secondary: 5D8BC7  # Azul claro
  accent: E74C3C     # Color de acento
```

### Agregar Diagramas

1. Crear archivo `.puml` en `src/docs/diagrams/`
2. Ejecutar `gradlew generateDiagrams`
3. Referenciar en el `.adoc`:

```asciidoc
image::mi-diagrama.png[Mi Diagrama,align=center]
```

### Modificar Contenido

Edita `src/docs/asciidoc/plan-tech-lead.adoc` y ejecuta `gradlew generatePdf`

## Troubleshooting

### Error: "Java not found"

Instala Java 11 o superior:
- Windows: https://adoptium.net/
- Mac: `brew install openjdk@17`
- Linux: `sudo apt install openjdk-17-jdk`

### Error: "Could not find plantuml.jar"

Descarga PlantUML JAR:
```bash
mkdir -p lib
curl -L -o lib/plantuml.jar https://github.com/plantuml/plantuml/releases/download/v1.2023.13/plantuml-1.2023.13.jar
```

### Build lento la primera vez

Es normal. Gradle descarga dependencias (Ruby gems, etc).
Builds subsecuentes son mucho más rápidos (cache).

## CI/CD Integration

### GitHub Actions

```yaml
name: Generate PDF

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          java-version: '17'
      - run: ./gradlew generatePdf
      - uses: actions/upload-artifact@v3
        with:
          name: tech-lead-plan-pdf
          path: build/Plan_Tech_Lead_mscope.pdf
```

### GitLab CI

```yaml
build-pdf:
  image: openjdk:17-alpine
  script:
    - ./gradlew generatePdf
  artifacts:
    paths:
      - build/Plan_Tech_Lead_mscope.pdf
    expire_in: 30 days
```

## Ventajas de este Enfoque

✅ **Reproducible** - Cualquiera puede generar el mismo PDF
✅ **Versionable** - Todo en Git, incluyendo diagramas
✅ **Profesional** - Estándar de la industria (Gradle)
✅ **Automatizable** - Integrable en CI/CD
✅ **Mantenible** - Estructura clara y organizada
✅ **Escalable** - Fácil agregar más documentos o diagramas

## Contribuir

1. Editar archivos `.adoc` o `.puml`
2. Ejecutar `gradlew generatePdf`
3. Verificar el PDF generado
4. Commit y push

## Licencia

Proyecto creado para prueba técnica mscope - Tech Lead
