// dodatkowa metoda dla klasy GetHotspots
// wywołanie " setSizes(); " dodać w getHotspotProducts();
setSizes() {
  const sizes = this.currProductsData?.sizes;
  if (!sizes?.length || sizes.length === 1) return false;

  const sizesLabel = <iai:variable vid="Wybierz rozmiar"/>;
  
  const sizesItems = sizes.map(({ availability, id, name }) => `
    <span 
      class="product__size btn --outline" 
      role="button" 
      data-status="${availability?.status === 'disable' ? 'disabled' : 'enabled'}" 
      data-type="${id}"
    >
      ${name}
    </span>
  `).join('');

  const sizesHTML = `
    <div class='product__sizes'>
      <label class='product__size --label'>
        ${sizesLabel}
      </label>
      ${sizesItems}
    </div>
  `;

  this.setHtml('.product', sizesHTML, [], 'beforeend');
  return true;
}
