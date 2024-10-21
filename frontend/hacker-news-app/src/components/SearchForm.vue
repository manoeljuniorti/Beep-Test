<!-- src/components/SearchForm.vue -->
<template>
  <form @submit.prevent="performSearch">
    <input v-model="query" placeholder="Enter search term..." />
    <button type="submit">Search</button>
    <button type="button" @click="clearResults" :disabled="!hasResults">Clear</button>
  </form>
</template>

<script>
export default {
  name: 'SearchForm',
  data () {
    return {
      query: '',
      hasResults: false
    }
  },
  methods: {
    performSearch () {
      if (!this.query.trim()) return

      this.$store.dispatch('searchStories', this.query)
      this.hasResults = true
    },
    clearResults () {
      this.$store.commit('clearSearchResults')
      this.query = ''
      this.hasResults = false
    }
  }
}
</script>

<style scoped>
/* Adicione seus estilos aqui */
</style>
