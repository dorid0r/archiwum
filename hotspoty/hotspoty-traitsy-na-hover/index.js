setTraits() {
  const { awardedParameters: traits } = this.currProductsData;
  const forbiddenIds =  new Set([2052]); // szybsze szukanie jako has niż includes w array
  if(!traits?.length) return false;

  const traitsHtml = () => {
    let traitsHtml = '';
    traits.forEach(({ id, name, values }) => {
      if (!name.includes('gs1:') && !forbiddenIds.has(id)) {
        traitsHtml += 
        `<li class="trait">
           <span class="trait__name">${name}:</span>
           <span class="trait__values">
           ${values.map(({link,name}) => `<a class="trait__value" href="${link}">${name}</a>`).join(', ')}
           </span>
         </li>`;
      }
    });
    return traitsHtml;
  }  

  if (traitsHtml) {
    this.setHtml('.product', `<div class="product__traits"><ul>${traitsHtml()}</ul></div>`);
    return true;
  }

  return false;
}