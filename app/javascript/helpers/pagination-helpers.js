export const getPageIndices = (sectionItemTotals, itemsPerPage = 10) => {
  const pageIndices = [];

  sectionItemTotals.forEach(sectionItems => {
    addPagesForSection(pageIndices, sectionItems, itemsPerPage);
  });

  return pageIndices;
};

const addPagesForSection = (pageIndices, sectionItems, itemsPerPage) => {
  let remainingSectionItems = sectionItems;

  while (remainingSectionItems > 0) {
    const currentPageItems = Math.min(remainingSectionItems, itemsPerPage);

    pageIndices.push({
      start: getNextStartIndex(pageIndices),
      end: getNextStartIndex(pageIndices) + currentPageItems - 1
    });

    remainingSectionItems -= currentPageItems;
  }
};

const getNextStartIndex = pageIndices =>
  pageIndices.length ? pageIndices[pageIndices.length - 1].end + 1 : 0;
