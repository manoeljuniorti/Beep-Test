// src/store/index.js
import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state: {
    topStories: [],
    searchResults: []
  },
  mutations: {
    setTopStories (state, stories) {
      state.topStories = stories
    },
    setSearchResults (state, results) {
      state.searchResults = results
    }
  },
  actions: {
    async fetchTopStories ({ commit }) {
      const response = await axios.get(`${process.env.VUE_APP_API_BASE_URL}/api/v1/stories`)
      commit('setTopStories', response.data)
    },
    async searchStories ({ commit }, query) {
      const response = await axios.get(`${process.env.VUE_APP_API_BASE_URL}/api/v1/stories/search`, {
        params: { query: query }
      })
      commit('setSearchResults', response.data)
    }
  }
})
