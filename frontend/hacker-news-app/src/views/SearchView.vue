<template>
  <div class="search">
    <h1>Search Results</h1>
    <form @submit.prevent="performSearch">
      <input v-model="query" placeholder="Enter search term..." />
      <button type="submit">Search</button>
      <button type="button" @click="clearResults" :disabled="!hasResults">Clear</button>
    </form>
    <div v-if="loading">Searching...</div>
    <div v-else-if="error" class="error">{{ error }}</div>
    <div v-else-if="!hasResults">No results found.</div>
    <StoryList v-else :stories="$store.state.searchResults" />
  </div>
</template>

<script>
import StoryList from '@/components/StoryList.vue'

export default {
  name: 'SearchView',
  components: {
    StoryList
  },
  data () {
    return {
      query: '',
      loading: false,
      error: null
    }
  },
  computed: {
    hasResults () {
      return this.$store.state.searchResults && this.$store.state.searchResults.length > 0
    }
  },
  methods: {
    async performSearch () {
      if (!this.query.trim()) return

      this.loading = true
      this.error = null

      try {
        await this.$store.dispatch('searchStories', this.query)
      } catch (err) {
        this.error = err.message || 'Failed to search stories'
      } finally {
        this.loading = false
      }
    },
    clearResults () {
      this.$store.commit('clearSearchResults')
      this.query = ''
    }
  }
}
</script>
