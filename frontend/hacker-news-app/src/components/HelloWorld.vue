<template>
  <div class="home">
    <h1>Hacker News</h1>
    <input v-model="searchTerm" placeholder="Search stories..." />
    <ul>
      <li v-for="story in stories" :key="story.id">
        {{ story.title }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'HomeContent',
  data() {
    return {
      searchTerm: '',
      stories: []
    };
  },
  mounted() {
    this.fetchStories();
  },
  methods: {
    async fetchStories() {
      try {
        const response = await axios.get('https://api.hnpwa.com/v0/news/1.json');
        this.stories = response.data;
      } catch (error) {
        console.error('Error fetching stories:', error);
      }
    }
  }
};
</script>

<style scoped>
/* Adicione seus estilos aqui */
</style>
