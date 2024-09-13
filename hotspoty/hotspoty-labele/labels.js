/** start - labele */
labelsArray = [
    { name: 'new', cssClass: '--new', literal: <iai:variable vid="Nowość"/> },
    { name: 'bestseller', cssClass: '--bestseller', literal: <iai:variable vid="Nasz bestseller"/> },
    { name: 'discount', cssClass: '--discount', literal: <iai:variable vid="Przecena"/> },
    { name: 'distinguished', cssClass: '--distinguished', literal: <iai:variable vid="Polecany"/> },
    { name: 'productUnavailable', cssClass: '--disable', literal: <iai:variable vid="Chwilowo niedostępny"/> }
];

appendLabel = (labelClass, labelText) => {
  if(labelText.length) {
    this.setHtml('.label_icons', `<span class="label ${labelClass}">${labelText}</span>`)
  }
};

setLabels() {
  const labels = this.currProductsData.zones;
  if (!labels) return false;

  const isUnavailable = this.currProductsData.sizes?.every(size => size.availability?.status === 'disable');
  if (isUnavailable) {
    const unavailableLabel = this.labelsArray.find(label => label.name === 'productUnavailable');
    this.appendLabel(unavailableLabel.cssClass, unavailableLabel.literal);
    return false; 
  }

  const maxLabels = this.omnibusData ? 1 : 2;
  this.labelsArray
    .filter(label => labels.includes(label.name))
    .slice(0, maxLabels)
    .forEach(label => this.appendLabel(label.cssClass, label.literal));
}
/** end - labele */