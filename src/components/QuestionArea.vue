<template>
  <!-- Тута кароче строка ввода -->
    <div class="fixed bottom-0 left-0 right-0 flex gap-2 justify-center p-4">
      <textarea
        required
        v-model="inputValue"
        type="text"
        placeholder="My cool question"
        class="border-2 opacity-50 focus:opacity-100 hover:opacity-100 transition ease-in-out delay-250 bg-[#111111] border-[#1b1b1bec] focus:outline-none rounded resize-none w-full md:w-2/3 lg:w-3/4 xl:w-2/5 px-2 py-1"
        rows="1"
      />
      <button :disabled="sendTimeout" @click="sendMessage" class="bg-blue-500 text-white focus:outline-none px-[9.5px] py-1 rounded">
        <Icon icon="mingcute:send-line" width="1.4em" height="1.4em" />
      </button>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { Icon } from '@iconify/vue';
  import axios from 'axios';
  
  const props = defineProps(['selectedModel', 'link', 'messages']);
  const emit = defineEmits(['updateMessages']);
  
  const inputValue = ref('');
  const sendTimeout = ref(false);
  
  async function sendMessage() {
    if (sendTimeout.value || inputValue.value.trim() === '') return;
  
    const newMessage = {
      role: 'user',
      content: inputValue.value
    };
  
    emit('updateMessages', newMessage);
  
    sendTimeout.value = true;
  
    let dataToSend;
    switch (props.selectedModel) {
      case 'GPT3.5 Turbo':
        dataToSend = [{ role: 'user', content: inputValue.value }];
        break;
      case 'Blackbox':
        dataToSend = {
          model: 'blackbox',
          request: {
            messages: [{ role: 'user', content: inputValue.value }]
          }
        };
        break;
      case 'Gemini Pro':
        dataToSend = {
          model: 'gemini-pro',
          request: {
            messages: [{ role: 'user', content: inputValue.value }]
          }
        };
        break;
      case 'Gemini':
        dataToSend = {
          model: 'gemini',
          request: {
            messages: [{ content: inputValue.value }]
          }
        };
        break;
      default:
        dataToSend = [{ role: 'user', content: inputValue.value }];
    }
    inputValue.value = '';
    try {
      const response = await axios.post(props.link, dataToSend);
      const aiResponse = response.data.answer;
      emit('updateMessages', { role: 'ai', content: aiResponse });
    } catch (error) {
      console.error('Ошибка:', error);
    } finally {
      setTimeout(() => {
        sendTimeout.value = false;
      }, 5000);
    }
  }
  </script>
  