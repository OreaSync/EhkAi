<template>
  <div>
    <ModelSelector @selectModel="selectModel" />
    <Chat :messages="messages" :name="name" />
    <QuestionArea
      :selectedModel="selectedModel"
      :link="link"
      :messages="messages"
      @updateMessages="updateMessages"
    />
  </div>
</template>

<script setup>
import ModelSelector from './components/ModelSelector.vue';
import Chat from './components/Chat.vue';
import QuestionArea from './components/QuestionArea.vue';
import { ref } from 'vue';

const messages = ref([]);
const selectedModel = ref('GPT3.5 Turbo');
const link = ref('http://api.onlysq.ru/ai/v1');
const name = ref('GPT.3.5 Turbo');

function selectModel(model) {
  selectedModel.value = model;

  const modelSettings = {
    'GPT3.5 Turbo': { link: 'http://api.onlysq.ru/ai/v1', name: 'GPT.3.5 Turbo' },
    'Blackbox': { link: 'http://api.onlysq.ru/ai/v2', name: 'Blackbox AI' },
    'Gemini Pro': { link: 'http://api.onlysq.ru/ai/v2', name: 'Gemini Pro' },
    'Gemini': { link: 'http://api.onlysq.ru/ai/v2', name: 'Gemini' },
  };

  if (modelSettings[model]) {
    link.value = modelSettings[model].link;
    name.value = modelSettings[model].name;
  } else {
    link.value = 'http://api.onlysq.ru/ai/v1';
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
