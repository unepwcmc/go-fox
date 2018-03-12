export const storeModal = {
  namespaced: true,

  state: {
    isActive: false,
  },

  mutations: {
    updateModalStatus () {
      this.state.modal.isActive = !this.state.modal.isActive
    }
  }
}