/**
 *
 * @param {*} selector - nazwa selektora kafelka z banerem
 */
function addBannerToHotspots(selector) {
  document.querySelectorAll('.hotspot').forEach((hotspot) => {
    const template = document.querySelector(`template[data-id="${hotspot.id}"]`);
    const banner = template?.content?.querySelector(selector);
    if (!template || !banner) return;
    hotspot.querySelector('.products').prepend(banner);
    hotspot.querySelector('.products').scrollLeft = 0;
  });
}

// wywołanie w afterAllHotspotsCallback
addBannerToHotspots('.--banner');
