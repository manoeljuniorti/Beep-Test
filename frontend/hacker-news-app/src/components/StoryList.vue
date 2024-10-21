<template>
  <ul>
    <li v-for="story in stories" :key="story.id">
      <h2><a :href="story.url" target="_blank">{{ story.title }}</a></h2>
      <p v-if="story.score"><b>Score:</b> {{ formattedScore(story.score) }}</p>
      <p><b>Comments:</b></p>
      <ul v-if="story.comments && story.comments.length > 0">
        <li v-for="comment in story.comments.slice(0, 3)" :key="comment.id">
          {{ comment.text }}
          <p v-if="comment.user">— {{ comment.user }}</p>
          <p v-if="comment.time">Posted: {{ formatTime(comment.time) }}</p>
        </li>
        <li v-if="story.comments.length > 3">
          +{{ story.comments.length - 3 }} more comments
        </li>
      </ul>
      <p v-else-if="story.comments && story.comments.length === 0">No comments yet</p>
    </li>
  </ul>
</template>

<script>
export default {
  name: 'StoryList',
  props: ['stories'],
  methods: {
    formattedScore (score) {
      if (typeof score === 'number') {
        return score.toLocaleString()
      }
      return score
    },
    formatTime (time) {
      const date = new Date(time)
      return date.toLocaleString('en-US', { timeZone: 'UTC' })
    }
  }
}
</script>

<style scoped>
ul {
  list-style-type: none;
  padding: 0;
}

li {
  margin-bottom: 20px;
}

h2 {
  margin-top: 0;
}

a {
  color: #42b983;
  text-decoration: none;
}

a:hover {
  color: #2c3e50;
}
</style>
