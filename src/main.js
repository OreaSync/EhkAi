import './assets/tailwind.css';
import { createApp } from 'vue';
import App from './App.vue';
import { Icon } from '@iconify/vue';

const app = createApp(App);
app.component('Icon', Icon);

app.mount('#app');
