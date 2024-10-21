<template>
  <div class="home">
    <h1>Top 15 Stories</h1>
    <StoryList :stories="$store.state.topStories" />
    <button v-if="$store.state.topStories.length > 0" @click="loadMoreStories">Load More</button>
  </div>
</template>

<script>
import StoryList from '@/components/StoryList.vue'

export default {
  name: 'HomeView',
  components: {
    StoryList
  },
  mounted () {
    this.fetchTopStories()
  },
  methods: {
    fetchTopStories () {
      this.$store.dispatch('fetchTopStories')
    },
    loadMoreStories () {
      // Implemente a lógica para carregar mais histórias aqui
    }
  }
}
</script>
