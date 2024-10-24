<template>
  <div
    class="fixed left-0 right-0 bottom-0 w-[90%] sm:w-[90%] md:w-[60%] lg:w-[40%] 2xl:w-[40%] mx-auto"
    ref="PromtArea"
  >
    <div class="relative w-full ">
      <textarea
        required
        rows="1"
        class="w-full px-3 py-2 mt-[2px] pr-[45px] overflow-hidden border rounded-full text-white bg-[#111111] border-[#1b1b1bec] focus:outline-none resize-none"
        placeholder="Ask Ai anything..."
        v-model="PromtValue"
      ></textarea>
      <button
        class="absolute right-1 top-[45%] transform -translate-y-1/2 bg-[#FFB88C] text-white rounded-full px-[10px] py-[4px] focus:outline-none focus:ring-none"
        :disabled="Timeout"
        @click="sendPromt"
        ref="SendButton"
      >
        <Icon
          icon="tabler:arrow-up"
          class="inline-block mb-[2px]"
          width="1.5em"
          height="1.5em"
          style="color: #1A1A1A;"
        />
      </button>
    </div>
  </div>
</template>

<script setup>
import { Icon } from "@iconify/vue";
import { ref, onMounted } from "vue";
import axios from "axios";
import gsap from "gsap";

const Timeout = ref(false);
const PromtArea = ref(null);
const SendButton = ref(null);
const PromtValue = ref("");

const props = defineProps(["selectedModel", "link", "messages"]);

const emit = defineEmits(['updateMessages']);

async function sendPromt() {
  if (Timeout.value || PromtValue.value.trim() === "") return;
  sendButtonClick()

  Timeout.value = true

  let dataToSend = [{role:"user", content: PromtValue.value }]

  switch (props.selectedModel) {
    case "GPT-4o Mini":
      dataToSend = {model: "gpt-4o-mini", request: {messages: [{ role: "user", content: PromtValue.value }]},}
      break;
    case "GPT-4 Nexra":
      dataToSend = {model: "nx-gpt-4",request: { messages: [{ role: "user", content: PromtValue.value }]},}
      break;
    case "GPT-3.5 Turbo Nexra":
      dataToSend = {model: "nx-gpt-3.5-turbo",request: { messages: [{ role: "user", content: PromtValue.value }] },}
      break;
    case "Command-R+":
      dataToSend = {model: "command-r+",request: { messages: [{ role: "user", content: PromtValue.value }]},}
      break;
    case "Qwen":
      dataToSend = {model: "qwen",request: { messages: [{ role: "user", content: PromtValue.value }]},}
      break;
    case "Blackbox":
      dataToSend = {model: "blackbox",request: { messages: [{ role: "user", content: PromtValue.value }] },}
      break;
    case "Gemini Pro":
      dataToSend = {model: "gemini-pro",request: { messages: [{ role: "user", content: PromtValue.value }] },}
      break;
    case "Gemini":
      dataToSend = {model: "gemini",request: { messages: [{ content: PromtValue.value }] },}
      break;
    case "Flux":
      dataToSend = {"model": "flux","request": {"messages": [{"content": PromtValue.value}]}}
      break;
    case "Kandinsky":
      dataToSend = {"model": "kandinsky","request": {"messages": [{"role": "user","content": PromtValue.value}],"meta": {"image_count": 1}}}
      break;
    case "NSFW-XL":
      dataToSend = {"model": "nsfw-xl","request": {"messages": [{"content": PromtValue.value}],"meta": {"type": 0}}}
      break;

    default:
      dataToSend = [{role:"user", content: PromtValue.value }]
      break;
  }

  const newMessage = {
    role: "user",
    content: PromtValue.value,
  };
  emit("updateMessages", newMessage);

  PromtValue.value = ''
  try {
    const response = await axios.post(props.link, dataToSend);
    let aiResponse = response.data.answer;

    if (props.selectedModel === "Flux" || props.selectedModel === "Kandinsky" || props.selectedModel === "NSFW-XL") {
      if (Array.isArray(aiResponse)) {
        aiResponse = aiResponse[0]; 
      }
      emit("updateMessages", { role: "aiImage", content: aiResponse });
    } else {
      emit("updateMessages", { role: "ai", content: aiResponse });
    }
    Timeout.value = false
  } catch (error) {
    console.log(error);
    Timeout.value = false
  }
}

const sendButtonClick = () => {
  gsap.fromTo(
    SendButton.value,
    { scale: 0.95 },
    { scale: 1, duration: 0.3, ease: "power1.inOut" }
  );
}

onMounted(() => {
  gsap.fromTo(
    PromtArea.value,
    { opacity: 0 },
    { opacity: 1, y: -4, duration: 1 }
  );
});
</script>
