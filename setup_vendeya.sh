#!/usr/bin/env bash
set -euo pipefail

OWNER="cristianvdz7ok"
REPO="VendeYa"
COMMIT_MSG="Initial Vendeya site (static)"

echo "Creando carpeta $REPO ..."
mkdir -p "$REPO"
cd "$REPO"

echo "Generando archivos..."

cat > index.html <<'EOF'
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Vendeya — Publica y vende en Mercado Libre</title>
  <meta name="description" content="Vendeya: publicamos y gestionamos tus productos en Mercado Libre, tú recibes el pago menos una comisión por servicio." />
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <header class="site-header">
    <div class="container header-inner">
      <a class="brand" href="#">Vendeya</a>
      <button id="nav-toggle" class="nav-toggle" aria-label="Abrir menú">☰</button>
      <nav id="main-nav" class="main-nav">
        <ul>
          <li><a href="#inicio">Inicio</a></li>
          <li><a href="#como-funciona">Cómo funciona</a></li>
          <li><a href="#productos">Productos</a></li>
          <li><a href="#publicar">Publicar</a></li>
          <li><a href="#contacto">Contacto</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <section id="inicio" class="hero">
      <div class="container hero-content">
        <h1>Vendeya — Publica en Mercado Libre sin complicaciones</h1>
        <p>Vendeya publica y gestiona tus productos en Mercado Libre. Tú fijas el precio y, tras la venta, te pagamos el importe menos la comisión acordada por nuestro servicio.</p>
        <div class="hero-cta">
          <a class="btn primary" href="#publicar">Publicar producto</a>
          <a class="btn" href="#como-funciona">Cómo funciona</a>
        </div>
      </div>
    </section>

    <section id="como-funciona" class="container section">
      <h2>Cómo funciona</h2>
      <ol class="steps">
        <li><strong>1. Publicas tu producto:</strong> Completa el formulario con título, precio, descripción y fotos.</li>
        <li><strong>2. Vendeya lo publica:</strong> Gestionamos la publicación, optimización y promoción en Mercado Libre.</li>
        <li><strong>3. Venta en Mercado Libre:</strong> La transacción y el cobro al comprador ocurren en Mercado Libre.</li>
        <li><strong>4. Cobro y liquidación:</strong> Tras la venta te pagamos el importe contratado menos la comisión de Vendeya y otros fees acordados.</li>
      </ol>

      <div class="disclosure">
        <h3>Aclaración importante</h3>
        <p>
          Vendeya actúa como servicio gestor de publicaciones. No somos Mercado Libre ni procesamos pagos de compradores; las ventas y cobros se realizan mediante Mercado Libre. Nuestra comisión por servicio se aplica sobre el importe de la venta y se descuenta antes de la liquidación al vendedor.
        </p>
        <p class="muted">Ejemplo: la calculadora muestra por defecto una comisión del 10%. Las comisiones e impuestos cobrados por Mercado Libre o terceros no están incluidos en ese cálculo.</p>
      </div>
    </section>

    <section id="productos" class="container section">
      <h2>Productos publicados</h2>
      <div id="product-list" class="grid grid-3">
        <!-- Ejemplos iniciales -->
        <article class="card product">
          <div class="thumb">Imagen</div>
          <h3>Smartphone Modelo A</h3>
          <p class="price">ARS $ 120.000</p>
          <p class="muted small">Estado: Nuevo · Envío: Mercado Envíos</p>
          <div class="card-actions">
            <a class="btn" href="https://www.mercadolibre.com" target="_blank" rel="noopener">Ver en Mercado Libre</a>
            <button class="btn secondary btn-preview">Detalles</button>
          </div>
        </article>

        <article class="card product">
          <div class="thumb">Imagen</div>
          <h3>Audífonos Inalámbricos</h3>
          <p class="price">ARS $ 18.500</p>
          <p class="muted small">Estado: Nuevo · Envío: Retiro local</p>
          <div class="card-actions">
            <a class="btn" href="https://www.mercadolibre.com" target="_blank" rel="noopener">Ver en Mercado Libre</a>
            <button class="btn secondary btn-preview">Detalles</button>
          </div>
        </article>
      </div>
    </section>

    <section id="publicar" class="container section">
      <h2>Publicar producto</h2>
      <p>Completa los datos y Vendeya gestionará la publicación en Mercado Libre. (Versión demo: la publicación real requiere integración con la API de Mercado Libre y credenciales).</p>

      <form id="publish-form" class="publish-form" action="#" novalidate>
        <label> Título
          <input id="p-title" name="title" type="text" required placeholder="Ej: Lámpara LED moderna" />
        </label>

        <label> Precio (ARS)
          <input id="p-price" name="price" type="number" min="1" required placeholder="1000" />
        </label>

        <label> Descripción
          <textarea id="p-desc" name="description" rows="4" required placeholder="Breve descripción del producto"></textarea>
        </label>

        <label> Enlace a Mercado Libre (opcional)
          <input id="p-link" name="link" type="url" placeholder="https://www.mercadolibre.com.ar/..." />
        </label>

        <div class="form-actions">
          <button type="submit" class="btn primary">Publicar (simulado)</button>
          <button type="reset" class="btn">Limpiar</button>
        </div>

        <p id="publish-status" aria-live="polite" class="form-status"></p>
      </form>
    </section>

    <section id="contacto" class="container section">
      <h2>Calculadora de comisión</h2>
      <p>Usa esta calculadora para ver cuánto recibirías si vendes un producto con la comisión de Vendeya aplicada.</p>

      <div class="calc">
        <label>Precio de venta (ARS)
          <input id="calc-price" type="number" min="0" step="0.01" value="10000" />
        </label>

        <label>Comisión del servicio (%) — Vendeya
          <input id="calc-commission" type="number" min="0" max="100" step="0.1" value="10" />
        </label>

        <label>Otros descuentos/fees (ARS)
          <input id="calc-fees" type="number" min="0" step="0.01" value="0" />
        </label>

        <div class="calc-result">
          <p>Comisión Vendeya: <strong id="calc-commission-ars">ARS $0</strong></p>
          <p>Otros fees: <strong id="calc-fees-ars">ARS $0</strong></p>
          <p>Recibirás (estimado): <strong id="calc-net">ARS $0</strong></p>
        </div>
      </div>

      <div class="disclosure small muted">
        <p>Nota: este cálculo es una estimación. No incluye las comisiones cobradas por Mercado Libre ni impuestos adicionales. Para calcular el neto exacto, se requiere conocer todas las tarifas aplicables al caso específico.</p>
      </div>
    </section>
  </main>

  <footer class="site-footer">
    <div class="container footer-inner">
      <p>© <span id="year"></span> Vendeya · Servicio de gestión de publicaciones</p>
      <nav class="footer-links" aria-label="Enlaces de pie">
        <a href="#como-funciona">Cómo funciona</a>
        <a href="#publicar">Publicar</a>
        <a href="#contacto">Contacto</a>
      </nav>
    </div>
  </footer>

  <script src="script.js"></script>
</body>
</html>
EOF

cat > styles.css <<'EOF'
:root{
  --bg:#fffaf6;         /* cálido */
  --text:#0f1722;       /* azul muy oscuro para legibilidad */
  --muted:#566374;
  --primary:#ffb000;    /* amarillo cálido (confianza) */
  --accent:#0a66a0;     /* azul para botones y acentos */
  --success:#059669;
  --max-width:1100px;
  --radius:10px;
  font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
  --card-bg: #ffffff;
}

*{box-sizing:border-box}
html,body{height:100%}
body{
  margin:0;
  background:var(--bg);
  color:var(--text);
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
  line-height:1.5;
  font-size:16px;
}

/* Layout */
.container{
  max-width:var(--max-width);
  margin:0 auto;
  padding:1rem;
}

/* Header */
.site-header{
  border-bottom:1px solid rgba(15,23,34,0.06);
  background:linear-gradient(90deg, rgba(255,176,0,0.06), rgba(10,102,160,0.03));
  position:sticky;
  top:0;
  z-index:40;
}
.header-inner{
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:1rem;
}
.brand{
  font-weight:800;
  color:var(--accent);
  text-decoration:none;
  font-size:1.15rem;
}
.nav-toggle{
  display:none;
  background:none;
  border:0;
  font-size:1.5rem;
  cursor:pointer;
}
.main-nav ul{list-style:none;margin:0;padding:0;display:flex;gap:1rem}
.main-nav a{color:var(--muted);text-decoration:none;padding:.5rem .6rem;border-radius:8px}
.main-nav a:hover{background:rgba(10,102,160,0.06);color:var(--accent)}

/* Hero */
.hero{
  padding:3.5rem 0;
  background:linear-gradient(180deg, rgba(255,176,0,0.08), transparent);
}
.hero-content{padding:2rem 0;text-align:center}
.hero h1{margin:0 0 .5rem;font-size:clamp(1.5rem,3.5vw,2.2rem);color:var(--text)}
.hero p{color:var(--muted);margin:0 0 1.25rem}

/* Buttons */
.btn{
  display:inline-block;
  padding:.6rem .9rem;
  border-radius:8px;
  background:transparent;
  color:var(--accent);
  border:1px solid var(--accent);
  text-decoration:none;
  cursor:pointer;
  font-weight:600;
}
.btn.primary{
  background:var(--primary);
  color:#07263a;
  border-color:transparent;
}
.btn.secondary{
  background:transparent;
  color:var(--accent);
  border:1px solid rgba(10,102,160,0.12);
}
.btn + .btn{margin-left:.5rem}

/* Sections */
.section{padding:2rem 0}
h2{margin-top:0;color:var(--accent)}

/* Grid */
.grid{display:grid;gap:1rem}
.grid-3{grid-template-columns:repeat(3,1fr)}
.card{padding:1rem;border-radius:var(--radius);background:var(--card-bg);border:1px solid rgba(15,23,34,0.04);box-shadow:0 1px 2px rgba(15,23,34,0.02)}
.thumb{height:140px;background:linear-gradient(135deg,#fff6e6,#fff);display:flex;align-items:center;justify-content:center;border-radius:8px;color:var(--muted);margin-bottom:.75rem}

/* Product card */
.product h3{margin:.25rem 0}
.price{font-weight:700;color:var(--accent);margin:0 0 .35rem}
.muted{color:var(--muted)}
.small{font-size:.9rem}
.card-actions{display:flex;gap:.5rem;align-items:center;margin-top:.75rem}

/* Forms */
label{display:block;margin-bottom:.75rem;color:var(--muted);font-size:.95rem}
input[type="text"], input[type="number"], input[type="url"], textarea{
  width:100%;
  padding:.6rem;
  border:1px solid rgba(15,23,34,0.06);
  border-radius:8px;
  font-size:1rem;
  margin-top:.25rem;
  background:#fff;
}
.publish-form{max-width:720px}

/* Steps / disclosure */
.steps{padding-left:1.1rem;color:var(--muted)}
.disclosure{background:linear-gradient(180deg, rgba(10,102,160,0.03), transparent);padding:1rem;border-radius:8px;border:1px solid rgba(10,102,160,0.04);margin-top:1rem}
.disclosure h3{margin-top:0;color:var(--accent)}
.small{font-size:.9rem}

/* Calculator */
.calc{max-width:640px;display:grid;gap:.5rem}
.calc-result{background:#fff;padding:.75rem;border-radius:8px;border:1px solid rgba(15,23,34,0.04)}

/* Footer */
.site-footer{border-top:1px solid rgba(15,23,34,0.06);padding:1rem 0;margin-top:2rem}
.footer-inner{display:flex;align-items:center;justify-content:space-between;gap:1rem;flex-wrap:wrap}
.footer-links a{color:var(--muted);text-decoration:none;margin-left:.5rem}

/* Responsive */
@media (max-width:900px){
  .grid-3{grid-template-columns:repeat(2,1fr)}
}
@media (max-width:640px){
  .grid-3{grid-template-columns:1fr}
  .main-nav{position:absolute;top:64px;right:1rem;background:#fff;border:1px solid #eee;padding:.5rem;border-radius:8px;display:none}
  .main-nav.open{display:block}
  .nav-toggle{display:inline-block}
}
EOF

cat > script.js <<'EOF'
// Interacciones: menú, fecha, calculadora, publicar producto (simulado) — Vendeya
document.addEventListener('DOMContentLoaded', function () {
  // Año en pie de página
  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  // Toggle nav móvil
  const navToggle = document.getElementById('nav-toggle');
  const mainNav = document.getElementById('main-nav');
  if (navToggle && mainNav) {
    navToggle.addEventListener('click', () => {
      mainNav.classList.toggle('open');
    });
  }

  // Smooth scroll para enlaces internos
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const hash = this.getAttribute('href');
      if (hash.length > 1) {
        e.preventDefault();
        const target = document.querySelector(hash);
        if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        if (mainNav) mainNav.classList.remove('open');
      }
    });
  });

  // Publicar producto (simulado) — añade tarjeta localmente
  const publishForm = document.getElementById('publish-form');
  const productList = document.getElementById('product-list');
  const publishStatus = document.getElementById('publish-status');

  if (publishForm && productList) {
    publishForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const title = document.getElementById('p-title').value.trim();
      const price = parseFloat(document.getElementById('p-price').value);
      const desc = document.getElementById('p-desc').value.trim();
      const link = document.getElementById('p-link').value.trim();

      if (!title || !price || !desc) {
        publishStatus.textContent = 'Por favor completa todos los campos obligatorios.';
        publishStatus.style.color = 'crimson';
        return;
      }

      // Crear tarjeta de producto (simulado)
      const card = document.createElement('article');
      card.className = 'card product';
      card.innerHTML = `
        <div class="thumb">Imagen</div>
        <h3>${escapeHtml(title)}</h3>
        <p class="price">ARS $ ${formatNumber(price)}</p>
        <p class="muted small">${escapeHtml(desc.substring(0, 80))}${desc.length > 80 ? '…' : ''}</p>
        <div class="card-actions">
          <a class="btn" href="${link ? escapeHtml(link) : 'https://www.mercadolibre.com'}" target="_blank" rel="noopener">Ver en Mercado Libre</a>
          <button class="btn secondary btn-preview">Detalles</button>
        </div>
      `;
      productList.prepend(card);

      publishStatus.textContent = 'Producto publicado (simulado) en Vendeya. Revisa el listado arriba.';
      publishStatus.style.color = 'green';
      publishForm.reset();
    });
  }

  // Calculadora de comisión
  const calcPrice = document.getElementById('calc-price');
  const calcCommission = document.getElementById('calc-commission');
  const calcFees = document.getElementById('calc-fees');
  const outCommissionARS = document.getElementById('calc-commission-ars');
  const outFeesARS = document.getElementById('calc-fees-ars');
  const outNet = document.getElementById('calc-net');

  function updateCalc() {
    const price = parseFloat(calcPrice.value) || 0;
    const commissionPct = parseFloat(calcCommission.value) || 0;
    const fees = parseFloat(calcFees.value) || 0;
    const commissionAmt = (commissionPct / 100) * price;
    const net = price - commissionAmt - fees;
    outCommissionARS.textContent = 'ARS $ ' + formatNumber(commissionAmt);
    outFeesARS.textContent = 'ARS $ ' + formatNumber(fees);
    outNet.textContent = 'ARS $ ' + formatNumber(net >= 0 ? net : 0);
  }

  if (calcPrice && calcCommission && calcFees) {
    [calcPrice, calcCommission, calcFees].forEach(el => el.addEventListener('input', updateCalc));
    updateCalc();
  }

  // Helpers
  function formatNumber(n) {
    return Number(n).toLocaleString('es-AR', {maximumFractionDigits:2});
  }

  function escapeHtml(unsafe) {
    return unsafe.replace(/[&<"'>]/g, function(m) {
      return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]);
    });
  }
});
EOF

cat > README.md <<'EOF'
# Vendeya — Sitio para publicar productos en Mercado Libre (demo)

Vendeya es un servicio gestor que publica y promociona productos en Mercado Libre en nombre de vendedores. Este repositorio contiene una maqueta estática (HTML/CSS/JS) para mostrar el servicio, explicar el funcionamiento y estimar la comisión que Vendeya aplica por la gestión.

Qué incluye
- index.html — interfaz principal con secciones: Cómo funciona, Productos, Publicar, Calculadora.
- styles.css — estilos con paleta cálida y confiable.
- script.js — interacciones: menú, añadir producto (simulado) y calculadora de comisión.
- README.md — instrucciones y aclaraciones.

Aclaraciones legales y de servicio
- Vendeya es un servicio independiente; no somos Mercado Libre.
- La transacción con el comprador se realiza en Mercado Libre y los cobros pasan por su sistema.
- La comisión de Vendeya (por defecto 10% en la calculadora) se aplica sobre el importe de la venta y se descuenta antes de la liquidación al vendedor.
- Este demo no incluye las comisiones e impuestos que cobra Mercado Libre ni otras retenciones fiscales aplicables.

Cómo probar localmente
1. Guarda los archivos en una carpeta: index.html, styles.css, script.js, README.md.
2. Abre `index.html` en tu navegador. Para desarrollo con recarga: usa `live-server` o la extensión Live Server en VS Code.

Siguientes pasos recomendados (puedo ayudarte)
- Integrar la API oficial de Mercado Libre para publicar automáticamente (necesitaré credenciales y permisos).
- Añadir autenticación y un panel para vendedores (dashboard con historial de ventas y liquidaciones).
- Preparar contratos/aviso legal y política de privacidad adaptados a tu país.
- Subir el proyecto a un repo y desplegar en GitHub Pages o en un hosting con HTTPS.
EOF

cat > LICENSE <<'EOF'
MIT License

Copyright (c) 2025 cristianvdz7ok

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

mkdir -p .github/workflows
cat > .github/workflows/pages.yml <<'EOF'
name: Deploy static site to GitHub Pages

on:
  push:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Upload artifact for GitHub Pages
        uses: actions/upload-pages-artifact@v1
        with:
          path: './'

  deploy-pages:
    needs: build-deploy
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v1
EOF

echo "Inicializando git..."
git init
git add .
git commit -m "$COMMIT_MSG"
git branch -M main

echo "Creando repo remoto en GitHub (gh CLI) y empujando..."
gh repo create "$OWNER/$REPO" --public --source=. --remote=origin --push --confirm

echo "Habilitando GitHub Pages desde main (root)..."
gh api --method PUT "repos/$OWNER/$REPO/pages" -f source='{"branch":"main","path":"/"}' || true

echo -e "\nHecho. Repositorio creado: https://github.com/$OWNER/$REPO"
echo "GitHub Pages (puede tardar unos minutos en activarse): https://$OWNER.github.io/$REPO/"

echo "Si algo falla, revisa que 'gh auth status' muestre que estás autenticado con la cuenta correcta."
EOF