export const storePagination = {
  namespaced: true,

  state: {
    page: 1,
    startIndex: 0,
    endIndex: 0,
    totalPageItems: 0,
    totalPages: 0,
    errors: 0
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

    updateTotalPageItems (state, totalPageItems) {
      this.state.pagination.totalPageItems = totalPageItems
    },

    updateTotalPages (state, totalPages) {
      this.state.pagination.totalPages = totalPages
    },

    resetErrors () {
      this.state.pagination.errors = 0
    },

    updateErrors () {
      this.state.pagination.errors = this.state.pagination.errors + 1
    }
  }
}