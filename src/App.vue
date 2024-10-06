<template>
  <main>
    <ModelSelector @selectModel="selectModel" />
    <Chat :messages="messages" :name="name" />
    <QuestionArea
      :selectedModel="selectedModel"
      :link="link"
      :messages="messages"
      @updateMessages="updateMessages"
    />
  </main>
</template>

<script setup>
import ModelSelector from './components/ModelSelector.vue';
import Chat from './components/Chat.vue';
import QuestionArea from './components/QuestionArea.vue';
import { ref } from 'vue';

const messages = ref([]);
const selectedModel = ref('GPT3.5 Turbo');
const link = ref('https://api.onlysq.ru/ai/v1');
const name = ref('GPT.3.5 Turbo');

function selectModel(model) {
  selectedModel.value = model;

  const modelSettings = {
    'GPT3.5 Turbo': { link: 'https://api.onlysq.ru/ai/v1', name: 'GPT.3.5 Turbo' },
    'GPT-4o Mini': { link: 'https://api.onlysq.ru/ai/v2', name: 'GPT-4o Mini' },
    'GPT-4 Nexra': { link: 'https://api.onlysq.ru/ai/v2', name: 'GPT-4 Nexra' },
    'GPT-3.5 Turbo Nexra': { link: 'https://api.onlysq.ru/ai/v2', name: 'GPT-3.5 Turbo Nexra' },
    'Command-R+': { link: 'https://api.onlysq.ru/ai/v2', name: 'Command-R+' },
    'Qwen': { link: 'https://api.onlysq.ru/ai/v2', name: 'Qwen' },
    'Blackbox': { link: 'https://api.onlysq.ru/ai/v2', name: 'Blackbox AI' },
    'Gemini Pro': { link: 'https://api.onlysq.ru/ai/v2', name: 'Gemini Pro' },
    'Gemini': { link: 'https://api.onlysq.ru/ai/v2', name: 'Gemini' },
  };

  if (modelSettings[model]) {
    link.value = modelSettings[model].link;
    name.value = modelSettings[model].name;
  } else {
    link.value = 'https://api.onlysq.ru/ai/v1';
    name.value = 'Artificial Intelligence';
  }
}

function updateMessages(newMessage) {
  messages.value.push({
    ...newMessage,
    modelName: name.value
  });
}
</script>
