<template>
  <div id="app">
    <header>
      <nav>
        <router-link to="/">Home</router-link>
      </nav>
      <div class="search-container">
        <input v-model="searchQuery" placeholder="Search..." />
        <button @click="performSearch">Search</button>
      </div>
    </header>
    <main>
      <router-view></router-view>
    </main>
  </div>
</template>

<script>
export default {
  name: 'App',
  data () {
    return {
      searchQuery: ''
    }
  },
  methods: {
    performSearch () {
      if (this.searchQuery.trim()) {
        this.$router.push({ name: 'search', params: { query: this.searchQuery } })
      }
    }
  }
}
</script>

<style>
body {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  margin: 0;
  padding: 0;
}

#app {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

header {
  background-color: #f0f0f0;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

nav a {
  color: #2c3e50;
  text-decoration: none;
  font-size: 18px;
  font-weight: bold;
}

.search-container {
  display: flex;
  align-items: center;
}

input[type="text"], button {
  height: 40px;
  padding: 10px;
  font-size: 16px;
  border-radius: 4px;
}

input[type="text"] {
  width: 250px;
  border: 1px solid #ccc;
  border-right: none;
  border-radius: 4px 0 0 4px;
}

button {
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 0 4px 4px 0;
  cursor: pointer;
}

button:hover {
  background-color: #2c3e50;
}

main {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 20px;
}
</style>
