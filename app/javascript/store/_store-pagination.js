export const storePagination = {
  namespaced: true,

  state: {
    startIndex: 0,
    endIndex: 0
  },

  mutations: {
    updateStartIndex (state, startIndex) {
      this.state.pagination.startIndex = startIndex
    },

    updateEndIndex (state, endIndex) {
      this.state.pagination.endIndex = endIndex
    }
  }
}