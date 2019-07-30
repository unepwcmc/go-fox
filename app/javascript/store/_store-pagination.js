import { getPageIndices } from "../helpers/pagination-helpers";

export const storePagination = {
  namespaced: true,

  state: {
    page: 1,
    startIndex: 0,
    endIndex: 0,
    sectionItemTotals: [],
    itemsPerPage: 10,
    totalPages: 0,
    pageIndices: [],
    errors: 0
  },

  actions: {
    updateSectionItemTotals ({ commit }, sectionItemTotals ) {
      const pageIndices = getPageIndices(sectionItemTotals, this.state.pagination.itemsPerPage)

      commit('updateSectionItemTotals', sectionItemTotals)
      commit('updateTotalPages', pageIndices.length)
      commit('updatePageIndices', pageIndices)
    }
  },

  mutations: {
    updatePage (state, page) {
      this.state.pagination.page = page
    },

    updateStartIndex (state, startIndex) {
      this.state.pagination.startIndex = startIndex
    },

    updateEndIndex (state, endIndex) {
      this.state.pagination.endIndex = endIndex
    },

    updateSectionItemTotals (state, sectionItemTotals) {
      this.state.pagination.sectionItemTotals = sectionItemTotals
    },

    updateItemsPerPage (state, itemsPerPage) {
      this.state.pagination.itemsPerPage = itemsPerPage
    },

    updateTotalPages (state, totalPages) {
      this.state.pagination.totalPages = totalPages
    },

    updatePageIndices (state, pageIndices) {
      this.state.pagination.pageIndices = pageIndices
    },

    resetErrors () {
      this.state.pagination.errors = 0
    },

    updateErrors () {
      this.state.pagination.errors = this.state.pagination.errors + 1
    }
  }
}