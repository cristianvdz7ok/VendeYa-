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