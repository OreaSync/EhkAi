<template>
  <WelcomeTitle />
  <ModelSelector @selectModel="selectModel" />
  <Chat :messages="messages" :name="modelType" />
  <SearchBar
  :link="AiLink"
  :selectedModel="modelType"
  :messages="messages"
  @updateMessages="updateMessages"
  />
</template>
<script setup>
import SearchBar from './components/SearchBar.vue';
import Chat from './components/Chat.vue';
import ModelSelector from './components/SelectModel.vue';
import WelcomeTitle from './components/WelcomeTitle.vue';
import { ref } from 'vue';

const modelType = ref('GPT.3.5 Turbo')
const AiLink = ref('https://api.onlysq.ru/ai/v1');
const messages = ref([]);

function selectModel(model) {
  modelType.value = model;

  const modelSettings = {
    "GPT3.5 Turbo": {link: "https://api.onlysq.ru/ai/v1", name: "GPT.3.5 Turbo"},
    "GPT-4o Mini": {link: "https://api.onlysq.ru/ai/v2", name: "GPT-4o Mini"},
    "GPT-4 Nexra": { link: "https://api.onlysq.ru/ai/v2", name: "GPT-4 Nexra"},
    "GPT-3.5 Turbo Nexra": {link: "https://api.onlysq.ru/ai/v2", name: "GPT-3.5 Turbo Nexra"},
    "Command-R+": { link: "https://api.onlysq.ru/ai/v2", name: "Command-R+"},
    "Qwen": { link: "https://api.onlysq.ru/ai/v2", name: "Qwen"},
    "Blackbox": { link: "https://api.onlysq.ru/ai/v2", name: "Blackbox AI"},
    "Gemini Pro": { link: "https://api.onlysq.ru/ai/v2", name: "Gemini Pro"},
    "Gemini": { link: "https://api.onlysq.ru/ai/v2", name: "Gemini"},
    "Flux": { link: "https://api.onlysq.ru/ai/v2", name: "Flux"},
    "Kandinsky": { link: "https://api.onlysq.ru/ai/v2", name: "Kandinsky"},
    "NSFW-XL": { link: "https://api.onlysq.ru/ai/v2", name: "NSFW-XL"},
  };

  if (modelSettings[model]) {
    modelType.value = modelSettings[model].name;
    AiLink.value = modelSettings[model].link;
  } else {
    modelType.value = "Artificial Intelligence";
    AiLink.value = "https://api.onlysq.ru/ai/v1";
  }
}

function updateMessages(newMessage) {
  messages.value.push({
    ...newMessage,
    modelName: modelType.value,
  });
}
</script>