export const getPageIndices = (sectionItemTotals, itemsPerPage = 10, maxPageCount = 6) => {
  const pageIndices = [];

  sectionItemTotals.forEach(sectionItems => {
    addPagesForSection(pageIndices, sectionItems, itemsPerPage, maxPageCount)
  })

  return pageIndices
}

const addPagesForSection = (pageIndices, sectionItems, itemsPerPage, maxPageCount) => {
  let remainingSectionItems = sectionItems

  while (remainingSectionItems > 0) {
    const isLastPage = pageIndices.length === maxPageCount - 1
    const currentPageItems = isLastPage ? remainingSectionItems : Math.min(remainingSectionItems, itemsPerPage)

    pageIndices.push({
      start: getNextStartIndex(pageIndices),
      end: getNextStartIndex(pageIndices) + currentPageItems - 1
    })

    remainingSectionItems -= currentPageItems
  }
}

const getNextStartIndex = pageIndices =>
  pageIndices.length ? pageIndices[pageIndices.length - 1].end + 1 : 0
