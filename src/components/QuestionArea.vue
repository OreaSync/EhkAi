<template>
  <!-- Тута кароче строка ввода -->
    <div class="fixed left-0 right-0 bottom-0 flex gap-2 justify-center" ref="Area">
      <textarea
        required
        v-model="inputValue"
        type="text"
        placeholder="My cool question"
        class="border-2 opacity-50 focus:opacity-100 hover:opacity-100 overflow-y-hidden transition ease-in-out delay-250 bg-[#111111] border-[#1b1b1bec] focus:outline-none rounded resize-none w-full md:w-2/3 lg:w-3/4 xl:w-2/5 px-2 py-1"
        rows="1"
        />
      <button ref="SendButton" :disabled="sendTimeout" @click="sendMessage" class="bg-indigo-700 text-white focus:outline-none px-[9.5px] py-1 rounded">
        <Icon icon="mingcute:send-line" width="1.4em" height="1.4em" />
      </button>
    </div>
</template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import { Icon } from '@iconify/vue';
  import axios from 'axios';
  import gsap from 'gsap';
  
  const props = defineProps(['selectedModel', 'link', 'messages']);
  const emit = defineEmits(['updateMessages']);
  
  const inputValue = ref('');
  const sendTimeout = ref(false);
  const Area = ref(null);
  const SendButton = ref(null);
  
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
      case 'GPT-4o Mini':
        dataToSend = {model: 'gpt-4o-mini', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'GPT-4 Nexra':
        dataToSend = {model: 'nx-gpt-4', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'GPT-3.5 Turbo Nexra':
        dataToSend = {model: 'nx-gpt-3.5-turbo', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'Command-R+':
        dataToSend = {model: 'command-r+', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'Qwen':
        dataToSend = {model: 'qwen', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'Blackbox':
        dataToSend = {model: 'blackbox', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'Gemini Pro':
        dataToSend = {model: 'gemini-pro', request: {messages: [{ role: 'user', content: inputValue.value }]}};
        break;
      case 'Gemini':
        dataToSend = {model: 'gemini', request: {messages: [{ content: inputValue.value }]}};
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
onMounted(() => {
  gsap.fromTo(Area.value, { opacity: 0 }, { opacity: 1, y: -16, duration: 1 });
})
  </script>
  